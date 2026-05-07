---
name: "project-prompt-run"
description: "Batch-execute multiple prompts from the queue in sequence. Each prompt runs in an isolated subagent so the main loop retains state across the full batch. Gracefully handles token/rate-limit errors. Use this to process all waiting prompts or a specific count in one go."
metadata:
  author: "worlds-biggest-software-project"
user-invocable: true
disable-model-invocation: false
---

## Purpose
Run multiple prompts from the queue sequentially. Each prompt executes in a dedicated subagent — the main loop is never cleared, so it can track progress, update queue files, and continue to the next prompt without losing state.

## Usage
```
/project-prompt-run [optionalNumberOfPrompts]
```

### Parameters
- `optionalNumberOfPrompts` (optional): Maximum number of prompts to execute. If omitted, runs all waiting prompts until the queue is empty.

## Behavior

1. **Parse parameter**:
   - If a number is provided, use it as the maximum count
   - If omitted, set count to "unlimited" (process all waiting prompts)

2. **Ensure queue subdirectories exist**:
   ```bash
   mkdir -p prompt-queue/complete prompt-queue/failed
   ```

3. **Loop — repeat until count reached or queue empty**:

   a. **Find next waiting prompt**:
      ```bash
      grep -rl "Status: waiting" prompt-queue/*.md 2>/dev/null | sort | head -1
      ```
      If none found, stop with reason `queue_empty`.

   b. **Claim the prompt** (mark as running to prevent double-execution):
      - Read the file to extract the `Prompt:` field value
      - Update the file: replace `Status: waiting` → `Status: running`

   c. **Spawn a subagent** using the `Agent` tool:
      - `description`: short label from the filename (e.g. `"research-001-ai-code-review"`)
      - `prompt`: the exact text extracted from the `Prompt:` field, plus this suffix:
        ```
        Working directory: /opt/Development/Projects/worlds-biggest-software-project
        Complete the task fully. Do not ask clarifying questions.
        ```
      - Do **not** pass `run_in_background` — wait for the subagent to finish before continuing.
      - Do **not** spawn more than one subagent at a time. The loop is strictly serial: one subagent runs, finishes, then the next starts.
      - Do **not** interpret, optimise, or batch the prompt — pass it verbatim to the subagent.

   d. **MANDATORY: Handle the subagent result** — these steps MUST execute before starting the next prompt:

      **On success** (subagent returned without error):
      1. Edit the prompt file: replace `Status: running` with `Status: complete`
      2. Run: `mv prompt-queue/<filename> prompt-queue/complete/<filename>`
      3. Confirm the mv succeeded before continuing

      **On error / exception** (subagent threw or reported failure):
      1. Edit the prompt file: replace `Status: running` with `Status: error`
      2. Append to the prompt file:
         ```
         ## Error
         <error details from subagent>
         ```
      3. Run: `mv prompt-queue/<filename> prompt-queue/failed/<filename>`
      4. Confirm the mv succeeded before continuing

      > ⚠️ Do NOT skip these steps. Do NOT proceed to the next prompt until the file has been edited AND moved.

   e. **Decrement remaining count** (if a limit was set), then repeat from step 3a.

4. **Stop conditions** — exit the loop when any of these occur:
   - No waiting prompts remain → `queue_empty`
   - Count limit reached → `count_limit`
   - Subagent reports token exhaustion → `token_limit` (stop immediately; do not start next prompt)
   - Subagent reports 429 / quota exceeded → `rate_limit` (stop immediately; report retry guidance)

5. **Report summary**:

```
📊 Summary:
  ✅ N prompts executed
  ✅ N completed successfully
  ❌ N failed (if any)
  ⏳ N waiting prompts remain
  🛑 Stop reason: <queue_empty | count_limit | token_limit | rate_limit>
```

## Why subagents instead of /clear

`/clear` wipes the entire conversation context, including the loop state maintained by this skill. After a `/clear`, the orchestrator has no memory of how many prompts remain, which files to update, or that it was looping at all — execution stops after one prompt.

Subagents run in an isolated context by design. The main conversation retains full state (loop counter, file paths, running totals) while each subagent gets a clean slate to execute its prompt without interference from previous runs.

## Example Output

```
🚀 Running up to 3 prompts sequentially...

[1/3] research-001-ai-code-review-platform
  → Spawning subagent...
  ✅ Complete → moved to prompt-queue/complete/

[2/3] research-002-intelligent-test-generator
  → Spawning subagent...
  ✅ Complete → moved to prompt-queue/complete/

[3/3] research-003-dependency-security-auditor
  → Spawning subagent...
  ✅ Complete → moved to prompt-queue/complete/

📊 Summary:
  ✅ 3 prompts executed
  ✅ 3 completed successfully
  ⏳ 471 waiting prompts remain
  🛑 Stop reason: count_limit
```

## Example Output (Rate Limit Hit)

```
[2/10] research-002-intelligent-test-generator
  → Spawning subagent...
  ⚠️  Rate limit exceeded (429)

📊 Summary:
  ✅ 1 prompts executed
  ✅ 1 completed successfully
  ⏳ 472 waiting prompts remain
  🛑 Stop reason: rate_limit
  ℹ️  Retry after: ~60 seconds — run /project-prompt-run to resume
```

## Error Handling

- **Token limit**: Detected from subagent result text; stop immediately, leave remaining prompts as `waiting`
- **Rate limit**: Detected from 429 response or quota-exceeded message; stop immediately with retry guidance
- **Other errors**: Mark prompt as `error`, move to `failed/`, continue to next prompt
- **Resumability**: All unexecuted prompts remain `waiting`; re-run `/project-prompt-run` to continue from where it left off

---
name: "project-prompt-next"
description: "Execute the next prompt from the queue. Runs the oldest waiting prompt, handles success/failure, and moves it to the appropriate subdirectory. Use this to process queued tasks one at a time."
metadata:
  author: "worlds-biggest-software-project"
user-invocable: true
disable-model-invocation: false
---

## Purpose
Run the next waiting prompt from the queue and handle the result (success or error).

## Usage
```
/project-prompt-next
```

## Behavior

1. **Find waiting prompt**:
   - Search `prompt-queue/` for `.md` files with `Status: waiting`
   - Select the one with the lowest sequence number (oldest first)
   - If none found, report "No waiting prompts" and exit

2. **Update status**: Change `Status: waiting` to `Status: running` in the file

3. **Extract and execute**: 
   - Extract the prompt text from the `Prompt:` field
   - Execute the prompt (run it as if the user had typed it)
   - Capture any output, errors, or results

4. **MANDATORY On Success** — these steps MUST execute before reporting done:
   - Edit the file: replace `Status: running` with `Status: complete`
   - Run: `mv prompt-queue/<filename> prompt-queue/complete/<filename>`
   - Confirm mv succeeded, then report success

5. **MANDATORY On Error** — these steps MUST execute before reporting done:
   - Edit the file: replace `Status: running` with `Status: error`
   - Append to the file using the Edit tool:
     ```
     ## Error
     <error details>
     ```
   - Run: `mv prompt-queue/<filename> prompt-queue/failed/<filename>`
   - Confirm mv succeeded, then report the error

> ⚠️ Do NOT skip steps 4 or 5. The file MUST be edited AND moved before this skill is considered complete.

## Example

**Before:**
```
prompt-queue/0001-test-framework-research.md
Status: waiting
Prompt: research the top nodejs testing frameworks
```

**After (success):**
```
prompt-queue/complete/0001-test-framework-research.md
Status: complete
Prompt: research the top nodejs testing frameworks
```

**After (error):**
```
prompt-queue/failed/0001-test-framework-research.md
Status: error
Prompt: research the top nodejs testing frameworks

## Error
Failed to execute prompt: [error details]
```

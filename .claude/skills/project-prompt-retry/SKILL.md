---
name: "project-prompt-retry"
description: "Move a failed prompt from the failed queue back to waiting so it can be re-executed. Useful for retrying prompts that encountered transient errors."
argument-hint: "Sequence number (e.g. 0001) or a substring of the filename"
compatibility: "Requires prompt-queue/ directory structure with failed/ subdirectory"
metadata:
  author: "worlds-biggest-software-project"
user-invocable: true
disable-model-invocation: false
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

Your goal is to recover a failed prompt by moving it from `prompt-queue/failed/` back to `prompt-queue/waiting/`, allowing it to be re-executed via `/project-prompt-next` or `/project-prompt-run`.

This is useful when a prompt fails due to a transient error (network timeout, rate limit, temporary service issue) and you want to retry it without manually editing the file.

---

## Step 1 — Identify the Failed Prompt

Parse `$ARGUMENTS` to find the target prompt:

- **Sequence number only** (e.g. `0001`, `1`): Match the file `prompt-queue/failed/<number>-*.md`
- **Filename substring** (e.g. `test-framework`, `0001-test`): Match any file in `prompt-queue/failed/` whose name contains the substring (case-insensitive)

If `$ARGUMENTS` is empty, output:
```
ERROR: No prompt specified. Usage: /project-prompt-retry <sequence-number|filename-substring>
```
and stop.

---

## Step 2 — Search for the Prompt File

Search `prompt-queue/failed/` for a `.md` file matching `$ARGUMENTS`:

- If exactly one file matches, proceed to Step 3
- If zero files match, output:
  ```
  ERROR: No failed prompt matching "<ARGUMENTS>" found in prompt-queue/failed/
  ```
  and stop.
- If multiple files match, list them and ask the user to be more specific:
  ```
  Multiple prompts match "<ARGUMENTS>":
    0001-test-framework-research.md
    0042-test-coverage-analysis.md
  Please be more specific.
  ```
  and stop.

Set `PROMPT_FILE` to the matched file path.

---

## Step 3 — Read the Prompt File

Read `PROMPT_FILE` and extract:
- The `Status:` field (should be `error`)
- The `Prompt:` field (the original prompt text)
- Any `## Error` section (the previous error message)

If the `Status:` is not `error`, output:
```
ERROR: Prompt <FILENAME> has status "<STATUS>", not "error". Cannot retry.
```
and stop.

---

## Step 4 — Move to Waiting

1. **Update status**: Change `Status: error` to `Status: waiting` in the file
2. **Remove error section**: Delete the entire `## Error` section if present
3. **Restore to waiting queue**: Move the file from `prompt-queue/failed/<filename>` to `prompt-queue/<filename>` (back to the main queue)

The file should now look like:
```
Status: waiting
Prompt: [original prompt text]
```

---

## Step 5 — Report

Output:
```
✅ Moved to retry queue: <FILENAME>

Prompt: [first 80 chars of prompt text]
Status: waiting (ready to execute)

Previous error: [first line of previous ## Error section]

Next steps:
  • Run /project-prompt-next to execute immediately
  • Run /project-prompt-run to execute with other waiting prompts
```

---

## Notes

- Retrying a prompt does not reset any context — it will execute from scratch as if it were a new prompt
- If the retry fails with the same error, it will be moved to `prompt-queue/failed/` again
- You can retry a prompt multiple times if needed

---
name: "project-prompt-status"
description: "Show the status of all queued prompts. Displays waiting, running, failed, and completed prompts with counts and details. Use this to check what work is pending or has failed in the queue."
metadata:
  author: "worlds-biggest-software-project"
user-invocable: true
disable-model-invocation: false
---

## Purpose
Display the status of all prompts in the queue, showing waiting and failed prompts with their details.

## Usage
```
/project-prompt-status
```

## Behavior

1. **Scan prompt queue**:
   - Look in `prompt-queue/` directory and all subdirectories
   - Find all `.md` files with `Status:` field

2. **Display waiting prompts**:
   - List all prompts with `Status: waiting` 
   - Show: sequence number, summary (from filename), and first line of prompt
   - Order by sequence number (oldest first)

3. **Display failed prompts**:
   - List all prompts in `prompt-queue/failed/` with `Status: error`
   - Show: sequence number, summary, error message (first line of `## Error` section)
   - Order by sequence number

4. **Display complete prompts** (optional):
   - Show count of completed prompts
   - Optionally list recent completions

5. **Summary**:
   - Total counts: waiting, running, failed, complete
   - Quick status overview

## Example Output

```
📋 Prompt Queue Status

⏳ Waiting (3 prompts):
  0001 - research-top-frameworks       | research the top nodejs testing frameworks
  0003 - refactor-auth-middleware      | refactor authentication middleware for new design
  0005 - add-documentation             | add API documentation to core endpoints

❌ Failed (1 prompt):
  0002 - investigate-performance       | Error: Rate limit exceeded during research

✅ Complete: 5 prompts
📊 Summary: 3 waiting, 0 running, 1 failed, 5 complete
```

---
name: "project-prompt-enqueue"
description: "Queue a prompt for later execution. Enqueues a task to the prompt-queue/ directory so you can run it later with /project-prompt-next or /project-prompt-run. Use this to batch up research tasks, content generation, or other work to process in sequence."
metadata:
  author: "worlds-biggest-software-project"
user-invocable: true
disable-model-invocation: false
---

## Purpose
Enqueue a prompt to be run later via `/project-prompt-next`.

## Usage
```
/project-prompt-enqueue [prompt text]
```

## Behavior

1. **Extract summary**: Take the first 3-5 words from the prompt as a summary (kebab-cased)
2. **Find next sequence number**: 
   - Scan `prompt-queue/` (and subdirectories `waiting/`, `running/`, `complete/`, `failed/`)
   - Find the highest numeric prefix used
   - Increment by 1, zero-padded to 4 digits (e.g., 0000, 0001, 0042)
3. **Create prompt file**: Write to `prompt-queue/[number]-[summary].md` with format:
   ```
   Status: waiting
   Prompt: [full prompt text]
   ```
4. **Confirmation**: Return the file path and sequence number

## Example
Input: `/project-prompt-enqueue research the top 5 testing frameworks for nodejs`

Output: Created `prompt-queue/0042-research-top-5-testing.md`

```
Status: waiting
Prompt: research the top 5 testing frameworks for nodejs
```

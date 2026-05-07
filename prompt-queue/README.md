# Prompt Queue System

A system for enqueueing and executing prompts asynchronously using Claude Code skills.

## Directory Structure

- **`prompt-queue/`** — Main queue directory with waiting/pending prompts
- **`prompt-queue/complete/`** — Successfully executed prompts
- **`prompt-queue/failed/`** — Prompts that encountered errors

## File Format

Prompt files use the naming pattern: `[number]-[summary].md`

Example: `0042-research-testing-frameworks.md`

### Prompt File Format

```
Status: waiting
Prompt: Your prompt text here
```

After execution, the file is updated with the result status and moved to the appropriate directory.

## Skills

### 1. `/project-prompt-enqueue [prompt]`
Enqueue a new prompt for later execution.

**Usage:**
```
/project-prompt-enqueue research the top nodejs testing frameworks
```

**Output:** Creates `prompt-queue/0001-research-top-nodejs.md` with:
```
Status: waiting
Prompt: research the top nodejs testing frameworks
```

### 2. `/project-prompt-next`
Execute the next waiting prompt in the queue.

**What it does:**
- Finds the oldest prompt with `Status: waiting`
- Updates status to `running`
- Executes the prompt
- On success: Updates status to `complete` and moves file to `prompt-queue/complete/`
- On error: Updates status to `error`, adds error details, and moves to `prompt-queue/failed/`

**Usage:**
```
/project-prompt-next
```

### 3. `/project-prompt-status`
Display the status of all prompts in the queue.

**Output:**
- List of waiting prompts (ordered by sequence number)
- List of failed prompts with error messages
- Summary counts

**Usage:**
```
/project-prompt-status
```

## Workflow Example

1. Enqueue multiple prompts:
   ```
   /project-prompt-enqueue research testing frameworks
   /project-prompt-enqueue refactor auth middleware
   /project-prompt-enqueue add api documentation
   ```

2. Check queue status:
   ```
   /project-prompt-status
   ```

3. Execute prompts one by one (or use `/loop` to run repeatedly):
   ```
   /project-prompt-next
   /project-prompt-next
   /project-prompt-next
   ```

4. Review completed prompts in `prompt-queue/complete/`
5. Fix and retry failed prompts from `prompt-queue/failed/`

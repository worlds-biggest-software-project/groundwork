---
name: "project-push-all"
description: "Push all candidate projects under projects/ to GitHub. Initializes git, creates remotes, commits changes, and pushes each project to origin in one batch operation."
argument-hint: "Optional: comma-separated project numbers/names to filter (e.g., '1,2,3' or 'feature-flag,auth-middleware')"
compatibility: "Requires gh CLI authenticated and internet access; must be run from the repo root"
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

Your goal is to push all (or filtered) candidate projects to GitHub in a single batch operation. This is more efficient than calling `/project-push-to-github` once per project.

For each project:
1. Initialize git if needed
2. Create GitHub remote if needed
3. Commit outstanding changes as "WIP"
4. Push to origin

---

## Step 1 — Parse Arguments and Discover Projects

Parse `$ARGUMENTS`:

- **Empty**: Discover **all** projects under `projects/` (process everything)
- **Comma-separated list**: Filter by project identifiers:
  - Numeric (e.g. `1,2,3`) → match directories starting with `001-`, `002-`, `003-`
  - Names (e.g. `feature-flag,auth`) → match directories containing these substrings
  - Mix (e.g. `1,feature-flag,15`) → match numeric prefixes and name substrings

If invalid syntax, output:
```
ERROR: Invalid argument format. Usage: /project-push-all [<number,name,number> ...]
```
and stop.

---

## Step 2 — Discover and Filter Projects

Scan the `projects/` directory for all subdirectories. For each:
- Extract the candidate number (numeric prefix) and project slug
- If `$ARGUMENTS` is empty, include all projects
- Otherwise, include only projects matching the filter (by number or substring)

Create a list of **target projects** in order (sorted by candidate number, ascending).

Report to the user:
```
🔍 Discovered <N> projects in projects/

Filtered to push: <M> projects
  <list each with number, name, path>

Proceed with batch push? (yes / no)
```

Wait for confirmation before proceeding.

---

## Step 3 — Process Each Project

For each target project in order:

### 3a — Enter Project Directory
```bash
cd <PROJECT_PATH>
```

### 3b — Initialize Git (if needed)
Check for `.git` directory. If not present:
```bash
git init
git add .
git commit -m "Initial research"
```

Report: `✓ Git initialized`

### 3c — Create GitHub Remote (if needed)
Check for `origin` remote:
```bash
git remote -v
```

If `origin` does not exist:
```bash
gh repo create worlds-biggest-software-project/<DIRNAME> --source=. --public --push
```

Report: `✓ GitHub repo created and pushed`

If `origin` already exists:
Report: `✓ GitHub remote already exists`

### 3d — Commit Outstanding Changes
Check for uncommitted changes:
```bash
git status --porcelain
```

If changes exist:
```bash
git add .
git commit -m "WIP"
```

Report: `✓ Changes committed`

If working tree is clean:
Report: `✓ Working tree clean (no new changes)`

### 3e — Push to Origin
```bash
git push -u origin HEAD
```

If successful:
Report: `✓ <PROJECT_NAME> pushed to origin`

If failed:
Report: `✗ <PROJECT_NAME> — push failed: [error]` and continue to the next project

---

## Step 4 — Summary

After processing all projects, output a summary:

```
📊 Batch Push Summary

✅ Successful: <N> projects
  • <project-1>
  • <project-2>
  ...

❌ Failed: <M> projects
  • <project-3> — [error reason]
  ...

⏭️  Already pushed: <P> projects

Total processed: <N+M+P> projects
```

If any pushes failed, note the errors and suggest retrying individual projects with `/project-push-to-github <name>`.

---

## Notes

- The batch operation continues even if individual projects fail — one failure does not block the others
- Commits are made as "WIP" for consistency; create proper commit messages later if needed
- The operation requires `gh` CLI authentication — if not authenticated, all repo creation attempts will fail

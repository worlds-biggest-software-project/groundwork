---
name: "project-push-to-github"
description: "Push a project to GitHub. Initializes git, creates the remote repository if needed, commits any outstanding changes, and pushes to origin. Use this to publish a project after research is complete."
argument-hint: "Project directory name (e.g. 042-my-project) or candidate number (e.g. 42)"
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

Push a single candidate project directory to GitHub, initialising git and creating
the remote repository if needed, then committing any outstanding changes as "WIP"
and pushing to `origin`.

---

### Step 1 — Identify the Project Directory

Parse `$ARGUMENTS`:

- **Numeric only** (e.g. `42`, `#42`): scan the `projects/` directory for a
  subdirectory whose name starts with that zero-padded number (e.g. `042-*`).
- **Directory name** (e.g. `042-my-project`): use as-is.
- **Partial name / slug**: scan `projects/` for a unique directory whose name
  contains the argument (case-insensitive). If more than one matches, list the
  candidates and stop — ask the user to be more specific.

If `$ARGUMENTS` is empty, output:

```
ERROR: No project specified. Usage: /project-push-to-github <name|number>
```

and stop.

Set `PROJECT_DIR` to the full path of the resolved directory
(e.g. `projects/042-my-project`).

If the directory does not exist, output an error and stop.

---

### Step 2 — Initialise Git (if needed)

```bash
cd <PROJECT_DIR>
```

Check whether a `.git` directory exists inside `PROJECT_DIR`.

If it does **not** exist:

```bash
git init
git add .
git commit -m "Initial research"
```

If git is already initialised, skip this step.

---

### Step 3 — Create GitHub Remote (if needed)

Check whether an `origin` remote is already configured:

```bash
git remote -v
```

If **no** `origin` remote exists, create the public GitHub repository and push:

```bash
gh repo create worlds-biggest-software-project/<DIRNAME> --source=. --public --push
```

where `<DIRNAME>` is the bare directory name (e.g. `042-my-project`).

If `origin` already exists, skip this step.

---

### Step 4 — Commit Outstanding Changes

Check for any uncommitted changes:

```bash
git status --porcelain
```

If there are staged or unstaged changes (including untracked files):

```bash
git add .
git commit -m "WIP"
```

If the working tree is already clean, skip the commit silently.

---

### Step 5 — Push to Origin

```bash
git push -u origin HEAD
```

If the push succeeds, report:

```
✓ <PROJECT_DIR> pushed to origin.
```

If the push fails, surface the git error to the user and stop.

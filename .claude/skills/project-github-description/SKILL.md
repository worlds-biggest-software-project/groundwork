---
name: "project-github-description"
description: "Keep GitHub repo descriptions in sync with candidate-projects.md. Automatically updates the repository description if it diverges from the canonical source. Use this to maintain consistency as project definitions evolve."
argument-hint: "Project directory name (e.g. 12-feature-flag-management-system) or candidate number"
compatibility: "Requires gh CLI authenticated; GitHub repo must exist at worlds-biggest-software-project/<project-slug>"
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

Your goal is to ensure the GitHub repository description for a candidate project matches
the authoritative one-line description in `candidate-projects.md`.

Do not proceed until you have fully identified the target project. If the argument is
ambiguous or no matching project directory can be found, ask a clarifying question and stop.

---

### Step 1 — Identify the Project

Parse `$ARGUMENTS` to determine the project:

- **Directory name** (e.g. `12-feature-flag-management-system`): use it directly as
  `PROJECT_DIR`.
- **Candidate number only** (e.g. `12`, `#12`): scan `projects/` for a directory whose
  name begins with that number (zero-padded or not) and use it as `PROJECT_DIR`.
- **Project name** (e.g. `"Feature Flag Management System"`): scan `projects/` for the
  closest matching directory name and use it as `PROJECT_DIR`.

If `$ARGUMENTS` is empty or no matching directory is found, output:

```
ERROR: Cannot identify project. Usage: /project-github-description <directory-name|candidate-number|project-name>
```

and stop.

Set these variables for later steps:
- `PROJECT_DIR` — the directory under `projects/` (e.g. `12-feature-flag-management-system`)
- `PROJECT_SLUG` — same as `PROJECT_DIR` (used as the GitHub repo name)
- `GITHUB_ORG` — `worlds-biggest-software-project`
- `GITHUB_REPO` — `worlds-biggest-software-project/<PROJECT_DIR>`

---

### Step 2 — Extract the Description from candidate-projects.md

Read `candidate-projects.md` (repo root). Find the table row whose `#` column matches
the numeric prefix of `PROJECT_DIR`. Extract the description from the `Description`
column of that row.

Set `CANONICAL_DESCRIPTION` to that value.

If the file or row is not found, output:

```
ERROR: Could not find project #<N> in candidate-projects.md.
```

and stop.

---

### Step 3 — Fetch the Current GitHub Repository Description

Run:

```bash
gh repo view worlds-biggest-software-project/<PROJECT_DIR> --json description --jq '.description'
```

Set `CURRENT_DESCRIPTION` to the output (trimmed of whitespace). If the command fails
(e.g. repo does not exist or `gh` is not authenticated), report the error and stop.

---

### Step 4 — Compare and Update

Compare `CANONICAL_DESCRIPTION` and `CURRENT_DESCRIPTION`:

**If they are identical:** report:

```
OK: GitHub description for worlds-biggest-software-project/<PROJECT_DIR> already matches candidate-projects.md.
Description: "<CANONICAL_DESCRIPTION>"
No changes made.
```

and stop.

**If they differ:** run:

```bash
gh repo edit worlds-biggest-software-project/<PROJECT_DIR> --description "<CANONICAL_DESCRIPTION>"
```

Then report:

```
UPDATED: worlds-biggest-software-project/<PROJECT_DIR>
  Was:  "<CURRENT_DESCRIPTION>"
  Now:  "<CANONICAL_DESCRIPTION>"
```

If the `gh repo edit` command fails, report the error output verbatim and stop.

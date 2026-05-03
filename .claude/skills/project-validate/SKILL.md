---
name: "project-validate"
description: "Audit a candidate project's documentation completeness. Check for required files (research.md, features.md, README.md, standards.md) and report what is missing or needs work."
argument-hint: "Project directory name or candidate number"
compatibility: "Requires projects/ directory structure"
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

Your goal is to audit a project's documentation and report:
- Which required files exist and their status
- Which files are missing
- Basic quality checks (file size, structure, completeness indicators)
- Recommended next steps to complete the project

---

## Step 1 — Identify the Project

Parse `$ARGUMENTS`:

- **Numeric only** (e.g. `42`, `#42`): scan `projects/` for a directory starting with that zero-padded number.
- **Directory name** (e.g. `042-my-project`): use as-is.
- **Partial name / slug**: scan `projects/` for a unique matching directory (case-insensitive).

If `$ARGUMENTS` is empty, output:
```
ERROR: No project specified. Usage: /project-validate <name|number>
```
and stop.

Set `PROJECT_DIR` to the resolved directory path (e.g. `projects/042-my-project`).

If the directory does not exist, output an error and stop.

---

## Step 2 — Check for Required Files

For each required file, check if it exists and collect basic metadata:

| File | Purpose | Status |
|------|---------|--------|
| `research.md` | Background research (solutions, market, standards, literature) | ✓ / ✗ |
| `features.md` | Feature survey of competing tools and opportunities | ✓ / ✗ |
| `README.md` | GitHub introduction and positioning | ✓ / ✗ |
| `standards.md` | Industry standards and API documentation | ✓ / ✗ |

For each file that exists, also check:
- **File size**: Is it substantial (>500 bytes suggests real content)?
- **Completeness**: Does it have the expected section headings?
- **Recency**: When was it last modified? (Use `git log --oneline -1 <file>` or filesystem timestamp)

For each file that is missing, note it clearly.

---

## Step 3 — Assess Project Readiness

Based on which files exist, categorize the project:

**Incomplete** (0–1 files)
- No research cycle started yet, or minimal work.
- Recommendation: Run `/project-full-research <PROJECT>` to start the research cycle.

**In Progress** (2–3 files)
- Some research done, but documentation is incomplete.
- Recommendation: Run `/project-full-research <PROJECT>` to fill gaps, then create README.

**Ready for README** (research.md + features.md exist, README.md missing)
- Core research complete.
- Recommendation: Run `/project-create-README <PROJECT>` to generate the GitHub introduction.

**Ready for GitHub** (all 4 files exist)
- Fully documented and ready to push.
- Recommendation: Run `/project-push-to-github <PROJECT>` to publish to origin.

**Complete** (includes other supporting files like CONTRIBUTING.md, etc.)
- Project is well-established with comprehensive documentation.

---

## Step 4 — Generate Report

Output a structured report:

```
📊 Documentation Audit: <PROJECT_NAME>

📁 Project Path: <PROJECT_PATH>

## File Status

✓ research.md        (1.2 KB, 12 sections, last modified: 2025-04-15)
✗ features.md        (missing)
✓ README.md          (2.8 KB, 8 sections, last modified: 2025-04-20)
✗ standards.md       (missing)

## Project Readiness

Status: In Progress (2 of 4 files)

Missing:
  • features.md — Feature survey of competing tools
  • standards.md — Industry standards and API documentation

## Recommendations

1. Complete the research cycle:
   /project-full-research <PROJECT>
   This will create the missing features.md and standards.md files.

2. Review generated files for accuracy and completeness.

3. Once all files exist, push to GitHub:
   /project-push-to-github <PROJECT>

## Quality Notes

[Optional: Flag any incomplete sections, TODO markers, or sections that appear thin and might benefit from more research.]
```

---

## Step 5 — Check for Git Status

If the project directory is a git repository, also check:
- Are there uncommitted changes? (new/modified files)
- How many commits exist?
- Is there a remote origin configured?

Report this context to help the user understand the project's state.

---

## Exit

Report the audit result and suggest the next action based on completeness level.

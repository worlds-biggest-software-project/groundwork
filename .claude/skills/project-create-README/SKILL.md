---
name: "project-create-README"
description: "Generate a compelling GitHub README that positions a project and attracts contributors. Synthesizes research.md and features.md into a clear value proposition, feature overview, and market context. Use this once your project research is complete to create polished public documentation."
argument-hint: "Project directory name (e.g. 12-feature-flag-management-system) or candidate number"
compatibility: "Requires projects/<name>/research.md and projects/<name>/features.md to exist"
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

Your goal is to write a compelling, accurate GitHub README introduction for a candidate
software project, using the project's existing `research.md` and `features.md` files as
source material. The output is saved to `projects/<slug>/README.md`.

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
ERROR: Cannot identify project. Usage: /project-create-README <directory-name|candidate-number|project-name>
```

and stop.

Set these variables for later steps:
- `PROJECT_DIR` — the directory under `projects/` (e.g. `12-feature-flag-management-system`)
- `PROJECT_SLUG` — same as `PROJECT_DIR`
- `PROJECT_PATH` — full relative path: `projects/<PROJECT_DIR>`

---

### Step 2 — Look Up the Candidate Entry

Read `candidate-projects.md` (repo root). Find the table row whose `#` column matches
the numeric prefix of `PROJECT_DIR`. Extract:

- `PROJECT_NAME` — the human-readable project name from the table (e.g. `Feature Flag Management System`)
- `PROJECT_DESCRIPTION` — the one-line description from the table
- `COMPLEXITY` — the complexity score (1–10)
- `DOMAIN_AVAILABILITY` — High / Medium / Low
- `DEMAND` — High / Medium / Low
- `CATEGORY` — the section heading above the row (e.g. `Developer Tools & DevOps`)

If the file or row is not found, continue with what is available from the directory name
and source files; note the gap in the final output.

---

### Step 3 — Read Source Files

Read both of the following files in full:

1. `projects/<PROJECT_DIR>/research.md`
2. `projects/<PROJECT_DIR>/features.md`

If either file is missing, note it and continue with the available file. If both are
missing, output:

```
ERROR: Neither research.md nor features.md found in projects/<PROJECT_DIR>/. Run /project-background-research and /project-functionality-research first.
```

and stop.

From the source files, extract:
- **Problem statement**: the core pain the project solves
- **Incumbent landscape**: top 3–5 existing solutions and their key weaknesses
- **AI-native opportunity**: what AI makes better vs. incumbents
- **Key capabilities**: the most important feature areas (from features.md)
- **Technical highlights**: SDKs, protocols, standards, deployment modes
- **Market context**: TAM, pricing comparisons, buyer personas
- **Licence information** if mentioned

---

### Step 4 — Write the README

Produce a `README.md` using the structure below. Write for a technical GitHub audience:
developers, engineering leaders, and open-source contributors.

Tone: clear, direct, confident. No marketing fluff. No invented claims. Every statement
must be grounded in the source files or the candidates table.

Use GitHub-flavoured Markdown. Do NOT add emojis unless the source files use them.

```markdown
# <PROJECT_NAME>

> Part of the [worlds-biggest-software-project](https://github.com/worlds-biggest-software-project) initiative.
>
> <One-sentence value proposition derived from the description and research>

<2–3 sentence overview: what the project is, who it is for, and the core problem it solves.>

---

## Why <PROJECT_NAME>?

<3–5 bullet points explaining the gap in the market and why an AI-native open-source
alternative is needed. Ground each point in a specific incumbent weakness or pricing
concern found in research.md.>

---

## Key Features

<Feature list grouped into 3–5 thematic sections matching the major capability areas
found in features.md. Each section: a ### heading, a blank line, then 3–5 bullet points,
then a blank line before the next section.
Do not invent features; draw only from what features.md documents.>

---

## AI-Native Advantage

<2–4 sentences describing what AI capabilities make this project meaningfully better
than incumbents — e.g. automated flag cleanup, natural-language targeting rules,
anomaly detection. Derived from the AI-Native Opportunity section of research.md.>

---

## Tech Stack & Deployment

<Brief section on expected deployment modes (self-hosted, cloud, hybrid), relevant
open standards (e.g. OpenFeature), and SDK / integration approach. Derived from
research.md and features.md. If this information is sparse, keep the section short
rather than padding it.>

---

## Market Context

<2–3 sentences on market size, incumbent pricing, and who the primary buyers are.
Use figures from research.md where available; cite sources inline.>

---

## Project Status

> This project is in the **research and specification phase**.  
> Contributions, feedback, and domain expertise are welcome.

---

## Contributing

We welcome contributions from developers, domain experts, and potential users.
See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Important:** All contributions must be your own original work or clearly attributed
open-source material with a compatible licence. Copyright infringement and licence
violations will not be tolerated and will result in immediate removal of the offending
contribution. If you are unsure whether a piece of code, text, or other material is
safe to contribute, open an issue and ask before submitting.

---

## Licence

<If licence is mentioned in source files, state it. Otherwise write:>
Licence to be determined. See [discussion](#) for context.
```

Adjust section lengths to match information density. If a section would be thin,
shorten or merge it rather than padding with vague statements.

---

### Step 5 — Save and Report

Write the README to `projects/<PROJECT_DIR>/README.md`.

If a `README.md` already exists at that path, note it and ask the user:

> `README.md` already exists at `projects/<PROJECT_DIR>/README.md`. Overwrite it? (yes / no)

Wait for confirmation before writing.

Report to the user:
- Output file path
- One-sentence summary of the README's positioning angle
- Any gaps where source material was thin (and which source file to improve)
- Suggested next step: run `/speckit-specify <PROJECT_NAME>` to begin formal specification

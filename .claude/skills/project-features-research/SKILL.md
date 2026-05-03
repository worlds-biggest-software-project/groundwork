---
name: "project-features-research"
description: "Survey competing products to build a feature specification. Document what features existing tools offer, what differentiates winners, and where gaps exist. Use this when preparing to build a project, designing what features to prioritize, or benchmarking against incumbents."
argument-hint: "Project name, candidate number from candidates.md, or free-text description"
compatibility: "Requires internet access for web research; works best with a WBSP candidates.md and existing research.md available"
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

Your goal is to produce a structured features document that surveys existing industry
solutions — commercial products, open source tools, and notable prototypes — for a
given software project idea, and distils the most useful, well-validated features and
functionality from those solutions. Save the output to the `projects/[projectName]/` directory as
`features.md`, beside the corresponding `research.md`.

It is essential that you DO NOT PROCEED until you have fully understood the project
being researched. If the user input is ambiguous or insufficient to identify a project,
you MUST ask clarifying questions before moving forward.

### Legal & ethical constraints (mandatory — read before every search)

- **Copyright / content**: Do not reproduce proprietary text, screenshots, UI copy,
  or documentation verbatim. Paraphrase and cite sources.
- **Licensing**: Note the licence of every open-source tool discussed. Do not suggest
  adopting code or design elements whose licence is incompatible with the project's
  intended licence without flagging the conflict.
- **Patents**: Avoid describing implementation techniques that are the subject of
  known, active software patents. If a technique appears patent-encumbered, say so
  explicitly and recommend independent legal review before use.
- **Uncertainty**: If copyright, licensing, or patent status of any material is
  unclear, **do not include the material**. Instead note the gap and flag it for
  legal review.

Prioritise factual, publicly available information: product pages, documentation,
changelog entries, release notes, conference talks, and peer-reviewed papers.

### Step 1 — Identify the Project

Parse `$ARGUMENTS` to determine what is being researched:

- **Candidate number** (e.g. `15`, `#15`): Look up the project in
  `documents/candidates.md`. Read that file, find the row matching the number,
  and extract the project name and description. If the file is not found, try
  `projects/candidates.md` and then the repo root `candidates.md`.
- **Project name** (e.g. `"Changelog Generator"`): Use the name as-is.
- **Free-text description** (e.g. `"a tool that auto-generates release notes from
  git commits"`): Derive a short project name from the description (2–4 words,
  kebab-case) and use it as the project title.

If `$ARGUMENTS` is empty, output:
```
ERROR: No project specified. Usage: /project-functionality-research <name|number|description>
```
and stop.

Set these variables for later steps:
- `PROJECT_NAME` — human-readable title (e.g. `Changelog & Release Notes Generator`)
- `PROJECT_SLUG` — kebab-case short name (e.g. `changelog-generator`)
- `CANDIDATE_NUMBER` — the candidate list number if applicable, else empty

### Step 2 — Determine Output Path

The output file is:

```
projects/<CANDIDATE_NUMBER>-<PROJECT_SLUG>/features.md
```

If `CANDIDATE_NUMBER` is empty, write an error message and abort.

Check whether a `research.md` exists at the same path. If it does, read it — it
provides useful context about which tools and categories are already known and can
guide the feature investigation.

If a `features.md` already exists at the output path, note it and ask the user:
> Features file already exists at `<path>`. Overwrite it? (yes / no)

Stop and wait for confirmation before continuing.

### Step 3 — Identify Solutions to Analyse

Compile a list of 6–12 existing solutions to examine in depth. Include a mix of:

- Leading **commercial SaaS / desktop products** in the category
- Significant **open-source projects** (note their licences)
- Notable **research prototypes** or academic systems if the domain is active in
  research

Use the `research.md` "Existing Products" section as a starting point if available,
then supplement with targeted web searches to find anything missing or recently
released.

For each candidate, record:
- Name, URL (product page or repository)
- Open source (with licence) or commercial
- Brief one-line description of what it does

Do not include tools that are only tangentially related to the core problem.

### Step 4 — Feature Deep-Dive Research

For each solution identified in Step 3, perform focused web research to extract its
notable features and design decisions. Use product documentation, feature pages,
release notes, and credible reviews as sources. Do not copy proprietary text
verbatim — paraphrase and cite.

For each solution, capture:

1. **Core feature set** — the 5–10 most prominent capabilities the tool offers
2. **Differentiated features** — anything the tool does that most others do not
3. **User experience patterns** — how the tool surfaces complexity, progressive
   disclosure, onboarding, etc. (describe in terms of UX patterns, not UI copy)
4. **Integration points** — APIs, webhooks, plugins, or ecosystem connections it
   provides
5. **Known limitations or gaps** — features users commonly request but the tool
   lacks (drawn from public issue trackers, user reviews, or documentation gaps)
6. **Licence / IP notes** — licence name for open source tools; flag any features
   that appear to be patented or have known IP encumbrances

### Step 5 — Synthesise Cross-Cutting Feature Themes

After analysing all solutions, identify patterns across the solution space:

- **Table-stakes features** — capabilities present in nearly every solution; any
  project in this space must match them
- **Differentiating features** — capabilities present in some solutions that provide
  a competitive edge; worth considering for the project
- **Underserved areas** — gaps that multiple solutions share, representing genuine
  opportunities for the project to add unique value
- **AI-augmentation candidates** — features that existing tools implement with
  manual/rule-based approaches but where AI could provide meaningfully better
  results

### Step 6 — Write the Features Document

Compile findings into a markdown document using exactly this structure:

```markdown
# <PROJECT_NAME> — Feature & Functionality Survey

> Candidate #<CANDIDATE_NUMBER> · Researched: <YYYY-MM-DD>

## Solutions Analysed

| Tool | Type | Licence / Model | URL |
|------|------|-----------------|-----|
| ...  | ...  | ...             | ... |

## Feature Analysis by Solution

### <Tool Name>

**Core features**
- ...

**Differentiating features**
- ...

**UX patterns**
- ...

**Integration points**
- ...

**Known gaps**
- ...

**Licence / IP notes**
- ...

<!-- repeat for each tool -->

## Cross-Cutting Feature Themes

### Table-Stakes Features
<bullet list — capabilities the project must have to be viable>

### Differentiating Features
<bullet list — capabilities worth considering for competitive advantage>

### Underserved Areas / Opportunities
<bullet list — gaps that represent genuine opportunities>

### AI-Augmentation Candidates
<bullet list — manual/rule-based features where AI could excel>

## Legal & IP Summary

<One paragraph summarising any copyright, licence compatibility, or patent concerns
identified during research. If none were found, state that explicitly. If any
material was omitted due to uncertainty, list the gaps here.>

## Recommended Feature Scope

Based on the above, suggest a prioritised feature scope for the project:

**Must-have (MVP)**: <3–6 bullet points>
**Should-have (v1.1)**: <3–5 bullet points>
**Nice-to-have (backlog)**: <3–5 bullet points>
```

Be factual and precise. Do not pad sections with filler. If a section has genuinely
sparse information, write a brief honest note. Flag all IP uncertainties — do not
speculate about patent status.

### Step 7 — Save and Report

Write the document to the path determined in Step 2.

Report to the user:
- Output file path
- Brief summary of what was found (1–2 sentences per section)
- Any IP/legal flags that require follow-up
- Any gaps where data was thin or unavailable
- Suggested next step: `/speckit-specify <PROJECT_NAME>` to begin the feature spec

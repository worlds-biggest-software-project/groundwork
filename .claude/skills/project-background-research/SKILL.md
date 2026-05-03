---
name: "project-background-research"
description: "Research a software project deeply: discover existing solutions and competitors, identify industry standards and protocols, compile research literature, and assess market size and demand. Use this whenever the user mentions researching a candidate project, evaluating the problem space, or understanding what already exists in a domain."
argument-hint: "Project name, candidate number from candidates.md, or free-text description"
compatibility: "Requires internet access for web research; works best with a WBSP candidates.md available"
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

Your goal is to produce a structured research document covering existing solutions,
industry standards, published research, and market data for a given software project
idea. Save the output to the `projects/` directory.

It is essential that you DO NOT PROCEED with the research until you have fully understood the project being researched. If the user input is ambiguous or insufficient to identify a project, you MUST ask clarifying questions before moving forward.

DO NOT record any information or research that potentially breaches copyright or licensing terms. Focus on publicly available information and properly cite sources.

If there is uncertainty or lack of information in any area, be transparent about it in the final document rather than speculating or inventing content. The goal is to provide a factual, concise, and useful research summary that can inform the next steps in project development.

If there is uncertainty about copyright or licensing for any specific information, DO NOT include it in the research document. Instead, note the gap and suggest that further investigation may be needed to clarify the legal status of that information before it can be used in the project. Always prioritize compliance with copyright and licensing laws in your research.

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
ERROR: No project specified. Usage: /research-project <name|number|description>
```
and stop.

Set these variables for later steps:
- `PROJECT_NAME` — human-readable title (e.g. `Changelog & Release Notes Generator`)
- `PROJECT_SLUG` — kebab-case short name (e.g. `changelog-generator`)
- `CANDIDATE_NUMBER` — the candidate list number if applicable, else empty

### Step 2 — Determine Output Path

Scan the `projects/` directory for existing `research-*.md` files to find the
highest existing research number N. Set the output filename to:

```
projects/<CANDIDATE_NUMBER>-<PROJECT_SLUG>/research.md
```

If `CANDIDATE_NUMBER` is empty, write an error message and abort.

If a file at that path already exists, note it and ask the user:
> Research file already exists at `<path>`. Overwrite it? (yes / no)

Stop and wait for confirmation before continuing.

### Step 3 — Conduct Web Research

Perform targeted web searches across four areas. Use multiple focused queries per
area — do not rely on a single search. Prefer authoritative sources: product
websites, industry reports, peer-reviewed papers, and reputable tech publications.

#### A. Existing Products & Open Source Solutions

Search for tools, SaaS products, and open source projects in this space. For each
significant solution found, capture:
- Name and brief description
- Whether it is open source or commercial
- Notable strengths or weaknesses relative to an AI-native alternative
- Pricing model if commercial

Aim for 5–10 relevant entries. Focus on direct competitors, not tangential tools.

#### B. Industry Standards & Protocols

Search for relevant specifications, standards bodies, and protocols that apply to
this domain. Include:
- Named standards (ISO, IEEE, RFC, OWASP, W3C, etc.) with a one-line description
  of their relevance
- De-facto protocols or data formats used in this space
- Regulatory or compliance frameworks if the domain is regulated (healthcare,
  finance, legal, etc.)

Include only standards with real relevance to building this software.

#### C. Research Literature

Search for academic papers, industry white papers, and survey articles. For each
relevant publication, use proper citation format:

```
Author(s) (Year). Title. Venue/Journal. URL or DOI if available.
```

Aim for 5–8 citations. Prefer papers from the last 5 years unless an older paper
is foundational. Flag papers that are preprints (arXiv) vs. peer-reviewed.

#### D. Market Research

Search for market size, growth projections, and competitive dynamics. Capture:
- Total addressable market (TAM) size and CAGR if available, with source and year
- Estimated number of existing users or customers across the category
- Typical pricing ranges (free tier / SMB / enterprise)
- Key buyer personas and their pain points
- Any notable recent funding, acquisitions, or market events

Note data sources and publication dates; flag estimates that are speculative.

### Step 4 — Write the Research Document

Compile findings into a markdown document using exactly this structure:

```markdown
# <PROJECT_NAME>

> Candidate #<CANDIDATE_NUMBER> · Researched: <YYYY-MM-DD>

## Existing Products and Software Packages

<findings from Step 3A>

## Relevant Industry Standards or Protocols

<findings from Step 3B>

## Available Research Materials

<findings from Step 3C>

## Market Research

<findings from Step 3D>

## AI-Native Opportunity

Based on the above, summarize in 3–5 bullet points:
- What existing solutions do poorly that AI could address
- Which user pain points are underserved
- What differentiated value an open-source AI-native tool could offer
```

Be factual and precise. Do not pad sections with filler. If a section has
genuinely sparse information (e.g. emerging category with no standards yet),
write a brief honest note rather than inventing content.

### Step 5 — Save and Report

Write the document to the path determined in Step 2.

Report to the user:
- Output file path
- Brief summary of what was found (1–2 sentences per section)
- Any gaps where data was thin or unavailable
- Suggested next step: `/speckit.specify <PROJECT_NAME>` to begin the feature spec

---
name: "project-full-research"
description: "Run a complete research cycle for a project: background research, features analysis, and standards/API documentation. Intelligently skips steps where output files already exist."
argument-hint: "Project name, candidate number, or directory name"
compatibility: "Requires internet access for web research; works best with candidates.md available"
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

Your goal is to run a complete research cycle for a candidate software project, producing three research documents in sequence. The key advantage of this skill is that it **checks for existing output files and skips research steps that are already complete**, avoiding redundant work.

The three steps are:
1. **Background research** → `research.md` (existing solutions, market size, standards, literature)
2. **Features research** → `features.md` (feature survey of competing tools)
3. **Standards & APIs** → `standards.md` (industry standards and API documentation)

If any of these files already exist, that step is skipped. Only missing research is performed.

---

## Step 1 — Identify the Project

Parse `$ARGUMENTS` to determine what is being researched:

- **Candidate number** (e.g. `15`, `#15`): Look up the project in `candidates.md` (check `documents/candidates.md`, `projects/candidates.md`, or repo root). Find the row matching the number and extract the project name and description.
- **Project name** (e.g. `"Changelog Generator"`): Use the name as-is.
- **Directory name** (e.g. `015-changelog-generator`): Extract the project name from the directory.
- **Free-text description** (e.g. `"a tool that auto-generates release notes"`): Derive a short project name (kebab-case, 2–4 words).

If `$ARGUMENTS` is empty, output:
```
ERROR: No project specified. Usage: /project-full-research <name|number|description>
```
and stop.

Set these variables for later steps:
- `PROJECT_NAME` — human-readable title
- `PROJECT_SLUG` — kebab-case short name
- `CANDIDATE_NUMBER` — the candidate list number if applicable
- `PROJECT_PATH` — full path: `projects/<CANDIDATE_NUMBER>-<PROJECT_SLUG>`

---

## Step 2 — Determine Output Paths and Check for Existing Files

Set the expected output paths:
- `RESEARCH_FILE` = `<PROJECT_PATH>/research.md`
- `FEATURES_FILE` = `<PROJECT_PATH>/features.md`
- `STANDARDS_FILE` = `<PROJECT_PATH>/standards.md`

Check which files already exist:
- If `RESEARCH_FILE` exists, set `SKIP_RESEARCH = true`
- If `FEATURES_FILE` exists, set `SKIP_FEATURES = true`
- If `STANDARDS_FILE` exists, set `SKIP_STANDARDS = true`

Report to the user which steps will run and which will be skipped:

```
📋 Research Plan for <PROJECT_NAME>

✓ research.md     [existing — skipping]
✗ features.md     [missing — will research]
✗ standards.md    [missing — will research]

Running 2 of 3 research steps...
```

(Adjust based on what actually exists.)

If all three files exist, output:
```
✓ All research files already exist for <PROJECT_NAME>. No work needed.
  research.md, features.md, standards.md are present.
Suggested next step: /project-create-README <PROJECT_NAME>
```
and stop.

---

## Step 3 — Run Background Research (if missing)

If `SKIP_RESEARCH = false`:

Conduct targeted web research across four areas (see `project-background-research` skill for details):

### A. Existing Products & Solutions
Search for 5–10 relevant tools, SaaS products, and open-source projects. For each:
- Name and brief description
- Open source (licence) or commercial
- Strengths/weaknesses vs. AI-native alternative
- Pricing if commercial

### B. Industry Standards & Protocols
Search for ISO, IEEE, RFC, OWASP, W3C, and domain-specific standards relevant to the project. Include:
- Standard name/number with brief relevance
- De-facto protocols or data formats
- Regulatory frameworks if applicable

### C. Research Literature
Search for academic papers, white papers, and survey articles (5–8 citations, prefer last 5 years):
```
Author(s) (Year). Title. Venue/Journal. URL or DOI.
```

### D. Market Research
Search for market size, growth, pricing, buyer personas, and recent funding/acquisitions.

**Write the document:**

```markdown
# <PROJECT_NAME>

> Candidate #<CANDIDATE_NUMBER> · Researched: <YYYY-MM-DD>

## Existing Products and Software Packages
<findings from A>

## Relevant Industry Standards or Protocols
<findings from B>

## Available Research Materials
<findings from C>

## Market Research
<findings from D>

## AI-Native Opportunity
Based on the above, summarize in 3–5 bullet points what AI could address, which pain points are underserved, and what differentiated value an open-source AI-native tool could offer.
```

Save to `RESEARCH_FILE`.

---

## Step 4 — Run Features Research (if missing)

If `SKIP_FEATURES = false`:

Identify 6–12 existing solutions from the background research. For each, extract:

1. **Core features** — 5–10 most prominent capabilities
2. **Differentiating features** — what this tool uniquely does
3. **UX patterns** — how it surfaces complexity, onboarding, progressive disclosure
4. **Integration points** — APIs, webhooks, plugins, ecosystem
5. **Known gaps** — features users request but are missing
6. **Licence / IP notes** — licence name; flag any patented features

After analysing all solutions, identify cross-cutting themes:
- **Table-stakes features** — must-haves in this category
- **Differentiating features** — competitive advantages
- **Underserved areas** — gaps representing opportunities
- **AI-augmentation candidates** — manual/rule-based features where AI excels

**Write the document:**

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
<bullet list>

### Differentiating Features
<bullet list>

### Underserved Areas / Opportunities
<bullet list>

### AI-Augmentation Candidates
<bullet list>

## Legal & IP Summary

<One paragraph summarising any copyright, licence compatibility, or patent concerns. If none were found, state that explicitly.>

## Recommended Feature Scope

**Must-have (MVP)**: <3–6 bullet points>
**Should-have (v1.1)**: <3–5 bullet points>
**Nice-to-have (backlog)**: <3–5 bullet points>
```

Save to `FEATURES_FILE`.

---

## Step 5 — Run Standards & APIs Research (if missing)

If `SKIP_STANDARDS = false`:

### A. Industry Standards & Specifications

Conduct targeted searches for:

- **ISO Standards**: Data models, APIs, security, interoperability relevant to the domain
- **W3C & IETF Standards**: Specs, RFCs (e.g., RFC 7231 for HTTP, RFC 8288 for linking)
- **Data Model Standards**: OpenAPI, GraphQL, JSON Schema, Protocol Buffers, Avro
- **MCP Server Specs**: Model Context Protocol if relevant
- **Security & Compliance**: OAuth 2.0, OpenID Connect, OWASP, NIST, GDPR implications

Target 8–15 standards. For each, record:
- Standard name and number (if applicable)
- Official URL/link
- Brief 1–2 sentence relevance to the project

### B. Similar Products — APIs & Documentation

Identify 5–10 products with similar or adjacent functionality. For each:
- **Product Name** and 1–2 sentence description
- **API Documentation Link** (prefer official docs)
- **SDK/Library Links** (JavaScript, Python, Go, Java, etc.)
- **Developer Guide** (getting started / integration)
- **Standards Compliance** (OpenAPI, GraphQL, REST, etc.)
- **Authentication** (OAuth, API Key, mTLS, etc.)

**Write the document:**

```markdown
# Standards & API Reference

> Project: <PROJECT_NAME> · Generated: <YYYY-MM-DD>

## Industry Standards & Specifications

### ISO Standards
[List each relevant ISO standard with title, number, URL, and 1–2 sentence description]

### W3C & IETF Standards
[List W3C specs and RFCs with URLs]

### Data Model & API Specifications
[OpenAPI, GraphQL, JSON Schema, etc.]

### Security & Authentication Standards
[OAuth, OpenID Connect, OWASP, NIST, etc.]

### MCP Server Specifications
[If applicable, links to MCP documentation]

## Similar Products — Developer Documentation & APIs

### Product Name 1
- **Description:** [1–2 sentences]
- **API Documentation:** [Link]
- **SDKs/Libraries:** [Links]
- **Developer Guide:** [Link]
- **Standards:** [e.g., REST/JSON, GraphQL, OpenAPI 3.1]
- **Authentication:** [OAuth 2.0, API Key, etc.]

### Product Name 2
[Repeat for each product]

## Notes
[Optional section for gaps, emerging standards, or areas still evolving]
```

Save to `STANDARDS_FILE`.

---

## Step 6 — Summary and Next Steps

Report completion:

```
✅ Research complete for <PROJECT_NAME>

📄 Generated files:
  <list which files were created or skipped>

📊 Summary:
  • Background research: [<file> created / skipped — already exists]
  • Features analysis: [<file> created / skipped — already exists]
  • Standards & APIs: [<file> created / skipped — already exists]

Next steps:
  1. Review the research files to ensure accuracy
  2. Run /project-create-README <PROJECT_NAME> to write the GitHub README
  3. Run /project-push-to-github <PROJECT_NAME> to publish to origin
```

---

## Copyright & Licensing Compliance

Do not record any information that potentially breaches copyright or licensing terms. Focus on publicly available information and properly cite sources. If uncertain about copyright or licensing for any specific information, do not include it in the research document. Instead, note the gap and suggest further investigation.

Be transparent about any gaps where data was thin or unavailable rather than speculating or inventing content.

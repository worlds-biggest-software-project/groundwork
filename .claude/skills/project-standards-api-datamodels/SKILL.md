---
name: "project-standards-api-datamodels"
description: "Identify industry standards and compile API references. Research relevant ISO, W3C, IETF standards and collect API documentation links from competing products. Use this to align your project architecture with established standards and understand how similar products expose their APIs and data models."
argument-hint: "Project path (e.g., projects/384-rate-limiting-as-a-service) or project name"
compatibility: "Requires internet access for web research; works best with project README.md and research.md present"
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

Your goal is to produce a comprehensive research document identifying:
1. **Industry Standards & Specifications** — ISO, W3C, IETF, and other standards relevant to the project's domain (data models, APIs, interoperability, MCP servers, security)
2. **Similar Products — Developer Documentation & APIs** — Links to API docs, SDKs, and developer guides for 5–10 competing or adjacent products

Save the output to `standards.md` in the project directory (beside `research.md`).

### Step 1 — Identify the Project

Parse `$ARGUMENTS` to determine what is being researched:

- **Project path** (e.g., `projects/384-rate-limiting-as-a-service`): Use the path as-is
- **Project name** (e.g., `rate-limiting-as-a-service`): Construct the path as `projects/<name>`
- **Candidate number** (e.g., `384`): Construct the path as `projects/<number>-*` (find matching directory)

If `$ARGUMENTS` is empty, output:
```
ERROR: No project specified. Usage: /project-standards-api-datamodels <project-path|project-name|candidate-number>
```
and stop.

Set these variables for later steps:
- `PROJECT_PATH` — full path to the project directory
- `PROJECT_NAME` — human-readable project name (extract from README.md or directory name)

### Step 2 — Validate Project & Read Context

Verify that the project directory exists at `PROJECT_PATH`.

Read the project context:
- **README.md** — Understand the project's purpose, scope, and domain
- **research.md** — Review existing research to understand the problem space
- **features.md** (if available) — Understand planned functionality

If neither README.md nor research.md exists, ask the user to provide more context about the project:
```
The project directory exists, but README.md and research.md are missing. 
Please describe the project briefly so I can research relevant standards and APIs.
```

### Step 3 — Determine Output Path

Set the output path as:
```
<PROJECT_PATH>/standards.md
```

If a file already exists at this path, note it and ask the user:
> A `standards.md` file already exists at `<path>`. Overwrite it? (yes / no)

Stop and wait for confirmation before continuing.

### Step 4 — Research Industry Standards & Specifications

Conduct targeted web searches to identify standards relevant to the project domain. For each area, search for:

#### A. ISO Standards
- Search for ISO standards relevant to data models, APIs, security, interoperability
- Example: "ISO standards for RESTful API design", "ISO data model standards"
- Include standard number, title, brief description of relevance

#### B. W3C, IETF, and Other Standards Bodies
- W3C specifications (e.g., JSON-LD, Linked Data Platform, etc.)
- IETF RFCs (e.g., RFC 7231 for HTTP semantics, RFC 8288 for web linking)
- Industry-specific standards (e.g., FHIR for healthcare, OFX for finance)
- Search: "W3C standards for [domain]", "IETF standards for [domain]"

#### C. Data Model Standards & Specifications
- OpenAPI / Swagger specifications
- GraphQL specifications
- JSON Schema standards
- Protocol Buffers, Apache Avro, or other serialization formats
- Domain-specific data models (e.g., OSLC for application lifecycle management)

#### D. MCP Server Specifications (if relevant)
- Model Context Protocol server specifications
- Integration frameworks relevant to the project

#### E. Security & Compliance Standards
- OAuth 2.0, OpenID Connect for authentication
- Data privacy standards (GDPR, CCPA implications)
- Security frameworks (OWASP, NIST)

Aim for 8–15 relevant standards. For each, record:
- Standard name and number (if applicable)
- Official URL/link
- Brief 1–2 sentence description of relevance to the project

### Step 5 — Research Similar Products & APIs

Identify 5–10 products with similar or adjacent functionality. For each product:

1. **Product Name** — Clear, official name
2. **Brief Description** — 1–2 sentences about what it does
3. **API Documentation Link** — Direct URL to developer API docs (prefer official docs)
4. **SDK/Library Links** — Links to client libraries (JavaScript, Python, Go, Java, etc.) if available
5. **Developer Guide** — Link to getting started or integration guide
6. **Standards Compliance** — Note if it follows OpenAPI, GraphQL, REST, or other standards mentioned in Step 4
7. **Authentication** — OAuth, API Key, mTLS, etc.

Search strategies:
- "Products like [project name]"
- "[Domain] API providers"
- "[Feature] as a service"
- "Alternatives to [similar product]"
- Industry-specific search: "GitHub API documentation", "Twilio API docs", etc.

### Step 6 — Write the Standards Document

Compile findings into a markdown document using exactly this structure:

```markdown
# Standards & API Reference

> Project: <PROJECT_NAME> · Generated: <YYYY-MM-DD>

## Industry Standards & Specifications

### ISO Standards

[List each relevant ISO standard with title, number, URL, and 1–2 sentence description]

### W3C & IETF Standards

[List W3C specs, RFCs, and other standards with URLs]

### Data Model & API Specifications

[OpenAPI, GraphQL, JSON Schema, and other data model standards]

### Security & Authentication Standards

[OAuth, OpenID Connect, OWASP, NIST, etc.]

### MCP Server Specifications

[If applicable, links to MCP documentation and specs]

## Similar Products — Developer Documentation & APIs

### Product Name 1
- **Description:** [1–2 sentences]
- **API Documentation:** [Link]
- **SDKs/Libraries:** [Links to GitHub repos or package managers]
- **Developer Guide:** [Link to getting started]
- **Standards:** [e.g., REST/JSON, GraphQL, follows OpenAPI 3.1]
- **Authentication:** [OAuth 2.0, API Key, etc.]

### Product Name 2
[Repeat for each product]

...

## Notes

[Optional section for gaps, emerging standards, or areas where standards are still evolving]
```

Be specific and precise with URLs. Verify that all links are current and point to official documentation.

### Step 7 — Save and Report

Write the document to `<PROJECT_PATH>/standards.md`.

Report to the user:
- Output file path
- Number of standards identified
- Number of similar products documented
- Any gaps or areas where standards are still evolving
- Suggested next step: review the standards.md and consider how to align the project architecture with relevant standards

<!--
SYNC IMPACT REPORT
==================
Version change: (template) → 1.0.0
Modified principles: N/A — initial constitution, all sections are new
Added sections:
  - Core Principles (I–V)
  - Technology & Quality Standards
  - Development Workflow
  - Governance
Removed sections: N/A
Templates reviewed:
  ✅ .specify/templates/plan-template.md — "Constitution Check" section uses
     "[Gates determined based on constitution file]"; compatible with principles as defined
  ✅ .specify/templates/spec-template.md — no principle-specific references; compatible
  ✅ .specify/templates/tasks-template.md — no principle-specific references; compatible
  ✅ .specify/templates/checklist-template.md — fully generic; no updates required
  ✅ .specify/templates/agent-file-template.md — fully generic; no updates required
Follow-up TODOs: None — all placeholders resolved
-->

# World's Biggest Software Project Constitution

## Core Principles

### I. AI-Native by Design

Every project MUST embed AI as a core value driver, not a peripheral feature. A project
qualifies as AI-native when AI meaningfully improves a measurable outcome—accuracy,
throughput, automation rate, decision quality—relative to a non-AI baseline. Bolting a
chatbot onto an existing workflow does not qualify. LLM and ML service dependencies MUST
be abstracted behind interfaces so they can be swapped without redesign.

### II. Open Source by Default

All software MUST be released under a permissive open source license (MIT preferred,
Apache 2.0 acceptable). Projects MUST be fully self-hostable; no feature MUST require
an external paid service to function. Vendor-specific integrations (cloud providers,
proprietary APIs) are permitted as optional enhancements only. Community extensibility
MUST be a first-class design consideration.

### III. Specification-First (NON-NEGOTIABLE)

No code MUST be written before an approved specification exists. The Speckit workflow
is mandatory for all features:

- `specify` → `clarify` → `plan` → `tasks` → `implement`

Specification documents are living artifacts; they MUST be updated when implementation
reveals scope changes. Skipping or abbreviating steps requires explicit written
justification in the plan's Complexity Tracking table.

### IV. Incremental, Independently Testable Delivery

User stories MUST be scoped so each can be implemented, tested, and demonstrated
independently. Every implementation plan MUST identify a P1 MVP story that delivers
standalone value. No story SHOULD be a prerequisite for another story's basic
functionality. Features are complete only when the acceptance scenarios in the
specification pass.

### V. Simplicity and Sustainability

Start with the simplest implementation that satisfies the specification. YAGNI applies
at all stages. Every project MUST be maintainable by a single developer as the baseline
staffing assumption. Technical debt is permitted only when justified, documented in the
plan's Complexity Tracking table, and bounded by a resolution milestone. Abstractions
MUST be earned by at least three concrete use cases.

## Technology & Quality Standards

Technology choices MUST be documented in `plan.md` before implementation begins. Prefer
widely-supported, well-documented technologies unless a novel choice is integral to the
AI-native value proposition. Code quality gates (linting, static analysis, type checking
where the language supports it) MUST be configured before the first feature commit.
Automated tests are optional unless the specification requests them, but MUST be included
for all security-sensitive and data-integrity-critical code paths regardless of whether
tests were requested.

## Development Workflow

All feature development MUST follow the Speckit workflow with git integration enabled.
Branch names MUST follow the sequential convention: `NNN-feature-name`. The `main`
branch is always releasable. Commits MUST occur at logical task boundaries with
meaningful messages that explain intent, not mechanics. Pull requests MUST reference
the corresponding specification document. Git history is the canonical record of
project intent and supersedes inline comments as a source of rationale.

## Governance

This constitution supersedes all other documented development practices. Amendments
require:

1. Documented rationale explaining why the current text is insufficient
2. Assessment of impact on any in-progress specifications
3. Version increment per semantic versioning policy:
   - **MAJOR**: principle removed, redefined, or governance incompatibly changed
   - **MINOR**: new principle or section added, or materially expanded guidance
   - **PATCH**: clarifications, wording improvements, or non-semantic refinements
4. Propagation review across all Speckit templates (checklist in Sync Impact Report)

All implementation plans MUST include a Constitution Check gate before Phase 0 research.
Principle violations MUST be documented in the plan's Complexity Tracking table with
explicit justification; undocumented violations are grounds for blocking a pull request.

**Version**: 1.0.0 | **Ratified**: 2026-04-22 | **Last Amended**: 2026-04-22

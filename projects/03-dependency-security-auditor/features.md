# Dependency Security Auditor — Feature & Functionality Survey

> Candidate #3 · Researched: 2026-04-22

## Solutions Analysed

| Tool | Type | Licence / Model | URL |
|------|------|-----------------|-----|
| Snyk | Commercial SaaS + CLI | Proprietary | https://snyk.io |
| Dependabot | Free (GitHub-native) | Proprietary | https://github.com/dependabot |
| Renovate | Open source + Commercial (Mend) | AGPL-3.0 | https://docs.renovatebot.com |
| Trivy | Open source | Apache-2.0 | https://trivy.dev |
| Grype / Syft (Anchore) | Open source | Apache-2.0 | https://github.com/anchore/grype |
| OSV-Scanner (Google) | Open source | Apache-2.0 | https://google.github.io/osv-scanner |
| OWASP Dependency-Check | Open source | Apache-2.0 | https://owasp.org/www-project-dependency-check |
| Black Duck (Synopsys) | Commercial Enterprise | Proprietary | https://www.blackduck.com |
| Endor Labs | Commercial SaaS | Proprietary | https://www.endorlabs.com |
| FOSSA | Commercial SaaS + limited free | Proprietary | https://fossa.com |

---

## Feature Analysis by Solution

### Snyk

**Core features**
- Software Composition Analysis (SCA) for 40+ language ecosystems and package managers
- IDE plugins providing real-time dependency vulnerability detection before commit
- PR checks: automated vulnerability scanning on every pull request with inline PR comments
- Reachability-based prioritisation: identifies whether vulnerable code is actually callable in the application
- AI-powered fix suggestions: generates pull requests with version bumps and code changes where required
- License compliance scanning alongside vulnerability detection
- SBOM generation (SPDX and CycloneDX) for compliance and regulatory reporting

**Differentiating features**
- Reachability analysis is the strongest noise-reduction feature in developer-facing SCA tools
- AI-powered fix PRs that handle API migrations (not just version bumps) when a fix requires code changes

**UX patterns**
- IDE-first with real-time highlighting: developers see vulnerabilities as they add dependencies
- Priority score (0–1000) combining CVSS, exploit availability, reachability, and package age
- Fix wizard guides developers through selecting the safest upgrade path with diff previews

**Integration points**
- GitHub, GitLab, Bitbucket, Azure DevOps PR decoration
- VS Code, IntelliJ, Eclipse, Visual Studio IDE plugins
- Jenkins, CircleCI, GitHub Actions CLI integration
- Jira for vulnerability issue tracking
- REST API and webhooks for SIEM/SOAR integration

**Known gaps**
- Free tier caps (200 tests/month) reached quickly by active teams
- Reachability analysis is less accurate for dynamic languages (Python, Ruby, JavaScript) than for compiled ones
- Per-developer pricing scales steeply at 100+ developer organisations

**Licence / IP notes**
- Proprietary SaaS. CLI tool (snyk-cli) is Apache-2.0 for the client binary.

---

### Dependabot

**Core features**
- Native GitHub integration: automatically opens pull requests when CVEs affect direct dependencies
- Separate security updates (CVE-triggered) and version updates (keep dependencies current) workflows
- Configurable update schedules, allowed/blocked versions, and reviewer assignment
- Supports 20+ package ecosystems (npm, pip, Maven, Cargo, Go modules, etc.)
- GitHub Security Advisory integration: vulnerability database source
- Grouped updates: batch multiple version bumps into a single PR (GitHub Actions only)

**Differentiating features**
- Zero-cost for GitHub users: no subscription required, deepest native GitHub integration
- Automatically assignable to AI coding agents for remediation (GitHub April 2026 announcement)

**UX patterns**
- Zero-configuration start: enable in repository settings with a single click
- `.github/dependabot.yml` file for configuration; committed alongside code
- Fix PRs include changelog excerpts and release notes for the upgraded version

**Integration points**
- GitHub only (no GitLab, Bitbucket, self-hosted Git)
- GitHub Actions for workflow triggers
- GitHub Security Advisory database

**Known gaps**
- GitHub-only: teams on other VCS platforms cannot use it
- No reachability analysis: all CVEs in detected dependencies are reported regardless of exploitability
- No SBOM generation
- Supply chain trust risk: Dependabot PRs can be weaponised to inject malicious updates (documented April 2026 axios incident)
- No license compliance scanning

**Licence / IP notes**
- Proprietary (GitHub product). No embedded code risk.

---

### Renovate

**Core features**
- Automated dependency update PRs across 60+ package managers — the broadest ecosystem coverage of any tool
- Security-triggered PRs: immediately opens a PR when a new CVE is published for an installed dependency (via OSV and GitHub Advisory integration)
- Configurable automerge rules: automatically merge minor/patch updates that pass CI
- Dependency dashboard: a single issue tracking all pending and scheduled updates
- Monorepo support: manages per-package update PRs in a single repository
- Custom presets: shared configuration templates for standardising update policies across an organisation

**Differentiating features**
- 60+ package managers is the widest language/ecosystem support of any update tool
- Automerge with CI validation reduces manual PR review for low-risk updates
- Organisation-wide presets enable centralised policy with per-repo overrides

**UX patterns**
- Dependency Dashboard issue provides a single view of all pending updates with categorised sections
- PR descriptions include release notes, changelog links, and dependency graph context
- `renovate.json` configuration committed to the repository

**Integration points**
- GitHub, GitLab, Bitbucket, Azure DevOps, Gitea, Forgejo
- OSV.dev, GitHub Advisory, npm Advisory (vulnerability sources)
- CI/CD via standard PR-triggered pipelines

**Known gaps**
- AGPL-3.0 licence requires legal review before commercial embedding
- Complex JSON configuration becomes difficult to manage at scale without shared presets infrastructure
- No reachability analysis
- No SBOM generation
- Same supply chain trust risk as Dependabot: automerge policies must be carefully scoped

**Licence / IP notes**
- AGPL-3.0 (self-hosted). Products distributing Renovate must open-source modifications or obtain a commercial licence from Mend.io. Interface via subprocess rather than embedding for proprietary products.

---

### Trivy (Aqua Security)

**Core features**
- Multi-target scanner: container images, filesystems, git repositories, Kubernetes clusters, IaC (Terraform, CloudFormation, Helm)
- Vulnerability database aggregating NVD, OSV, and ecosystem-specific advisories
- SBOM generation in SPDX 2.x and CycloneDX 1.4/1.5 formats
- Secret detection: flags API keys and credentials embedded in scanned targets
- IaC misconfiguration detection: Terraform, Kubernetes YAML, Dockerfile best-practice violations
- Kubernetes cluster audit: scans running cluster resources for vulnerabilities and misconfigurations

**Differentiating features**
- Broadest scanner coverage of any single open-source tool: image + filesystem + git + k8s + IaC in one binary
- No separate database setup required: vulnerability DB is downloaded and cached automatically

**UX patterns**
- Single binary; `trivy image nginx:latest` is the entire setup for first use
- Table, JSON, SARIF, and CycloneDX output formats for different consumer integrations
- Exit code conventions for CI pass/fail gates

**Integration points**
- GitHub Actions, GitLab CI, Jenkins, CircleCI via CLI
- Harbor registry (built-in scanning backend)
- SARIF upload to GitHub Advanced Security
- Kubernetes admission controller (Trivy Operator)

**Known gaps**
- March 2026 supply-chain compromise of Trivy's own release infrastructure suspended vulnerability DB updates temporarily — a significant trust incident
- No reachability analysis: all detected CVEs reported regardless of exploitability
- No PR automation or fix suggestion; detection-only
- Breadth means less depth per scanner type compared to specialised tools

**Licence / IP notes**
- Apache-2.0. No commercial restrictions.

---

### Grype / Syft (Anchore)

**Core features**
- Syft generates comprehensive SBOMs from container images, directories, and archives (SPDX, CycloneDX, Syft JSON)
- Grype scans SBOMs for vulnerabilities using composite risk scoring: CVSS + EPSS exploit probability + KEV catalog status
- Default sort order surfaces the most actionable findings first (exploitable + reachable > theoretical)
- Fast scanning: purpose-built for CI/CD gate use without timeout risk
- Anchore Enterprise adds policy management, RBAC, and reporting on top of the OSS tools

**Differentiating features**
- EPSS + KEV composite scoring is the most sophisticated risk prioritisation of any open-source tool
- SBOM-first architecture: generate the SBOM once, scan it multiple times against evolving vulnerability data

**UX patterns**
- Two-tool workflow: `syft <target>` generates SBOM, `grype <sbom>` scans it
- JSON and table output modes; JSON enables downstream processing
- Configurable ignore rules via `.grype.yaml` for accepted vulnerabilities

**Integration points**
- GitHub Actions, Jenkins, CircleCI via CLI
- SARIF output for GitHub Advanced Security
- Anchore Enterprise for policy management layer

**Known gaps**
- No PR automation or fix suggestions; detection-only
- Two-tool workflow adds complexity vs. single-binary tools like Trivy
- No IaC or secret scanning (image and SBOM focus only)
- No license compliance beyond package identity in the SBOM

**Licence / IP notes**
- Apache-2.0. No commercial restrictions.

---

## Cross-Cutting Feature Themes

### Table-Stakes Features

Any viable solution in this space must provide:

- Vulnerability scanning for direct and transitive dependencies across major package ecosystems (npm, pip, Maven, Go modules, Cargo, RubyGems)
- CVE/vulnerability database integration (NVD, OSV, or GitHub Advisory at minimum)
- CVSS severity scoring and categorisation
- PR-triggered automated scanning with inline PR annotation
- CI/CD CLI integration with configurable pass/fail gates
- SBOM generation (CycloneDX or SPDX)
- Fix PR generation for version-bump remediation
- JSON/SARIF output for integration with security dashboards

### Differentiating Features

Capabilities that provide competitive advantage:

- **Reachability analysis**: determining whether vulnerable code is actually callable from application entry points — Endor Labs reports 90%+ noise reduction vs. flat CVE lists
- **Composite risk scoring**: combining CVSS + EPSS exploit probability + KEV catalog status to surface the 5% of CVEs warranting immediate action
- **AI-powered fix PRs with code changes**: handling fixes that require API migration or interface changes, not just version bumps
- **Supply chain provenance verification**: checking SLSA attestations and Sigstore signatures for dependency integrity
- **Multi-source scanning**: extending beyond git to cover container images, IaC, and CI/CD environment variables
- **License compliance alongside vulnerability data**: unified view prevents separate tooling for license audits
- **Policy-as-code with natural-language authoring**: expressing organisational dependency rules without manual YAML/Rego

### Underserved Areas / Opportunities

- **Reachability analysis for open-source users**: currently locked behind expensive commercial tools (Endor Labs, Snyk Pro). Open-source AI-assisted call graph analysis would democratise this for all ecosystems.
- **Anomalous package behaviour detection**: proactively detecting supply chain attacks (unusual post-install hooks, unexpected network calls, suspicious maintainer activity) before CVE publication.
- **63% of GitHub Advisory entries lack patch links**: NVD metadata is frequently incomplete; AI can enrich vulnerability records from changelogs, issue trackers, and commit history to fill these gaps.
- **Natural-language policy definition**: replacing YAML/Rego policy files with plain-language rules that non-AppSec engineers can author and maintain.

### AI-Augmentation Candidates

- **Reachability analysis via LLM-assisted call graph construction**: replacing expensive static analysis with LLM-powered code understanding to determine exploitability across dynamic languages.
- **Intelligent fix-PR generation**: LLM analyses changelog between vulnerable and fixed versions, understands breaking changes, and generates the actual code modifications needed — not just version pin updates.
- **Prioritisation beyond CVSS**: AI model combining EPSS, KEV catalog, repository-specific call graph data, and threat intelligence to rank remediation urgency.
- **Supply chain provenance anomaly detection**: ML/LLM model detecting behavioural anomalies in package releases (entropy changes, new network calls, maintainer changes) that precede CVE publication.

---

## Legal & IP Summary

Key licence considerations:

- **Renovate (AGPL-3.0)**: products distributing Renovate require source release or a Mend.io commercial licence. Interface via subprocess or Mend managed API rather than embedding.
- **Trivy, Grype, Syft, OSV-Scanner, OWASP Dependency-Check (Apache-2.0)**: unrestricted commercial use and embedding.
- **EvoSuite (LGPL-3.0)**: if used as a test generation component, dynamic linking is safe; static linking requires review.

No active patents were identified covering the core SCA techniques (CVE database lookup, SBOM generation, dependency graph construction). EPSS scoring is an open standard from FIRST.org with no patent encumbrances. Reachability-based analysis is described in academic literature with no known commercial patent claims as of April 2026.

---

## Recommended Feature Scope

**Must-have (MVP)**
- Multi-ecosystem vulnerability scanning (npm, pip, Maven, Go modules, Cargo, RubyGems, NuGet)
- OSV.dev + NVD + GitHub Advisory vulnerability database integration
- CVSS + EPSS composite risk scoring with remediation priority ranking
- SBOM generation (CycloneDX 1.5 and SPDX 2.3)
- Automated fix PR generation for version-bump remediations
- GitHub, GitLab, Bitbucket PR decoration and CI/CD CLI gates

**Should-have (v1.1)**
- Call-graph-based reachability analysis to suppress non-exploitable findings
- AI-powered fix PRs that handle API migrations and interface changes beyond version bumps
- License compliance scanning with configurable allowed/blocked license policies
- Container image scanning (OS packages + language dependencies)
- Natural-language policy authoring for organisational dependency rules

**Nice-to-have (backlog)**
- Supply chain behavioural anomaly detection (pre-CVE suspicious package activity)
- IaC misconfiguration detection (Terraform, Kubernetes, Dockerfile) in the same scan
- SLSA attestation and Sigstore signature verification for dependency provenance
- Multi-repo SBOM management dashboard with organisation-wide vulnerability aggregation

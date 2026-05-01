# Developer Experience (DX) Analytics — Feature & Functionality Survey

> Candidate #20 · Researched: 2026-04-22

## Solutions Analysed

| Tool | Type | Licence / Model | URL |
|------|------|-----------------|-----|
| DX (Atlassian, acq. Sept 2025) | Commercial (Atlassian) | Proprietary | https://getdx.com |
| LinearB | Commercial + freemium | Proprietary | https://linearb.io |
| Jellyfish | Commercial | Proprietary | https://jellyfish.co |
| Faros AI | Commercial | Proprietary | https://faros.ai |
| Swarmia | Commercial + freemium | Proprietary | https://swarmia.com |
| Plandek | Commercial | Proprietary | https://plandek.com |
| Cortex | Commercial | Proprietary | https://cortex.io |
| CodePulse | Commercial (freemium) | Proprietary | https://codepulse.dev |
| Apache DevLake | Open source | Apache-2.0 | https://devlake.apache.org |
| Gitrecap | Open source / SaaS | Open source | https://gitrecap.com |

---

## Feature Analysis by Solution

### DX (acquired by Atlassian, September 2025, ~$1B)

**Core features**
- Automated metric collection: DORA four metrics, SPACE dimensions, and custom signal ingestion from GitHub, GitLab, Jira, PagerDuty
- Developer surveys: structured periodic surveys aligned with the DevEx/DX Core 4 framework (feedback loops, cognitive load, flow state)
- Survey-to-metric correlation: automatically correlates qualitative survey sentiment with quantitative delivery metrics
- Benchmarking: compare team metrics against anonymised industry benchmarks at company size and industry level
- Manager dashboards: team-level delivery health and developer experience scores with trend analysis
- Developer portal: per-developer view of their own metrics and survey responses (opt-in)

**Differentiating features**
- Most rigorous survey + metrics hybrid in the market: co-created with Nicole Forsgren and Abi Noda — the researchers behind the DORA and DevEx frameworks
- Survey-to-metric correlation is unique: tells managers *whether* high cognitive load survey responses correlate with PR cycle time or deployment frequency degradation at the team level
- Atlassian distribution: post-acquisition, DX will be bundled with Atlassian enterprise agreements covering 300,000+ organisations

**UX patterns**
- Team health dashboard: DORA metrics + survey scores in a single view with trend sparklines
- Survey delivery: Slack-native survey distribution with contextual prompts (e.g., after a long PR review wait)
- Insight cards: AI-generated summaries of significant metric changes with suggested interventions

**Integration points**
- GitHub, GitLab, Bitbucket (VCS)
- Jira, Linear, Shortcut (issue tracking)
- PagerDuty, OpsGenie (incident data for MTTR)
- Slack for survey delivery and notification

**Known gaps**
- Post-Atlassian-acquisition integration risk: roadmap may be subordinated to Atlassian toolchain priorities
- Less actionable for individual contributors than for engineering managers; IC-facing features are limited
- Commercial only; no self-hosted option for data-sovereignty requirements

**Licence / IP notes**
- Proprietary SaaS (Atlassian product since September 2025).

---

### LinearB

**Core features**
- DORA four metrics dashboard: deployment frequency, lead time, change failure rate, MTTR from GitHub/GitLab
- PR cycle time breakdown: time in draft, waiting for review, reviewing, waiting for merge
- gitStream: programmable PR automation rules (routing, labelling, auto-merge conditions) triggered by metric thresholds
- Engineering benchmarks: compare DORA metrics against anonymised peer-company data
- Free DORA dashboard tier: accessible without a sales conversation for teams ≤10

**Differentiating features**
- gitStream automation closes the loop between measurement and improvement: a slow review-time metric can trigger an auto-assignment rule without manual intervention
- Free DORA tier is the lowest-friction entry point in the market; reduces adoption barrier for small teams
- Workflow automation (not just reporting) differentiates LinearB from pure analytics tools

**UX patterns**
- DORA dashboard with trend charts, team comparison, and deployment detail drill-down
- PR detail view: per-PR cycle time breakdown with reviewer history
- gitStream workflow editor: YAML rules with a preview of what would have triggered on past PRs

**Integration points**
- GitHub, GitLab, Bitbucket (VCS + PR data)
- Jira, Linear for issue-to-PR linking and lead time calculation
- PagerDuty, OpsGenie for incident MTTR
- Slack for metric threshold notifications

**Known gaps**
- Limited qualitative signal: no developer surveys or wellbeing tracking
- gitStream workflow automation is GitLab/GitHub-only; no support for Azure DevOps
- No service-level metrics; all analysis is at PR and deployment level

**Licence / IP notes**
- Proprietary SaaS.

---

### Apache DevLake

**Core features**
- Open-source dev data platform with a plugin-based ingestion architecture
- 40+ integrations: GitHub, GitLab, Jira, Jenkins, PagerDuty, SonarQube, ArgoCD, and more
- DORA metrics computed from ingested data in a unified SQL-queryable data lake (MySQL or PostgreSQL)
- Pre-built Grafana dashboards for DORA, PR cycle time, and issue flow metrics
- Custom metric definition: write SQL against the DevLake schema to compute team-specific metrics
- Blueprints: scheduled data collection and metric computation jobs

**Differentiating features**
- Only Apache-2.0 licensed unified engineering intelligence platform: all data stays in your infrastructure
- Custom metric flexibility: SQL-queryable schema allows any metric the organisation defines, not just what the vendor pre-built
- Broadest integration coverage of any OSS tool: 40+ connectors covering CI, VCS, issue tracking, and incident management

**UX patterns**
- Grafana-based dashboards with pre-built DORA and PR analytics panels
- DevLake Config UI: web-based connection and blueprint configuration
- SQL query interface: analysts can query the raw DevLake schema for ad-hoc analysis

**Integration points**
- GitHub, GitLab, Bitbucket, Azure DevOps, Gerrit (VCS)
- Jira, GitHub Issues, TAPD, Monday.com (issue tracking)
- Jenkins, GitHub Actions, CircleCI, ArgoCD (CI/CD)
- PagerDuty, OpsGenie (incident management)
- SonarQube, Grafana, Kibana (observability)

**Known gaps**
- No qualitative signal: no developer survey capability
- Requires infrastructure investment: Docker Compose or Kubernetes deployment with MySQL/PostgreSQL
- No AI layer: all analysis is pre-built dashboards or raw SQL; no natural language interface
- Community support only; no SLA or enterprise support tier

**Licence / IP notes**
- Apache-2.0. Unrestricted commercial use, embedding, and extension.

---

### Swarmia

**Core features**
- DORA metrics + SPACE framework metrics in a single dashboard
- Built-in developer surveys: periodic pulse checks aligned with DX Core 4 dimensions
- Automatic survey-to-metric correlation: surfaces when survey sentiment changes correlate with metric degradation
- PR workflow analytics: review time, request-to-review lag, and PR size distribution
- Engineering agreements: team-set norms for PR size, review response time, and meeting load with automated tracking
- Code review distribution: identifies review bottlenecks and uneven reviewer load

**Differentiating features**
- Best balance of quantitative metrics and qualitative surveys for mid-market teams (10–200 developers)
- Engineering agreements feature is unique: teams set their own norms and Swarmia tracks compliance automatically — shifting from manager-imposed metrics to team-owned targets
- Free tier for ≤9 developers makes it accessible to small teams

**UX patterns**
- Team dashboard: DORA trend charts, PR cycle time breakdown, and survey score in one view
- Survey delivery: Slack-native with contextual timing (e.g., after a release or a large PR)
- Engineering agreements panel: team-set targets vs. actual metrics with weekly delta

**Integration points**
- GitHub, GitLab (VCS)
- Jira, Linear, GitHub Issues (issue tracking)
- Slack for survey delivery and daily digests
- PagerDuty for incident MTTR

**Known gaps**
- Less strong at 200+ developers: dashboard becomes harder to navigate at large team counts
- Azure DevOps not supported
- No service-level metrics or catalog integration

**Licence / IP notes**
- Proprietary SaaS.

---

## Cross-Cutting Feature Themes

### Table-Stakes Features

Any viable solution in this space must provide:

- DORA four metrics: deployment frequency, lead time for changes, change failure rate, and MTTR — computed from VCS and incident data
- GitHub and GitLab integration for PR and deployment data ingestion
- PR cycle time breakdown: time waiting for review, in review, and waiting to merge
- Trend dashboards with configurable time windows (weekly, monthly, quarterly)
- Team-level aggregation (not individual developer surveillance)
- Alert or digest notification on significant metric changes via Slack

### Differentiating Features

Capabilities that provide competitive advantage:

- **Survey + metric correlation**: automatically surfacing whether developer-reported cognitive load or flow state changes correlate with delivery metric degradation (DX, Swarmia — no OSS equivalent)
- **AI-generated causal narration**: explaining *why* a DORA metric degraded rather than just *that* it degraded — connecting metric changes to specific code, team, or process signals
- **Ambient behavioural signal collection without surveys**: inferring developer wellbeing and cognitive load from PR comment tone, context-switching frequency, and after-hours activity patterns
- **Privacy-preserving team-level aggregation**: deliberately aggregating to team level to prevent individual surveillance anxiety — required for European enterprise and engineering union contexts
- **AI-code contribution tracking**: distinguishing AI-generated code contribution rates from human-authored code as a variable in DORA metric analysis

### Underserved Areas / Opportunities

- **AI-generated causal root cause for DORA degradation**: every tool shows a red dashboard when lead time increases. No tool explains "lead time increased because PR size grew 40% this sprint, correlating with three features merged without review assignment rules." This causal narration is the primary gap.
- **Open-source survey + metric hybrid**: DX and Swarmia both combine surveys with metrics, but both are proprietary SaaS. Apache DevLake has no survey layer. An open-source unified platform filling this gap would capture the market DX's Atlassian acquisition leaves open.
- **AI-generated code as a DORA variable**: the 2024 DORA report found AI adoption correlated with delivery instability. No tool tracks AI code contribution rates alongside DORA metrics or can differentiate AI-caused instability from other failure modes.
- **Privacy-preserving wellbeing inference**: survey fatigue limits qualitative signal. AI inference from ambient behavioral signals (without surveys) is unaddressed in any current tool.

### AI-Augmentation Candidates

- **Causal narration for DORA degradation**: LLM correlates metric degradation with specific contributing signals — PR size increases, CI flakiness, reviewer bottlenecks, monorepo restructuring — and generates manager-readable explanations of what changed and what to do.
- **Ambient wellbeing inference without surveys**: model trained on PR comment tone, time-to-first-review patterns, after-hours commit frequency, and context-switching signals provides always-on qualitative wellbeing signals without survey fatigue.
- **AI code contribution tracking**: tracks AI-generated vs. human-authored code contribution rates across the team and correlates with DORA stability metrics — addressing the gap identified in the 2024 DORA report.
- **Privacy-preserving team narrative generation**: LLM generates weekly team health narratives aggregated at the team level, flagging systemic process problems ("review bottleneck: 2 reviewers handling 80% of load in authentication service") without exposing per-developer data.
- **Personalised manager coaching**: LLM analyses a team's metric and survey history to generate specific, actionable coaching recommendations for the engineering manager — not generic DORA improvement advice but team-specific interventions.

---

## Legal & IP Summary

Key licence considerations:

- **Apache DevLake (Apache-2.0)**: unrestricted commercial use, embedding, and extension. The safe open-source foundation for building on top of.
- **Gitrecap (open source)**: permissive; safe to use and extend.
- **DX (Atlassian), LinearB, Jellyfish, Faros AI, Swarmia, Plandek, Cortex, CodePulse (Proprietary SaaS)**: feature inspiration carries no IP risk; API integration requires commercial agreements.

DORA metrics (Forsgren, Humble, Kim — *Accelerate*) are published research with no IP encumbrances. SPACE framework (Forsgren et al., ACM Queue 2021) and DX Core 4 framework (Noda et al., ACM Queue 2023) are academic publications. Flow Framework (Mik Kersten, *Project to Product*) is documented in a published book. None carry known patent claims. AI-based inference of developer wellbeing from behavioral signals is a generic ML application with no known specific patents as of April 2026.

---

## Recommended Feature Scope

**Must-have (MVP)**
- DORA four metrics computed from GitHub and GitLab VCS and CI/CD data
- PR cycle time breakdown: draft time, review-wait time, review time, merge-wait time
- Team-level aggregation with configurable team definitions (privacy-preserving by default)
- Trend dashboards with weekly, monthly, and quarterly views
- Slack digest and threshold alert for significant metric changes
- Self-hostable with Apache DevLake as the data platform foundation (Apache-2.0)

**Should-have (v1.1)**
- AI-generated causal narration: LLM weekly team health summary explaining metric changes with correlated contributing signals
- Developer pulse surveys: Slack-native periodic surveys aligned with DX Core 4 dimensions
- Survey-to-metric correlation: automatic detection of qualitative-quantitative alignment
- AI code contribution tracking: distinguish AI-generated from human-authored code and correlate with DORA stability
- Jira and Linear integration for issue-to-deployment lead time calculation

**Nice-to-have (backlog)**
- Ambient wellbeing inference: AI model inferring cognitive load and flow state from behavioral signals without surveys
- Engineering agreements: team-set norms with automated compliance tracking
- Industry benchmarking: anonymised peer comparison at company size and industry level
- Manager coaching recommendations: LLM-generated specific, team-tailored interventions based on metric and survey history
- Azure DevOps and Gerrit integration for teams outside the GitHub/GitLab ecosystem

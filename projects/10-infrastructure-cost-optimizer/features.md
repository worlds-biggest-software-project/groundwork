# Infrastructure Cost Optimizer — Feature & Functionality Survey

> Candidate #10 · Researched: 2026-04-22

## Solutions Analysed

| Tool | Type | Licence / Model | URL |
|------|------|-----------------|-----|
| CloudZero | Commercial SaaS | Proprietary subscription | https://www.cloudzero.com/ |
| Harness Cloud Cost Management | Commercial SaaS | Proprietary enterprise contract | https://www.harness.io/products/cloud-cost-management |
| Vantage | Commercial SaaS | Proprietary subscription (spend-tiered) | https://www.vantage.sh/ |
| Finout | Commercial SaaS | Proprietary enterprise contract | https://www.finout.io/ |
| CAST AI | Commercial SaaS | Proprietary contract | https://cast.ai/ |
| Infracost | Open source (CLI) + Commercial cloud tier | Apache 2.0 (CLI); proprietary (Cloud) | https://www.infracost.io/ |
| OpenCost | Open source | Apache 2.0 | https://opencost.io/ |
| Kubecost | Freemium + Commercial | Apache 2.0 (free tier); proprietary (Enterprise) | https://www.apptio.com/products/kubecost |
| Cloud Custodian | Open source | Apache 2.0 | https://cloudcustodian.io/ |
| nOps | Commercial SaaS | Proprietary spend-based subscription | https://www.nops.io/ |

---

## Feature Analysis by Solution

### CloudZero

**Core features**
- Code-driven cost allocation that does not require complete infrastructure tagging
- Hourly cost granularity with 24+ months of historical data (most competitors offer daily)
- Anomaly detection comparing 36-hour and 12-month patterns
- Unit economics tracking: cost per customer, cost per feature, cost per transaction
- Tiered budgeting and forecasting with custom groupings
- AnyCost™ API for ingesting spend from non-standard cost sources (OpenAI, Anthropic, Datadog, etc.)
- Unlimited user seats at all subscription tiers
- 50+ cloud and SaaS provider integrations

**Differentiating features**
- Two years of hourly historical data gives finer-grained trend analysis than daily-resolution competitors
- AnyCost™ API treats any cost stream as a first-class data source, enabling unit economics across AI/ML API spend
- Dedicated FinOps account manager included at every subscription tier, not sold separately

**UX patterns**
- 14-day free trial with account-manager-led onboarding
- Predictable tiered pricing with no overage charges
- Custom grouping via code-driven model reduces tagging prerequisite
- Some reviewers note navigation is unintuitive for advanced analytics

**Integration points**
- REST API v2 (JSON, standard HTTP)
- AnyCost™ ingestion API for custom cost sources
- Providers: AWS, Azure, GCP, Kubernetes, Snowflake, Datadog, OpenAI, Anthropic, MongoDB
- LiteLLM integration for LLM cost tracking

**Known gaps**
- Optimization recommendations are limited relative to commercial competitors
- No Oracle Cloud Infrastructure support
- No Jira integration (commonly requested)
- Dashboard filtering and sorting capability is limited
- No MSP or multi-tenant partner billing controls

**Licence / IP notes**
- Fully proprietary SaaS. No code is available for adoption. No patent concerns identified in public materials.

---

### Harness Cloud Cost Management

**Core features**
- Unified multi-cloud cost visibility across AWS, Azure, and GCP
- AutoStopping: automatically shuts down idle non-production environments, claiming up to 70% savings on that subset
- Commitment Orchestrator: autonomous Reserved Instance and Savings Plan execution with contract tracking
- Kubernetes cost allocation and chargeback/showback at namespace level
- 150+ built-in governance rules with custom YAML policy authoring
- Real-time anomaly detection with recommendations
- Conversational AI assistant for ad-hoc cost queries
- Hierarchical budgeting with forecasting
- FOCUS (FinOps Open Cost and Usage Specification) ingestion support
- FinOps Foundation certified

**Differentiating features**
- AutoStopping is the most fully automated environment-idle shutdown feature in the market; it requires no manual scheduling
- Commitment Orchestrator tracks contract history alongside autonomous purchasing, providing an audit trail
- Native integration into the broader Harness CI/CD platform means cost context is available within deployment pipelines without a separate tool

**UX patterns**
- Pre-built dashboards with limited customisation options
- AI assistant interface for ad-hoc queries reduces need to learn dashboard navigation
- Steep onboarding curve for teams outside the Harness CI/CD ecosystem
- Automation-heavy design means less granular manual control

**Integration points**
- Full REST API with JSON/YAML support
- Webhooks with HMAC signature verification for pipeline triggers
- ITSM: Slack, Jira, ServiceNow
- Native Harness CI/CD pipeline integration
- Custom CI/CD endpoint for non-Harness pipelines

**Known gaps**
- AutoStopping is difficult to implement at scale across large, heterogeneous environments
- Reporting capabilities are limited without custom development
- Pricing is prohibitive for smaller teams
- Dashboard customisation is restricted compared to BI-tool-backed competitors

**Licence / IP notes**
- Fully proprietary SaaS. FOCUS specification it consumes is Apache 2.0 / FinOps Foundation open standard — no IP concern. No patent concerns identified.

---

### Vantage

**Core features**
- Multi-cloud cost reports and budgeting: AWS, Azure, GCP
- Virtual tagging to allocate costs from untagged resources without infrastructure changes
- Kubernetes namespace and label-based cost breakdown
- Anomaly detection with custom alert thresholds
- Automated waste identification (idle resources, oversized instances)
- Autopilot for AWS Savings Plans (commitment automation)
- Terraform provider for policy-as-code FinOps
- SaaS spend integration: Datadog, Snowflake, MongoDB, Databricks
- MCP Server (self-hosted or managed) for AI agent cost queries
- Budget alerts and 12-month forecasting

**Differentiating features**
- MCP Server enables AI agents (Claude, ChatGPT) to query cost data programmatically — the only commercial tool with a published MCP integration at time of research
- Terraform provider allows cost budgets and anomaly thresholds to be version-controlled alongside infrastructure
- Developer-first positioning: native Slack, Jira, and Microsoft Teams integrations without enterprise contract requirements

**UX patterns**
- Lightweight, intuitive interface praised by smaller and mid-market teams
- Quick setup with minimal configuration (days, not weeks)
- MCP Server available as self-hosted or fully managed option
- Less suitable for large enterprises requiring granular multi-tenant allocation

**Integration points**
- REST API (rate-limited: 1,000 req/hr general; 5 req/5s for Cost Reports)
- MCP Server tools: query-costs, list-cost-reports, get-forecasts, list-integrations, list-budgets
- Cloud: AWS, Azure, GCP
- SaaS: Datadog, Snowflake, MongoDB, Databricks
- Terraform provider for IaC-integrated budgets
- Slack, Jira, Microsoft Teams, GitHub

**Known gaps**
- 24-hour data latency is frustrating for teams wanting near-real-time feedback
- Optimisation stops at recommendations — no automated remediation
- Kubernetes visibility lacks efficiency benchmarking against peer clusters
- Commitment automation is limited to basic Savings Plan purchases; no RI portfolio management

**Licence / IP notes**
- Fully proprietary SaaS. Terraform provider is MIT-licensed (open adoption). No patent concerns identified.

---

### Finout

**Core features**
- 100% cost allocation without mandatory tagging via Virtual Tags (VTags)
- AI-powered VTag auto-assignment using resource context signals
- MegaBill: unified billing dashboard across cloud, SaaS, and AI spend
- Multi-cloud support: AWS, GCP, Azure, OCI
- CostGuard: automated waste detection and elimination
- Dedicated AI Cost Management module for OpenAI, Anthropic, and ML workloads
- Financial forecasting and commitment utilisation tracking
- SaaS spend: Kubernetes, Snowflake, Databricks, Datadog, Slack
- FinOps adoption dashboards with org-wide accountability metrics
- Integration via cloud provider connectors (no agents or code required)

**Differentiating features**
- AI-powered allocation without tagging is the most developed implementation of this capability in the market; competitors offer virtual tags but without automated inference
- MegaBill treats AI API spend (OpenAI, Anthropic) as a first-class cost dimension alongside cloud infrastructure
- No code or agent deployment required for integration — API-only connector model

**UX patterns**
- 2–4 week time-to-value with connector-based onboarding
- Unified planning interface consolidates finance and engineering workflows
- Organisation-wide adoption dashboards surface FinOps maturity metrics

**Integration points**
- REST API with client ID / secret key authentication
- Virtual Tags API: CRUD operations for cost categorisation rules
- Cloud: AWS, GCP, Azure, OCI
- SaaS: OpenAI, Anthropic, Kubernetes, Snowflake, Databricks, Datadog, Slack
- BI export via API

**Known gaps**
- Optimisation recommendations require external action; tool is primarily an allocation and visibility platform
- Multi-domain data normalisation (cloud + SaaS + licensing + Kubernetes) is uneven in depth across domains
- Allocation models can lag rapid organisational restructuring

**Licence / IP notes**
- Fully proprietary SaaS. No patent concerns identified in public materials.

---

### CAST AI

**Core features**
- Automated Kubernetes pod rightsizing at millicore (CPU) and mebibyte (memory) level
- Intelligent node autoscaling with bin-packing optimisation
- GPU allocation optimisation for ML workloads
- Spot and preemptible instance automation with up to 30-minute interruption prediction
- Real-time SLO monitoring (error rates, latency, OOM kills) with automated remediation
- Self-healing operations: configuration drift correction, image updates
- Workload-aware instance type matching across 1,000+ instance types
- Predictive analytics trained on data from thousands of production clusters
- Multi-cloud: AWS, GCP, Azure, Oracle Cloud
- Native integration with both Karpenter and Kubernetes Cluster Autoscaler

**Differentiating features**
- 30-minute spot interruption prediction (empirical model trained on fleet data) is longer notice than cloud provider signals provide
- Millicore-level precision in rightsizing recommendations reduces over-correction risk compared to bulk category-based tools
- Empirical claims: 40% average CPU waste and 57% average memory waste observed across 2,100+ customer clusters

**UX patterns**
- Lightweight cluster connector agent for onboarding
- Dashboard with recommendation review and approval workflow before automation is enabled
- Trust-building path: recommendation-only mode → automated mode
- ISO 27001 and SOC 2 compliant

**Integration points**
- Terraform provider (registry.terraform.io/providers/castai)
- REST API with full-access token authentication
- Karpenter native support; also provides own AutoScaler
- Prometheus metrics and OpenTelemetry export
- Jira integration for tracking optimisation actions
- 25+ partner integrations (Helm, Crossplane, Pulumi)

**Known gaps**
- Workload autoscaler and Node autoscaler do not co-optimise cleanly — interaction can cause instability
- Predicted savings sometimes diverge materially from actual results
- Decision logic is opaque; teams report needing time to build confidence before enabling automation
- Kubernetes version upgrade management is difficult within the tool

**Licence / IP notes**
- Fully proprietary SaaS. Terraform provider is open source (Mozilla Public License 2.0). No patent concerns identified.

---

### Infracost

**Core features**
- Terraform cost estimation surfaced as pull request comments before infrastructure is deployed
- Cost difference calculation between current and proposed Terraform configurations
- Policy violation detection at code-review time (missing tags, oversized instances, non-compliant regions)
- AutoFix: automated PR generation with specific Terraform changes to reduce cost or fix policy violations
- Tag governance: detection of missing or incorrect resource tags in IaC
- Support for 1,100+ Terraform resources across AWS, Azure, and GCP
- Multi-region and multi-state file support
- GitHub Enterprise Cloud/Server and GitLab Enterprise support
- No cloud credentials required — cost analysis is performed from code, not live cloud state
- Active open-source community (6,500+ GitHub stars)

**Differentiating features**
- Shift-left FinOps: the only widely adopted open-source tool that integrates cost feedback into the code-review workflow before deployment
- AutoFix generates actionable PR code changes rather than advisory text
- No credential requirement for core analysis reduces security surface area and simplifies CI setup

**UX patterns**
- GitHub App and GitLab App with automatic PR comment posting (minimal manual setup)
- CLI for local cost checking and custom CI/CD pipelines
- Slack community and GitHub Discussions for support
- Quick ROI framing: cost problems caught before they are deployed

**Integration points**
- GitHub App (PR comments with cost breakdowns)
- GitLab App (MR cost comments)
- CLI: `infracost breakdown`, `infracost diff`, `infracost comment`
- CI/CD: GitHub Actions, GitLab CI, Atlantis, Terraform Cloud, Azure DevOps
- Policy-as-code: custom tagging and best-practice rules via OPA-compatible format

**Known gaps**
- Limited to Terraform; Pulumi, CloudFormation, ARM/Bicep support is on the roadmap but not released at time of research
- Hundreds of Terraform state files generate many separate PR comments (consolidation requested)
- Runtime cost feedback (post-deployment actuals vs. estimates) is not provided

**Licence / IP notes**
- CLI and core engine: Apache 2.0. Infracost Cloud (team dashboard, governance features): proprietary. Apache 2.0 code is freely adoptable. No patent concerns identified.

---

### OpenCost

**Core features**
- Real-time Kubernetes cost allocation at container, pod, namespace, controller, and service level
- Dynamic pricing via cloud billing API integration (AWS, Azure, GCP)
- Custom pricing support for on-premises clusters via CSV files
- Out-of-cluster managed service cost visibility (RDS, Cloud SQL, etc.)
- Carbon cost tracking alongside financial costs
- Prometheus metrics export (/metrics endpoint) for observability stack integration
- Model Context Protocol (MCP) server for AI agent cost queries (opt-in, port 8081)
- External cost plugin interface for third-party integrations
- Implements the OpenCost Specification v1.3 (ratified December 2025)
- CNCF Incubating Project backed by Adobe, AWS, Google, Grafana, Microsoft, Oracle

**Differentiating features**
- As the CNCF specification project, OpenCost defines the vendor-neutral standard for Kubernetes cost data — other tools implement against it
- Forever-free, always open source with no feature gating
- MCP Server makes cost data queryable by AI agents without additional development

**UX patterns**
- Helm deployment in minutes (`helm install opencost opencost/opencost`)
- Lightweight, minimal operational overhead suitable for resource-constrained teams
- Community support via CNCF Slack and biweekly open meetings

**Integration points**
- Prometheus /metrics endpoint
- Cloud billing APIs: AWS Cost and Usage Report, Azure Cost Management, GCP Billing
- Custom pricing: CSV file ingestion
- MCP Server (read-only tools): get-cost-data, get-allocation, get-assets
- External cost plugin API for custom integrations
- Helm-based Kubernetes deployment

**Known gaps**
- No multi-cluster aggregated view (each cluster is a separate deployment)
- No alerting, budgeting, or forecasting in the open-source version
- No cloud bill reconciliation (comparing predicted vs. billed costs)
- Scalability under large dynamic cluster conditions required introduction of KubeModel (Data Model 2.0)
- Not designed for multi-cloud rightsizing or commitment management

**Licence / IP notes**
- Apache 2.0. Freely adoptable for any purpose, including commercial products. No patent concerns identified.

---

### Kubecost

**Core features**
- Real-time Kubernetes cluster cost allocation and chargeback at namespace, pod, and label level
- Multi-cluster and multi-cloud aggregated cost visibility
- Cloud bill reconciliation: aligns predicted Kubernetes costs with actual cloud provider billing
- Anomaly detection and 30-day cost forecasting
- Workload rightsizing recommendations
- Automated remediation: request sizing adjustments, namespace turndown scheduling
- Role-based access controls and per-team budget enforcement
- Free tier: up to 250 cores, 15-day retention (Foundations tier)
- Enterprise: self-hosted or SaaS (managed updates in Cloud tier)
- Part of IBM Apptio Cloud Cost Management Optimization suite (acquired September 2024)

**Differentiating features**
- Bill reconciliation aligning Kubernetes predicted costs with actual cloud invoices is a capability absent from OpenCost and most open-source alternatives
- Free tier with meaningful limits makes it accessible to small teams without budget
- Multi-cluster aggregated view enables cost governance across an entire Kubernetes estate

**UX patterns**
- 5-minute Helm installation (`helm install kubecost kubecost/cost-analyzer`)
- Intuitive dashboard with budgeting and forecasting built in
- Three deployment tiers with clear capability differentiation
- IBM acquisition creates uncertainty about future product direction for enterprise buyers

**Integration points**
- Cloud billing APIs: AWS, Azure, GCP for dynamic pricing and reconciliation
- Multi-cluster: aggregated monitoring dashboard
- Kubernetes-native: Helm charts, standard Kubernetes resources
- IBM Apptio integration for broader CCMO workflows
- Grafana dashboard support via Prometheus metrics

**Known gaps**
- Enterprise features (multi-cloud support, advanced allocation) are locked to paid tiers
- Historical CVE vulnerabilities in network-cost dependencies (CVE-2026-27135, CVE-2026-4111, CVE-2026-4424) — requires ongoing patching attention
- IBM integration path (Turbonomic + Apptio + Kubecost) is still being consolidated; product roadmap clarity is limited
- Primarily Kubernetes-focused; no SaaS or AI API cost coverage

**Licence / IP notes**
- Apache 2.0 for free/open tier. Enterprise features are proprietary. Free-tier code is adoptable. Note: IBM ownership means enterprise roadmap decisions are made by IBM. CVE issues cited above should be reviewed before production deployment. No patent concerns identified in the open-source codebase.

---

### Cloud Custodian

**Core features**
- YAML-based policy-as-code DSL for cloud governance and cost enforcement
- Multi-cloud: AWS, Azure, GCP (production); Kubernetes, Tencent Cloud, OpenStack (beta)
- Real-time compliance enforcement using native cloud control plane APIs
- Resource filtering with complex nested boolean expressions
- Cost optimisation automation: off-hours shutdown scheduling, idle resource cleanup
- Security policy enforcement with auto-remediation actions
- Flexible deployment: local CLI, cloud instances, serverless (AWS Lambda)
- Terraform governance integration
- Event-driven execution: CloudWatch Events, Azure Event Grid, GCP Pub/Sub
- CNCF Incubating Project

**Differentiating features**
- YAML DSL that governs both cost and security policies in a single tool is unique in the open-source space
- Native cloud control plane integration provides real-time enforcement rather than periodic scans
- Serverless deployment model eliminates persistent infrastructure overhead

**UX patterns**
- Policy files checked into version control alongside infrastructure code (GitOps-compatible)
- Python CLI for policy execution and testing
- Steep learning curve: requires understanding of cloud APIs and YAML schema
- Community support via Slack, mailing lists, Reddit, biweekly meetings

**Integration points**
- Multi-cloud native APIs: AWS, Azure, GCP
- Terraform validation integration
- AWS Lambda, Azure Functions, GCP Cloud Functions for serverless enforcement
- AWS CloudFormation and CDK integration
- Python SDK for custom extensions
- Event-driven triggers via cloud-native event buses

**Known gaps**
- No GUI — all operations require CLI or YAML authoring; no centralised dashboard for policy status
- No RBAC or audit trail for policy changes (relies on version control discipline)
- No natural language or AI-assisted policy authoring
- High operational overhead: requires dedicated expertise to scale policy management
- No anomaly detection, forecasting, or cost allocation features — governance only

**Licence / IP notes**
- Apache 2.0. Freely adoptable including for commercial products. No patent concerns identified.

---

### nOps

**Core features**
- Autonomous Reserved Instance and Savings Plan purchasing and rebalancing
- Continuous commitment portfolio optimisation without long-term lock-in risk
- AWS cost reporting and allocation (multi-account via AWS Organizations)
- Business Context: maps cloud spend to engineering teams, products, and business units
- Read-only cloud account access model (no infrastructure write permissions required for cost analysis)
- Karpenter integration: NodePool and NodeClass sync via API and Helm-based agent
- Automated commitment delivery targeting up to 55% discount vs. on-demand pricing
- FinOps Foundation Premier Member
- Managing $4B+ annual cloud spend across 500+ companies at time of research
- 5-minute onboarding for cost visibility

**Differentiating features**
- Continuous automated rebalancing of commitment portfolio is more aggressive than ProsperOps-style static optimisation — it responds to workload changes within hours
- Karpenter integration with YAML-driven NodePool/NodeClass config management via API is the deepest Karpenter coupling of any commercial tool reviewed
- Read-only access model for analysis reduces security review friction during procurement

**UX patterns**
- Connect cloud accounts in under 5 minutes; 2–4 week time-to-value for measurable savings
- Dashboard for commitment tracking and cost insights
- Business Context feature maps spend to org structure without requiring re-tagging
- Some reviewers describe the interface as perplexing for non-AWS-specialist users

**Integration points**
- REST API for commitment config, YAML validation, NodePool/NodeClass management
- Karpenter agent via Helm chart
- AWS Organizations IAM role integration
- Primary focus on AWS; limited Azure/GCP support

**Known gaps**
- AWS-focused; limited feature depth for Azure or GCP environments
- Multi-account IAM setup is cumbersome (requires role modification per account)
- Advanced reports are locked behind additional service tiers
- Download restrictions on remediation reports limit audit workflows
- Interface stability and occasional bugs noted in reviews
- Pricing structure is opaque; feature access fragmented across tiers

**Licence / IP notes**
- Fully proprietary SaaS. No patent concerns identified in public materials.

---

## Cross-Cutting Feature Themes

### Table-Stakes Features

Any project in this space must provide these capabilities to be viable:

- Multi-cloud cost visibility dashboard covering at minimum AWS, Azure, and GCP
- Cost allocation by team, product, or business unit (with or without tags)
- Anomaly detection with configurable alert thresholds
- Budgeting with forecast-to-budget variance tracking
- Reserved Instance / Savings Plan utilisation monitoring and recommendations
- Kubernetes namespace and workload cost breakdown
- Rightsizing recommendations for compute (instances and pods)
- REST API for programmatic access to cost data
- At least one native cloud provider integration that does not require deploying agents
- Role-based access controls (finance vs. engineering views)

### Differentiating Features

These capabilities are present in some solutions and provide competitive advantage:

- **100% cost allocation without tagging** — AI-inferred virtual tags that assign untagged resources to owners using context signals (VPC, naming, IAM policies, network topology)
- **Shift-left FinOps** — cost feedback embedded in pull request review before infrastructure is deployed (currently only Infracost, and only for Terraform)
- **AutoStopping / idle environment shutdown** — automated detection and suspension of non-production environments with scheduled or event-triggered restart
- **Autonomous commitment management** — continuous rebalancing of RI/SP portfolio that adjusts to workload changes without manual intervention
- **Unit economics** — cost per customer, cost per feature, or cost per transaction derived from a combination of cloud spend and business metrics
- **MCP server integration** — enables AI agents to query cost data programmatically without dashboard interaction
- **Millicore-level Kubernetes rightsizing** — precision CPU/memory recommendations that avoid over-correction, backed by fleet-scale empirical data
- **Policy-as-code governance** — YAML-defined cost and compliance rules enforced at code review time and at runtime
- **AI/ML workload cost attribution** — token-level LLM API spend, GPU utilisation tracking, and training-vs-inference cost separation

### Underserved Areas / Opportunities

These are genuine gaps shared across most or all reviewed solutions:

- **Open-source autonomous commitment management** — no open-source tool provides transparent, explainable RI/SP/CUD portfolio optimisation; all autonomous commitment tools are proprietary black boxes
- **AI/ML and GPU workload cost allocation** — 98% of FinOps teams now manage AI spend (FinOps 2026 data), yet no open-source tool provides GPU-level attribution, token-level LLM cost tracking, or training-vs-inference separation
- **Cross-IaC shift-left** — Infracost covers Terraform, but Pulumi, CloudFormation, ARM, and Bicep have no equivalent shift-left cost tool
- **Runtime cost feedback in developer workflows** — no tool surfaces actual post-deployment cost feedback in the same PR/pipeline view as pre-deployment estimates; developers must switch to a separate FinOps dashboard
- **Natural language policy authoring** — all policy-as-code tools require YAML or DSL knowledge; AI-assisted policy generation from plain English is absent
- **Multi-provider SaaS + cloud unified open source** — open-source tools cover cloud and Kubernetes but none integrate SaaS spend (Datadog, Snowflake, AI APIs) into a unified open allocation model
- **Carbon cost integration** — OpenCost includes carbon tracking but it is not integrated into optimisation workflows in any commercial tool reviewed

### AI-Augmentation Candidates

These are features currently implemented with manual or rule-based approaches where AI could deliver meaningfully better results:

- **Automatic tag inference** — using LLM-based classification of resource names, VPC membership, IAM policy content, and network topology to assign untagged resources to owners without human input
- **Natural language cost queries** — replacing dashboard navigation with conversational interfaces that interpret questions like "which team caused the spike last Tuesday?" and return precise, cited answers
- **Anomaly root-cause explanation** — current tools detect anomalies but require manual investigation; LLMs trained on cloud billing patterns could explain probable causes (deployment, traffic, configuration change) alongside the alert
- **Commitment portfolio optimisation with explanation** — current autonomous tools are opaque; an AI-native tool could generate human-readable explanations of each commitment decision alongside confidence levels
- **Policy generation from natural language** — converting plain-English governance requirements into executable YAML/OPA policies, reducing the expertise barrier for cost governance
- **Predictive rightsizing from workload semantics** — using application type, deployment patterns, and historical utilisation to recommend not just "smaller instance" but the specific instance family best suited to the workload's memory/CPU/network profile
- **Cross-service cost attribution for shared infrastructure** — inferring which product feature or customer segment caused a cost increase in shared databases, queues, or CDN layers using LLM analysis of access logs and deployment history

---

## Legal & IP Summary

All ten tools reviewed are either fully proprietary (CloudZero, Harness, Vantage, Finout, CAST AI, nOps) or permissively open-source (Infracost CLI, OpenCost, Kubecost free tier, Cloud Custodian — all Apache 2.0). No material was identified with GPL, LGPL, AGPL, or other copyleft licences that would impose viral licensing obligations. The Komiser tool (referenced in research.md but not deep-dived here) uses the Elastic License v2 (ELv2), which prohibits providing the software as a competing managed service — this would need legal review if any Komiser code or design elements were incorporated into a commercial product.

No software patents specifically covering cost allocation, rightsizing recommendations, or commitment portfolio optimisation were identified in the public record. However, CloudZero's AnyCost™ branding suggests at least a trademark; the underlying technology does not appear patent-encumbered based on public materials. ProsperOps's commitment-blending algorithm is proprietary and opaque; its patentability is unknown — independent reimplementation is safe, but copying any published description verbatim would warrant legal review.

No material was omitted due to copyright uncertainty. All feature descriptions in this document are paraphrased from public product pages, documentation, release notes, and publicly available user reviews.

---

## Recommended Feature Scope

Based on the above analysis, a prioritised feature scope for an AI-native, open-source Infrastructure Cost Optimizer:

**Must-have (MVP)**
- Multi-cloud cost visibility: AWS, Azure, GCP ingestion via native billing APIs (no agent required)
- Kubernetes cost allocation via OpenCost Specification v1.3 (compatible with existing OpenCost deployments)
- AI-powered tag inference: automatically assign untagged resources to owners using resource name, VPC, IAM, and network context signals
- Anomaly detection with root-cause explanation generated by LLM (not just alert, but probable cause)
- REST API with full cost data access, filterable by team, service, and time range
- CLI tool for local cost exploration and CI/CD integration

**Should-have (v1.1)**
- Shift-left cost feedback in PRs for Terraform and at least one additional IaC format (CloudFormation or Pulumi)
- Transparent RI/Savings Plan recommendation engine with human-readable justifications (not autonomous purchasing — explainability first)
- AI/ML workload attribution: GPU utilisation cost allocation, LLM API token-level cost tracking (OpenAI, Anthropic, Bedrock)
- Policy-as-code with natural language authoring (translate plain English governance rules to executable YAML)
- Multi-cluster Kubernetes aggregated view with bill reconciliation against cloud provider invoices

**Nice-to-have (backlog)**
- Autonomous commitment purchasing (RI/SP) with confidence scores and rollback capability
- AutoStopping for non-production environments (developer-configurable schedules)
- Carbon cost tracking integrated into optimisation recommendations
- MCP server for AI agent integration (query cost data from Claude, ChatGPT, etc.)
- SaaS spend ingestion (Datadog, Snowflake, Databricks) for unified allocation

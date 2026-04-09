# Master Backlog and Sprint Milestones

## Planning Assumptions
- Sprint length: 2 weeks
- Total planning horizon: 8 sprints
- Estimation scale: Story points (1, 2, 3, 5, 8, 13)
- Primary roles: Data Engineer (DE), Analytics Engineer (AE), ML Engineer (MLE), BI Analyst (BI), Data Platform Engineer (DPE), QA/Observability Engineer (QAE), Product Owner (PO)

## Role Legend
- DE: ingestion, pipelines, orchestration, data reliability operations
- AE: dbt models, snapshots, semantic layer, data tests
- MLE: Snowpark ML training, evaluation, model registry, drift logic
- BI: stakeholder enablement, dashboarding, UAT coordination, adoption metrics
- DPE: CI/CD, environments, access controls, infrastructure guardrails
- QAE: test strategy, quality gate evidence, observability validations
- PO: scope prioritization, acceptance sign-off, cross-team alignment

## Sprint-by-Sprint Milestones

### Sprint 1 (Phase 0)
Milestone: Foundation and control plane ready for governed execution.
- BL-001 Setup Snowflake role/warehouse/schema baseline, grants, resource monitors (8 pts) - Owner: DPE, DE
- BL-002 Configure Codespaces dev tooling baseline (Snowflake CLI, dbt, Snowpark) (5 pts) - Owner: DPE
- BL-003 Implement secrets and least-privilege service accounts (8 pts) - Owner: DPE
- BL-004 Build CI guardrails (lint, tests, dbt parse, slim CI skeleton) (8 pts) - Owner: DPE, AE
- BL-005 Implement PR validation with Snowflake clone strategy (5 pts) - Owner: DPE, AE
- BL-006 Define branch protections and required checks (3 pts) - Owner: DPE, PO
Sprint target: Gate D baseline passes for Phase 0.

### Sprint 2 (Phase I)
Milestone: Governed ingestion and raw landing with source traceability.
- BL-010 Define ingestion data contracts for JSON/CSV event sources (5 pts) - Owner: DE, AE
- BL-011 Configure Airbyte connectors to Snowflake raw landing (8 pts) - Owner: DE
- BL-012 Add ingestion metadata columns and audit fields (3 pts) - Owner: DE
- BL-013 Implement freshness and volume monitors for sources (5 pts) - Owner: QAE, DE
- BL-014 Build reconciliation checks source vs landed counts (5 pts) - Owner: AE, DE
Sprint target: Phase I Batch I.1 completion criteria achieved.

### Sprint 3 (Phase I and Phase II)
Milestone: Late-arriving data reliability plus German data normalization baseline.
- BL-020 Implement Airflow lag sensors for delayed arrivals (5 pts) - Owner: DE
- BL-021 Build dbt incremental lookback models for out-of-order sessions (8 pts) - Owner: AE
- BL-022 Implement idempotent merge strategy for replay handling (8 pts) - Owner: AE, DE
- BL-023 Create Snowpark UDFs for encoding normalization edge cases (5 pts) - Owner: MLE, AE
- BL-024 Implement umlaut and regional abbreviation macros/mappings (5 pts) - Owner: AE
Sprint target: Phase I Batch I.2 and Phase II Batch II.1 technical readiness.

### Sprint 4 (Phase II and Phase III)
Milestone: Financial parsing and historical semantic core foundation.
- BL-030 Implement German currency parser and power-of-ten normalization (8 pts) - Owner: AE
- BL-031 Add malformed value handling and parsing quality tests (5 pts) - Owner: AE, QAE
- BL-032 Define SCD2 snapshot contract for dim_users (5 pts) - Owner: AE
- BL-033 Implement dbt snapshots with overlap/current-record tests (8 pts) - Owner: AE
- BL-034 Build no-orphan transaction relationship tests (5 pts) - Owner: AE, QAE
Sprint target: Phase II complete and Phase III Batch III.1 complete.

### Sprint 5 (Phase III and Phase IV)
Milestone: Feature engineering ready for ML and initial clustering model.
- BL-040 Build rolling 30/60/90 RFM window features (8 pts) - Owner: AE
- BL-041 Implement deterministic identity resolution keys (5 pts) - Owner: AE, DE
- BL-042 Build Snowpark KMeans training pipeline in dbt Python (8 pts) - Owner: MLE
- BL-043 Run candidate-k evaluation and publish cluster metadata (5 pts) - Owner: MLE, BI
- BL-044 Persona coherence review with marketing stakeholders (3 pts) - Owner: BI, PO
Sprint target: Phase III Batch III.2 and Phase IV Batch IV.1 complete.

### Sprint 6 (Phase IV)
Milestone: Churn model, registry lineage, and drift automation.
- BL-050 Train Snowpark Random Forest churn model (8 pts) - Owner: MLE
- BL-051 Implement holdout and calibration evaluation workflows (5 pts) - Owner: MLE, QAE
- BL-052 Register model versions and training lineage metadata (5 pts) - Owner: MLE
- BL-053 Configure drift monitors and >15% retrain trigger in Airflow (8 pts) - Owner: MLE, DE
- BL-054 Implement canary scoring and promotion checks (5 pts) - Owner: MLE, QAE
Sprint target: Phase IV Batches IV.2 and IV.3 complete.

### Sprint 7 (Phase V)
Milestone: Cortex persona narratives and Streamlit app for marketer workflows.
- BL-060 Implement prompt templates for grounded persona synthesis (5 pts) - Owner: MLE, BI
- BL-061 Integrate Cortex COMPLETE/SUMMARIZE workflows (8 pts) - Owner: MLE, AE
- BL-062 Implement prompt regression and factual anchor validations (5 pts) - Owner: QAE, MLE
- BL-063 Build Streamlit in Snowflake Persona Consultant app (8 pts) - Owner: BI, MLE
- BL-064 Add role-based access, telemetry, and UAT scripts (5 pts) - Owner: BI, DPE
Sprint target: Phase V complete with signed UAT.

### Sprint 8 (Phase VI)
Milestone: Production hardening, rollout, and BAU transition.
- BL-070 Execute resilience game-day drills for critical failure modes (8 pts) - Owner: DE, QAE
- BL-071 Validate rollback procedures across data, model, and app layers (5 pts) - Owner: DPE, MLE, AE
- BL-072 Execute progressive rollout and hypercare KPI tracking (8 pts) - Owner: BI, PO
- BL-073 Complete final acceptance package and handover to operations (5 pts) - Owner: PO, DPE
- BL-074 Post-implementation review and optimization backlog (3 pts) - Owner: PO, BI
Sprint target: Program Definition of Done achieved.

## Epic Structure
- EPIC-FOUNDATION: Phase 0 foundation and CI controls
- EPIC-INGESTION: Phase I ingestion and late-data reliability
- EPIC-NORMALIZATION: Phase II German-market standardization
- EPIC-SEMANTIC: Phase III SCD2 and feature core
- EPIC-ML: Phase IV Snowpark clustering/churn/drift
- EPIC-AI-APP: Phase V Cortex and SiS app
- EPIC-GOLIVE: Phase VI hardening and rollout

## Dependency Highlights
- EPIC-FOUNDATION must finish before downstream epic execution.
- EPIC-INGESTION and EPIC-NORMALIZATION can partially overlap after raw landing stability.
- EPIC-SEMANTIC completion is prerequisite for EPIC-ML model quality.
- EPIC-ML and EPIC-AI-APP overlap only after registry and drift controls are stable.
- EPIC-GOLIVE depends on all prior epics passing gates A-D.

## Milestone Exit Criteria by Sprint
- Sprint 1: environments and CI controls validated
- Sprint 2: ingestion baseline and reconciliation proven
- Sprint 3: late-arriving logic and locale text normalization validated
- Sprint 4: financial parsing and SCD2 reliability validated
- Sprint 5: semantic features and clustering release ready
- Sprint 6: churn model and drift automation production-ready
- Sprint 7: narrative quality and app UAT accepted
- Sprint 8: go-live, hypercare, and operational transfer completed

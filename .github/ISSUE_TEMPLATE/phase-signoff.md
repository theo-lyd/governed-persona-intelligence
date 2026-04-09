---
name: Phase Sign-Off
about: Structured sign-off request for roadmap phase completion and gate approval
title: "[Phase Sign-Off] Phase <ID> - <Name>"
labels: ["phase-signoff", "governance", "release"]
assignees: []
---

## Phase Summary
Phase ID: 
Phase Name: 
Phase Owner: 
Target Date: 
Release Version: 

## Scope Completed
- [ ] All planned batches for this phase are complete
- [ ] All execution chunks are complete
- [ ] Out-of-scope changes documented

List completed batches/chunks:

## Mandatory Quality Gates

### Gate A: Data Contract Compliance
- [ ] Schema conformance validated
- [ ] Freshness validated
- [ ] Volume validated
- [ ] Key completeness validated

Evidence links:

### Gate B: Business Rule Enforcement
- [ ] Session inactivity closure at 20 minutes enforced
- [ ] No orphan transactions in gold layer
- [ ] `RFM_Score` null rate <= 1%

Evidence links:

### Gate C: Model and AI Governance
- [ ] Reproducibility verified
- [ ] Registry lineage captured
- [ ] Drift monitors active
- [ ] Prompt safety controls active

Evidence links:

### Gate D: Release Readiness
- [ ] CI checks green
- [ ] Clone-based integration tests green
- [ ] Rollback verified
- [ ] Runbooks current

Evidence links:

## Validation Matrix Evidence
- [ ] Data evidence attached (dbt tests, GE suites, reconciliation queries)
- [ ] ML evidence attached (metrics, temporal validation, drift checks, registry metadata)
- [ ] AI evidence attached (prompt regressions, factual grounding checks, quality rubric)
- [ ] Ops evidence attached (Airflow runs, Monte Carlo alerts, drill reports)
- [ ] Security evidence attached (role/grant audit, secrets scan, access sign-off)

Artifact links:

## Completion Criteria for This Phase
- [ ] Phase-specific completion criteria met
- [ ] Risks and mitigations documented
- [ ] Dependencies for next phase satisfied

Completion notes:

## Risk Register Delta
- [ ] No new high-severity risk
- [ ] Any new risks have owner and due date

New/updated risks:

## Operational Readiness
- [ ] Monitoring dashboards updated
- [ ] Alerts tested
- [ ] On-call handoff complete

## Approvals
- [ ] Phase Owner approval
- [ ] Data Platform Lead approval
- [ ] Analytics Engineering Lead approval
- [ ] ML Lead approval
- [ ] Reliability/Governance approval

Approval comments:

## Post-Signoff Actions
- [ ] Release notes updated
- [ ] Next phase kickoff issue created
- [ ] Decision log updated
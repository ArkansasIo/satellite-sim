# Satellite-Sim Business Development Plan

Version: 1.0
Planning date: 2026-10-11

## Purpose

This document defines two human-team development scenarios for satellite-sim:

1. MVP / lean engineering program: 5–7 people.
2. Full commercial program: 12–20 people.

Both scenarios target the same architectural direction: a C++ spacecraft simulator, Voyager-style subsystem models, ground-station software, telemetry and command pipelines, onboard/ground data stores, authentication and security, Arduino/AVR prototypes, UI, media/frequency simulation, tests, documentation, and deployable tooling.

## Scenario A — Lean MVP

### Objective

Build a technically credible end-to-end prototype that proves the spacecraft-to-ground workflow before committing to a large commercial organization.

### Team

| Role | Count |
|---|---:|
| Technical lead / senior systems engineer | 1 |
| C++ / simulation engineer | 1–2 |
| Backend / database engineer | 1 |
| Frontend / UI engineer | 1 |
| Embedded / AVR engineer | 1 |
| QA / DevOps engineer | 0–1 |
| **Total** | **5–7** |

### Duration

Target: 9–15 months for a usable MVP, depending on how much existing infrastructure is reused.

### Estimated personnel budget

Planning range: **$1.5M–$2.2M per year** for a fully loaded team. A 12-month MVP should therefore be planned around **$1.5M–$2.2M personnel**, with additional hardware, cloud, legal, security review, and contingency budget.

### MVP deliverables

- C++20 simulator and deterministic mission clock.
- Generic CPU model and 8/18/32/64-bit simulation profiles.
- Voyager-inspired CCS/FDS/AACS functional abstractions.
- Spacecraft and fleet models.
- Ground-station command and telemetry pipeline.
- MySQL ground archive.
- Desktop/web mission-control UI.
- Basic authentication and RBAC.
- Onboard fixed-record data model.
- Arduino Uno R3 prototype.
- ATmega328P AVR assembly prototype.
- Command/telemetry protocol v1/v2 implementation boundary.
- Automated unit/integration tests.
- CI build and test pipeline.
- Basic deployment documentation.

### Explicit MVP exclusions

- Flight-qualified hardware.
- Real RF transmission.
- Real DSN integration.
- Safety-critical flight software certification.
- Full enterprise SSO.
- Large-scale cloud fleet operations.
- High-fidelity media/audio/video downlink.
- Complete historical reconstruction of proprietary NASA/JPL software.

## Scenario B — Full Commercial Program

### Objective

Build a commercially supportable simulation and mission-control platform with a complete embedded prototype, enterprise security, data/media systems, operational tooling, and production deployment.

### Team

| Role | Count |
|---|---:|
| Technical lead / chief architect | 1 |
| C++ / simulation engineers | 2 |
| Embedded / AVR engineers | 2 |
| Backend / database engineers | 2 |
| Frontend / UI engineers | 2 |
| Security engineer | 1 |
| DevOps / cloud engineer | 1 |
| QA / test automation engineers | 2 |
| Telemetry / data engineer | 1 |
| Aerospace / mission-systems specialist | 1 |
| Technical writer | 1 |
| Product / project manager | 1 |
| **Total** | **17** |

Planning range: 12–20 people depending on outsourcing, contractor use, and scope.

### Duration

Target: 18–24 months for a polished commercial v1.

### Personnel budget

Planning range: **$4.5M–$7.5M** over 18–24 months.

### Total program budget

Including personnel plus hardware, cloud infrastructure, security audits, legal/accounting, test equipment, insurance, commercial software, and contingency:

**Target planning envelope: $6M–$10M.**

## Recommended strategy

Start with Scenario A. Use the MVP to validate the architecture, product-market fit, protocol, simulator, and customer requirements. Expand toward Scenario B only after the core system demonstrates stable end-to-end operation.

The architecture should remain modular so that the MVP team can develop components that become the commercial platform rather than throwaway prototypes.

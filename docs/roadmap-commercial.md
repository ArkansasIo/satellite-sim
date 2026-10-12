# Commercial Development Roadmap

## Phase 0 — Architecture Validation
Duration: 1–2 months

Deliver:
- repository standards
- C++ build
- simulator interfaces
- protocol specification
- database baseline
- security model
- test strategy

Exit criteria:
- deterministic simulator test passes
- spacecraft and ground station exchange simulated telemetry/commands

## Phase 1 — MVP Core
Duration: 3–5 months

Deliver:
- CPU models
- spacecraft/fleet
- command pipeline
- telemetry pipeline
- ground database
- initial UI
- onboard data model
- Arduino prototype

Exit criteria:
- end-to-end mission simulation is repeatable
- telemetry survives archive/replay
- commands are validated and audited

## Phase 2 — Embedded and Operations
Duration: 3–5 months

Deliver:
- AVR assembly
- UART framing
- watchdog
- scheduler
- sequence engine
- EEPROM/fixed-record storage
- hardware-in-the-loop tests
- operator workflows

Exit criteria:
- embedded prototype interoperates with ground software
- fault injection produces deterministic results

## Phase 3 — Commercial Platform
Duration: 4–6 months

Deliver:
- enterprise authentication
- RBAC
- audit
- deployment automation
- data/media collection
- advanced telemetry
- mission dashboards
- operator tools
- backup/recovery

Exit criteria:
- production deployment procedure documented
- security review completed
- automated regression suite covers critical workflows

## Phase 4 — Release Hardening
Duration: 3–6 months

Deliver:
- performance testing
- penetration testing
- documentation
- customer installation package
- training materials
- support procedures
- licensing/third-party inventory
- release engineering

Exit criteria:
- reproducible release
- documented support boundaries
- commercial v1 candidate

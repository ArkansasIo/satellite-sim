# Development Budget Model

All figures are planning estimates in CAD and are not vendor quotes.

## Scenario A — MVP

| Category | Annual planning range |
|---|---:|
| Personnel | $1.50M–$2.20M |
| Hardware/test equipment | $50k–$150k |
| Cloud/hosting | $25k–$100k |
| Security/audit | $25k–$100k |
| Software/tooling | $25k–$75k |
| Legal/accounting/insurance | $25k–$100k |
| Contingency | $150k–$350k |
| **Approximate total** | **$1.8M–$3.1M/year** |

## Scenario B — Commercial

| Category | 18–24 month planning range |
|---|---:|
| Personnel | $4.50M–$7.50M |
| Hardware/test equipment | $200k–$750k |
| Cloud/hosting | $100k–$400k |
| Security/penetration testing | $100k–$300k |
| Software/tooling | $100k–$300k |
| Legal/IP/insurance | $100k–$400k |
| Documentation/training | $75k–$250k |
| Contingency | $500k–$1.50M |
| **Approximate total** | **$5.68M–$11.40M** |

The previously stated $6M–$10M commercial target is the preferred planning envelope; the table above shows the wider risk-adjusted range.

## Cost-control levers

- Keep the simulator open source under Apache-2.0.
- Use existing cloud services instead of building infrastructure prematurely.
- Start with Arduino/AVR rather than custom flight hardware.
- Reuse the deterministic simulator as the integration test environment.
- Contract specialist aerospace/security reviews instead of hiring every specialist immediately.
- Automate CI and hardware-in-the-loop testing early.

## Important distinction

These are program-level estimates, not a promise that the project will cost exactly these amounts. Actual costs should be recalculated from location, compensation, contractor rates, cloud usage, hardware procurement, insurance, and regulatory requirements.

# Satellite API (Design Contract)

Status: **specification only**. Unless an implementation is separately documented, these routes are proposed interface contracts and are not evidence of a running HTTP server.

Base path: `/api/v1`

| Method | Path | Purpose |
| --- | --- | --- |
| GET | `/satellites` | List simulated spacecraft |
| GET | `/satellites/{id}/telemetry` | Query recent telemetry |
| GET | `/satellites/{id}/gps` | Read simulated position state |
| GET | `/satellites/{id}/memory` | Read an explicitly permitted memory view |
| POST | `/satellites/{id}/commands` | Submit a validated simulation command |
| POST | `/satellites/{id}/updates/stage` | Stage a signed/validated simulation update |
| POST | `/satellites/{id}/updates/commit` | Commit a previously validated update |
| GET | `/fleet/telemetry` | Query fleet telemetry |

## Common requirements before implementation

- Validate all IDs, sizes, enum values, numeric ranges and request bodies.
- Require authentication and per-action authorization for operator operations.
- Apply rate limiting, audit logging, request IDs and safe error responses.
- Version request and response schemas and define retention behavior.
- Reject arbitrary memory writes and unsigned or incomplete updates by default.
- Make the simulation-only boundary explicit; never route these endpoints to actual spacecraft.

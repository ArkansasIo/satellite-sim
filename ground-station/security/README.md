# Ground Station Security

Security is divided into identity, authorization, transport, audit, secrets, and session controls.

Roles:
- ADMIN: user administration, security configuration, system administration.
- OPERATOR: telemetry, media, data collection, approved command operations.
- ANALYST: read-only telemetry, media and reports.
- VIEWER: read-only dashboards.

Rules:
- Passwords are never stored in plaintext; store a slow password hash such as Argon2id or bcrypt.
- Sessions use short-lived access tokens and revocable refresh/session records.
- Production transport requires TLS.
- Commands require authorization in addition to authentication.
- Administrative actions are audited.
- Secrets are supplied through environment/secret storage, never committed credentials.

The simulated spacecraft link uses device identity and message authentication separately from human login credentials.

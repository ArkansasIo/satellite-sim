# Authentication and Authorization API

POST /api/auth/register
POST /api/auth/login
POST /api/auth/logout
POST /api/auth/refresh
GET /api/auth/me

Admin:
GET /api/admin/users
POST /api/admin/users/:id/roles
PATCH /api/admin/users/:id/status
GET /api/admin/audit

Authorization:
- VIEWER: GET dashboards and permitted telemetry.
- ANALYST: VIEWER plus historical analysis/export.
- OPERATOR: ANALYST plus approved command workflows and media controls.
- ADMIN: all application administration.

Registration must be rate-limited and may be disabled for closed mission deployments. The first administrator should be provisioned through a secure deployment/bootstrap process rather than a public registration endpoint.

Passwords must be hashed with a modern password hashing function. Tokens and session identifiers must be random, revocable and short-lived.

CSRF protection is required for cookie-based browser sessions. TLS is required outside localhost/development.

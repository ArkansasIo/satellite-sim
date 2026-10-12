# Satellite Simulator Security Model

## Two identities

1. Human identity: ground-station user account.
2. Device identity: spacecraft/ground-device cryptographic identity.

They are intentionally separate.

## Authentication

Ground users authenticate to the application. The server creates a revocable session.

Spacecraft authenticate command frames using the configured device identity. A human password is never embedded in an uplink frame.

## Authorization

Ground authorization controls who may view, analyze, operate, or administer the application.

Spacecraft authorization controls which authenticated command classes the flight software accepts.

## Replay protection

Every command has a monotonically increasing sequence number. Previously executed sequence numbers are rejected.

## Audit

Ground administration, login/logout, command actions, and security failures are recorded. Spacecraft command authentication failures and security events are recorded onboard and can be downlinked.

## Security boundary

The simulator's security implementation is for a controlled simulation. It must not be treated as a production spacecraft security system without independent security engineering, key management, cryptographic review, and hardware validation.

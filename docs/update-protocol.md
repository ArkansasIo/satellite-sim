# Software Update Protocol

1. Ground station selects a spacecraft.
2. Operator selects an update package.
3. Package is transmitted through the simulated communications path.
4. Spacecraft stages the package.
5. Integrity/checksum validation runs.
6. Spacecraft reports staging status.
7. Ground station requests commit.
8. Spacecraft activates the update according to its profile.
9. Telemetry reports resulting version and health.

Legacy-style profiles use conservative staged patches. Modern profiles additionally model version metadata and rollback-oriented workflows.

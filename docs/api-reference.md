# API Reference

## Fleet

`GET /api/v1/satellites` returns the spacecraft registry.

`GET /api/v1/fleet/telemetry` returns aggregated normalized telemetry.

## Spacecraft

`GET /api/v1/satellites/{id}/telemetry` returns the latest telemetry for one spacecraft.

`GET /api/v1/satellites/{id}/gps` returns position/navigation data.

`GET /api/v1/satellites/{id}/memory` returns a memory inspection view.

`POST /api/v1/satellites/{id}/commands` submits a command to the spacecraft command queue.

`POST /api/v1/satellites/{id}/updates/stage` transfers an update package to the spacecraft staging area.

`POST /api/v1/satellites/{id}/updates/commit` requests update activation after validation.

## Operational rule

API command acceptance is not the same as spacecraft execution. The simulation may introduce radio delay, queueing, routing, packet loss, or spacecraft-side rejection. Telemetry should be used to confirm execution.

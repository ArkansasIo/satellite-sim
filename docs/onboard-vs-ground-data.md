# Onboard vs Ground Data

| Concern | Satellite | Ground |
|---|---|---|
| Current spacecraft state | authoritative onboard | cached/archived |
| Telemetry before downlink | onboard buffer | unavailable |
| Telemetry archive | retention-limited | MySQL archive |
| Command history | onboard execution record | operator/audit record |
| Mission sequences | onboard sequence store | planning/source copy |
| Faults/events | persistent onboard log | alarm/event archive |
| Configuration | onboard versioned config | ground configuration source |
| Excel export | optional snapshot | primary reporting/export |
| SQL engine | simulator may use SQLite | MySQL |

The separation permits a simulated link outage: the spacecraft continues recording data and later downlinks queued records.

# Voyager Ground-System Simulation Architecture

**Research date:** 2026-10-11  
**Purpose:** Design a source-grounded simulation of the Voyager ground segment, integrated with the separate Voyager spacecraft subsystem model.

## Executive summary

The ground system must be simulated as a distributed operational system, not a single command prompt. NASA describes the Deep Space Network (DSN) as supporting telemetry reception and processing, spacecraft command, and tracking measurements. NASA's historical Voyager operations material also documents ground-station command and telemetry processing and a mission control computer system. The simulation should separate these responsibilities into components with explicit interfaces and time-stamped data.

This is a functional reconstruction of publicly documented concepts. It is not a reproduction of the original JPL/DSN production software, network configuration, operator procedures, or undocumented command dictionaries.

## Source-grounded responsibilities

### 1. Mission control / flight operations
- Mission timeline and sequence planning.
- Command product preparation, validation, approval state, and release.
- Spacecraft state-of-health and science telemetry displays.
- Alarm/event review and operator log.
- Pass planning and coordination with station availability.
- Command history, telemetry archive, and replay.

NASA's AMMOS Mission Control System overview describes mission-control capabilities for commanding spacecraft, receiving/managing telemetry, and visualizing real-time and historical mission data. This is a useful modern functional reference, not evidence that Voyager used the same product. [1]

### 2. DSN station model
Each simulated station should contain:
- Station identity, site, antenna/dish identity, and operating state.
- Scheduled pass window and acquisition/lock state.
- Uplink command transmitter state.
- Downlink receiver state and signal-quality metrics.
- Station monitor telemetry, including antenna, receiver, transmitter, and equipment health.
- Data-forwarding link to mission control.

NASA identifies the DSN's three major functions as telemetry, spacecraft command, and tracking. The model should keep those services separate even when they share one simulated station object. [2]

### 3. Command processing and store-and-forward
Historical Voyager operations material describes station command processors with command-file storage, transmit-time assignment, error checks, handshaking, and status reporting. Implement a modern testable analogue:
1. Author command sequence.
2. Validate schema, target, sequence ordering, allowed command IDs, and time tags.
3. Create an immutable command product with ID, version, checksum, author, and approval state.
4. Schedule the product against a pass/contact window.
5. Queue commands at the station.
6. Transmit only when station and link state permit.
7. Record uplink start, completion, simulated propagation delay, spacecraft receipt, execution result, and acknowledgement/telemetry evidence.
8. Preserve the full audit trail.

Do not claim the simulator's queue sizes, exact historical packet formats, or error-check algorithms match Voyager unless verified against the relevant primary technical documentation. [3]

### 4. Telemetry processing
Use a staged pipeline:
1. Receive a simulated radio/downlink frame.
2. Track frame reception and link-quality metrics.
3. Validate frame boundaries and integrity checks when the frame format is sourced.
4. Decode into a raw telemetry record.
5. Associate source spacecraft, station, reception time, onboard time, sequence number, and data quality.
6. Convert raw fields using versioned telemetry dictionaries.
7. Store raw and engineering-unit representations separately.
8. Publish to live displays, alarms, and archive.
9. Permit deterministic playback from archived input.

NASA describes DSN telemetry as acquired, processed, decoded, and distributed by the network. [2] For modern interfaces, use the DSN interface handbook as a guide to service separation; do not assume the contemporary handbook describes historical Voyager formats. [4]

### 5. Tracking and navigation
Keep radio tracking distinct from a visual map:
- Simulated spacecraft ephemeris and light-time.
- Antenna pointing and acquisition windows.
- Range and Doppler observation placeholders with source metadata.
- State estimator/trajectory display, if implemented.
- Uncertainty and provenance indicators.

Do not present the project's demo latitude/longitude as actual Voyager navigation telemetry. Voyager is a deep-space mission; use a heliocentric or spacecraft-relative visualization for the historical profile. Earth-orbit GPS-style fields belong only in a generic modern satellite profile unless a real source justifies them.

## Proposed software components

| Component | Responsibility | Inputs | Outputs |
|---|---|---|---|
| Mission Control Console | Operator workflow, status, logs, alerts | Mission database, telemetry bus | Command requests, operator events |
| Sequence Planner | Build time-tagged command products | Mission timeline, command dictionary | Versioned command sequence |
| Command Validator | Check structure, ranges, target and preconditions | Command product, rules | Validation report |
| Command Product Store | Immutable command artifacts and audit | Approved products | Retrieval/version history |
| Pass Scheduler | Station contacts and resource conflicts | Ephemeris, station calendars | Pass plan |
| DSN Station | Acquisition, link state, transmit/receive | Pass plan, simulated channel | Uplink/downlink events |
| Uplink Processor | Queue and serialize command product | Validated command queue | Transmitted command events |
| Downlink Processor | Receive and decode frames | Link frames, frame dictionary | Raw telemetry records |
| Telemetry Dictionary | Versioned field mapping and conversions | Raw field values | Engineering-unit values |
| Telemetry Archive | Durable time-series and replay | Raw/decoded telemetry | Query/replay stream |
| Alarm/Event Engine | Thresholds, state transitions, latching | Telemetry and event stream | Alarms, acknowledgements |
| Tracking Service | Pointing, range/Doppler placeholders | Ephemeris, station state | Tracking observations |
| Operations Audit | Append-only operator/system actions | All command/control events | Traceable event history |
| Simulator Clock | Deterministic mission time | Scenario configuration | Time ticks and event ordering |

## Data contracts

Every command event should include:
- `event_id`, `mission_id`, `spacecraft_id`, `command_product_id`
- `command_id`, `arguments`, `sequence_number`
- `created_at_utc`, `scheduled_transmit_utc`, `transmitted_at_utc`
- `estimated_light_time_seconds`, `received_at_spacecraft_utc`
- `status`, `validation_results`, `source_operator`, `checksum`

Every telemetry record should include:
- `record_id`, `mission_id`, `spacecraft_id`, `subsystem`
- `station_id`, `received_at_utc`, `onboard_time_ticks`
- `packet_sequence`, `field_id`, `raw_value`, `engineering_value`, `units`
- `quality`, `dictionary_version`, `frame_integrity`, `provenance`

For simulation, UTC and mission-clock values must be distinct. Use a deterministic simulation clock so tests can reproduce command/telemetry ordering without sleeping in real time.

## Ground-station UI

### Main operator shell
- Mission and spacecraft selector.
- Contact/pass status and station availability.
- Link status, uplink/downlink direction, simulated light-time.
- Command queue with validation and approval status.
- Live telemetry table with raw/engineering toggle.
- Alarm panel with severity, time, source, and acknowledgement.
- Event timeline and searchable audit log.

### Voyager-era presentation mode
- Optional monochrome CRT palette (phosphor blue or green/amber).
- Fixed-width terminal panes, scanlines, restrained flicker and phosphor persistence.
- Dense text grids and status indicators.
- Visual treatment is aesthetic only; it must not change data semantics or imply that a modern interface is an authentic screenshot of historical JPL software.

### Modern operations mode
- Multi-panel dashboard, trend plots, pass timeline, telemetry filters, command-product review, and archive replay.
- Accessible contrast, keyboard navigation, non-color alarm cues, and adjustable density.
- No real command transmission: all controls act on the simulator unless explicitly connected to an authorized external system (out of scope).

## Suggested repository layout

```text
ground-station/voyager/
  README.md
  architecture.yaml
  commands/
    command-product.schema.json
    validation-rules.yaml
  telemetry/
    telemetry-record.schema.json
    dictionary.schema.json
  scheduling/
    pass-plan.schema.json
  scenarios/
    lost-contact.yaml
    delayed-command.yaml
    telemetry-replay.yaml
  ui/
    operator-console.md
    crt-mode.md
  docs/
    command-lifecycle.md
    telemetry-pipeline.md
    event-model.md
```

## Core scenarios to validate

1. **Delayed command:** issue a command during a valid pass; it reaches the simulated spacecraft only after the configured propagation delay.
2. **No contact:** command remains queued and no transmission is falsely recorded when the station is unavailable.
3. **Store-and-forward:** a multi-command product is scheduled, transmitted, and audited in sequence.
4. **Lost telemetry:** downlink gap raises a data-quality/contact event, not fabricated zero-valued telemetry.
5. **Bad frame:** invalid integrity check is quarantined and not silently converted into engineering data.
6. **Dictionary revision:** archived raw telemetry can be reprocessed with a new dictionary version while preserving the original decoded result.
7. **Station handover:** a contact can move between simulated stations without duplicating command execution or telemetry records.
8. **Clock determinism:** replaying the same scenario produces the same event ordering and timestamps.
9. **Operator audit:** every command state transition records actor, time, reason, and previous/new state.
10. **Onboard autonomy:** stored spacecraft sequences continue during a ground contact gap.

## Research sources

1. NASA/JPL AMMOS, Mission Control System overview: urlNASA AMMOS Mission Control Systemhttps://ammos.nasa.gov/mcs/
2. NASA, “What Does the DSN Do?”: urlNASA DSN functionshttps://www.nasa.gov/directorates/somd/space-communications-navigation-program/dsn-functions/
3. NASA NTRS, “Voyager Operations” (historical ground operations document): urlNASA Voyager Operations technical documenthttps://ntrs.nasa.gov/api/citations/19680009690/downloads/19680009690.pdf?attachment=true
4. JPL Deep Space Network, Mission Interface Design Handbook — Data Services: urlDSN Mission Interface Design Handbookhttps://deepspace.jpl.nasa.gov/dsndocs/810-007/data-services/
5. NASA, “Ground Data Systems and Mission Operations”: urlNASA ground data systems overviewhttps://www.nasa.gov/smallsat-institute/sst-soa/ground-data-systems-and-mission-operations/

## Fidelity statement

The architecture is grounded in public NASA/JPL descriptions. It is not an exact recreation of historical Voyager ground software, operator consoles, command dictionaries, or DSN hardware. Each future implementation should carry source references and clearly mark approximations.

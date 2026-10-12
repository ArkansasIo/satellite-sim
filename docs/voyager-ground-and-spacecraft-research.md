# Voyager Ground and Spacecraft Research Notes

**Reviewed:** 2026-10-11  
**Purpose:** Traceable research baseline for implementation. This is not a claim of complete historical reproduction.

## Findings supported by primary/agency sources

1. NASA identifies three onboard computer types, with two of each: CCS (18-bit), FDS (16-bit), and AACS (18-bit). NASA describes CCS command sequencing and fault response; FDS instrument/data handling and telemetry formatting; AACS attitude, antenna pointing, maneuvers, and scan-platform articulation. See [NASA Voyager FAQ](https://science.nasa.gov/mission/voyager/frequently-asked-questions/) and [NASA spacecraft overview](https://science.nasa.gov/mission/voyager/spacecraft/).
2. NASA describes DSN services as telemetry processing/distribution, spacecraft command, and tracking. Tracking uses range and Doppler observations to support navigation. See [NASA DSN functions](https://www.nasa.gov/directorates/somd/space-communications-navigation-program/dsn-functions/) and [NASA Chapter 18: DSN](https://science.nasa.gov/learn/basics-of-space-flight/chapter18-1/).
3. Historical technical documentation describes a Voyager-era ground command processor that read scheduled command sequences, transmitted commands to a deep-space station, and verified transmission. Later DSN command-system descriptions discuss time-tagged command files, error checks, handshaking, status reporting, and store-and-forward. See [NASA NTRS, Voyager Spacecraft System Final Technical Report](https://ntrs.nasa.gov/api/citations/19660011779/downloads/19660011779.pdf?attachment=true) and [JPL Publication 83-53](https://ntrs.nasa.gov/api/citations/19840003118/downloads/19840003118.pdf?attachment=true).
4. NASA's description of the DSN data flow distinguishes spacecraft telemetry (TLM), command data (CMD), and DSN monitor data (MON). The simulator should preserve this separation rather than blending station health into spacecraft telemetry. See [NASA Chapter 18: DSN](https://science.nasa.gov/learn/basics-of-space-flight/chapter18-1/).
5. NASA's published account of Voyager 1's FDS issue and software patch illustrates why command receipt, execution, and telemetry confirmation must be separate states. See [NASA Voyager 1 FDS issue](https://science.nasa.gov/blogs/voyager/2024/03/15/engineers-working-to-resolve-issue-with-voyager-1-computer/) and [NASA software patch account](https://www.nasa.gov/missions/voyager-program/nasas-voyager-team-focuses-on-software-patch-thrusters/).

## Engineering consequences

- Model CCS, FDS, and AACS as separate types with their own word widths and responsibilities.
- Represent redundancy explicitly, but do not assume a particular failover policy unless documented.
- Keep command product creation, station receipt, transmission, spacecraft receipt, execution, and telemetry evidence as distinct events.
- Model telemetry as raw data plus decoded engineering values and quality/provenance metadata.
- Model DSN monitor data separately from spacecraft telemetry.
- Include configurable propagation delay and contact windows.
- Use a deterministic clock for tests; do not sleep in wall-clock time.
- Treat modern DSN documents as functional references, not direct evidence of Voyager-era implementation details.

## Open research items

- Verify exact FDS instruction encodings, register semantics, memory-bank behavior, interrupt timing, DMA, and I/O from primary JPL documents.
- Verify Voyager-era command processor details against original technical reports and mission-specific interfaces.
- Source any frame formats, checksums, coding modes, or command dictionaries before implementing them as historically accurate.
- Record source revision/page for every instruction-level claim.

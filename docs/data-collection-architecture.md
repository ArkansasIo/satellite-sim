# Data Collection Architecture

The simulator collects data at the spacecraft, link, and ground-station layers.

## Collection classes

- Engineering telemetry: power, thermal, CPU, memory, subsystem health.
- Navigation/tracking: simulated position, velocity, range, Doppler and pointing state.
- Communications: frequency channel, bandwidth, signal level, SNR, packet quality.
- Events: boot, mode changes, command execution, warnings and faults.
- Media products: audio, image and video product metadata plus chunk transfer state.
- Command history: received, validated, executed, rejected and acknowledged commands.
- System metrics: collection rate, packet counts, dropped frames and storage utilization.

## Data path

Spacecraft sensors/simulators
-> onboard collectors
-> onboard database/buffers
-> simulated communications link
-> ground receiver
-> validation/decoding
-> MySQL archive
-> live UI, reports, CSV/Excel exports.

Every collected record should retain provenance: spacecraft ID, subsystem, onboard tick, ground receive time, sequence number, source channel and data quality.

Large audio/video/image payloads are stored as files or object references; MySQL stores metadata, checksums, timestamps and relationships.

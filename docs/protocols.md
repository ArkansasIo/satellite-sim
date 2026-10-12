# Command and Telemetry Protocol

The initial protocol is intentionally transport-neutral.

## Command

Fields:

- version
- spacecraft_id
- sequence
- timestamp
- command_id
- payload_length
- payload
- checksum

## Telemetry

Fields:

- version
- spacecraft_id
- sequence
- spacecraft_time
- channel_id
- value_type
- value
- quality
- checksum

## Link model

The radio link exposes:

- one-way light-time delay
- uplink/downlink availability
- packet loss
- bit/packet corruption
- bandwidth
- antenna lock/state
- link budget abstraction

All timing is simulated; no real spacecraft network is contacted.

# Satellite ↔ Ground Data Synchronization

The satellite and ground station have separate stores.

## Uplink

1. Ground creates an approved command/product.
2. The device adapter transmits the command frame.
3. Satellite validates sequence and command ID.
4. Satellite records the command in command history.
5. Satellite executes it.
6. Satellite records result/event/fault state.
7. An acknowledgement is placed in the synchronization queue.

## Downlink

1. Telemetry is written to the onboard telemetry buffer.
2. The scheduler selects pending records.
3. The telemetry encoder creates a protocol frame.
4. Ground receives and validates the frame.
5. Ground persists the decoded record in MySQL.
6. Ground acknowledgement is returned.
7. Satellite marks the corresponding sync item transmitted/acknowledged.

A communication outage does not erase onboard records. Pending records remain queued until the configured retention policy requires reclamation.

## Ownership

- Satellite is authoritative for onboard state and records before successful downlink.
- Ground is authoritative archive for records successfully received and committed.
- Neither side directly edits the other database.

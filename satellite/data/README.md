# Onboard Satellite Data System

The spacecraft has its own simulated onboard data store, separate from the ground-station MySQL database.

Satellite onboard store -> buffers mission data, persists configuration, records commands/events/faults, and queues synchronization packets.
Ground MySQL -> receives downlinked records, archives mission history, and provides operator queries and Excel exports.

This is a simulation of an embedded spacecraft data-management layer. It does not imply that historical Voyager spacecraft used MySQL.

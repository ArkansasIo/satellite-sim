# Ground Station Data Platform

This subsystem stores satellite telemetry, commands, events, spacecraft state, and ground-station sessions.

Architecture:

Laptop client -> Ground Station API -> MySQL -> telemetry archive
                       ^
Arduino ground station / serial bridge -> ingestion endpoint

The database schema is also designed for Excel-compatible CSV exports. Excel is a data interchange/reporting format, not the transactional database.

The schema is project-defined and does not claim compatibility with NASA/JPL operational systems.

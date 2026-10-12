# Embedded SQL Backend

The logical onboard schema is SQL-shaped so the desktop simulator can use SQLite during development.

The ATmega328P does not run a full SQL server. The AVR/Arduino implementation maps the same logical records to fixed-size binary structures, EEPROM configuration records, and circular telemetry buffers.

This keeps one data model across desktop simulation and embedded prototype.

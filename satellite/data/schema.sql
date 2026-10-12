-- Logical onboard database schema.
-- Desktop simulator may use SQLite; AVR maps these records to fixed-size storage.
PRAGMA foreign_keys = ON;

CREATE TABLE spacecraft_metadata (
 spacecraft_key TEXT PRIMARY KEY,
 model TEXT NOT NULL,
 firmware_version TEXT NOT NULL,
 protocol_version INTEGER NOT NULL,
 cpu_width_bits INTEGER NOT NULL,
 boot_count INTEGER NOT NULL DEFAULT 0,
 created_tick INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE onboard_config (
 config_key TEXT PRIMARY KEY,
 config_value TEXT NOT NULL,
 value_type TEXT NOT NULL,
 version INTEGER NOT NULL DEFAULT 1,
 checksum INTEGER,
 updated_tick INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE telemetry_buffer (
 telemetry_id INTEGER PRIMARY KEY AUTOINCREMENT,
 sequence_no INTEGER NOT NULL,
 subsystem_id TEXT NOT NULL,
 metric_name TEXT NOT NULL,
 raw_value INTEGER,
 engineering_value REAL,
 unit TEXT,
 quality TEXT NOT NULL DEFAULT 'VALID',
 onboard_tick INTEGER NOT NULL,
 downlink_state TEXT NOT NULL DEFAULT 'PENDING',
 created_tick INTEGER NOT NULL
);

CREATE INDEX ix_telemetry_pending ON telemetry_buffer(downlink_state, sequence_no);
CREATE INDEX ix_telemetry_metric ON telemetry_buffer(subsystem_id, metric_name, onboard_tick);

CREATE TABLE command_history (
 command_record_id INTEGER PRIMARY KEY AUTOINCREMENT,
 sequence_no INTEGER NOT NULL UNIQUE,
 command_id INTEGER NOT NULL,
 payload_hex TEXT,
 state TEXT NOT NULL,
 received_tick INTEGER NOT NULL,
 executed_tick INTEGER,
 result_code INTEGER,
 result_text TEXT
);

CREATE TABLE sequence_store (
 sequence_id TEXT PRIMARY KEY,
 version INTEGER NOT NULL,
 state TEXT NOT NULL DEFAULT 'STOPPED',
 start_tick INTEGER,
 next_step INTEGER NOT NULL DEFAULT 0,
 definition TEXT NOT NULL,
 checksum INTEGER NOT NULL
);

CREATE TABLE event_log (
 event_id INTEGER PRIMARY KEY AUTOINCREMENT,
 event_tick INTEGER NOT NULL,
 severity TEXT NOT NULL,
 event_type TEXT NOT NULL,
 source TEXT NOT NULL,
 message TEXT NOT NULL,
 acknowledged INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE fault_log (
 fault_id INTEGER PRIMARY KEY AUTOINCREMENT,
 fault_code INTEGER NOT NULL,
 first_tick INTEGER NOT NULL,
 last_tick INTEGER NOT NULL,
 active INTEGER NOT NULL DEFAULT 1,
 count INTEGER NOT NULL DEFAULT 1,
 source TEXT NOT NULL,
 details TEXT
);

CREATE TABLE storage_regions (
 region_id TEXT PRIMARY KEY,
 medium TEXT NOT NULL,
 capacity_bytes INTEGER NOT NULL,
 used_bytes INTEGER NOT NULL DEFAULT 0,
 wear_count INTEGER NOT NULL DEFAULT 0,
 checksum INTEGER
);

CREATE TABLE sync_queue (
 sync_id INTEGER PRIMARY KEY AUTOINCREMENT,
 direction TEXT NOT NULL,
 record_type TEXT NOT NULL,
 record_id INTEGER,
 sequence_no INTEGER,
 state TEXT NOT NULL DEFAULT 'PENDING',
 retry_count INTEGER NOT NULL DEFAULT 0,
 created_tick INTEGER NOT NULL,
 transmitted_tick INTEGER
);

INSERT INTO spacecraft_metadata
(spacecraft_key, model, firmware_version, protocol_version, cpu_width_bits)
VALUES ('SAT-001','SIM-SPACECRAFT','0.4.0',2,8);

INSERT INTO storage_regions(region_id,medium,capacity_bytes) VALUES
 ('BOOT','FLASH',32768),
 ('CONFIG','EEPROM',1024),
 ('TELEMETRY','FLASH',65536),
 ('EVENTS','FLASH',16384),
 ('SEQUENCES','FLASH',16384);

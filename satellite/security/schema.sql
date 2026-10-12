CREATE TABLE IF NOT EXISTS device_identity (
 identity_id INTEGER PRIMARY KEY,
 spacecraft_key TEXT NOT NULL UNIQUE,
 key_id TEXT NOT NULL UNIQUE,
 algorithm TEXT NOT NULL,
 key_version INTEGER NOT NULL,
 enabled INTEGER NOT NULL DEFAULT 1,
 created_tick INTEGER NOT NULL,
 rotated_tick INTEGER
);

CREATE TABLE IF NOT EXISTS command_security (
 sequence_no INTEGER PRIMARY KEY,
 command_id INTEGER NOT NULL,
 auth_status TEXT NOT NULL,
 replay_status TEXT NOT NULL,
 received_tick INTEGER NOT NULL,
 executed_tick INTEGER,
 failure_code INTEGER
);

CREATE TABLE IF NOT EXISTS security_events (
 event_id INTEGER PRIMARY KEY AUTOINCREMENT,
 event_tick INTEGER NOT NULL,
 event_type TEXT NOT NULL,
 severity TEXT NOT NULL,
 message TEXT NOT NULL,
 sequence_no INTEGER
);

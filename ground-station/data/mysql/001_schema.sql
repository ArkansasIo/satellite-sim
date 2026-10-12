CREATE DATABASE IF NOT EXISTS satellite_ground CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE satellite_ground;

CREATE TABLE spacecraft (
 spacecraft_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 spacecraft_key VARCHAR(64) NOT NULL UNIQUE,
 name VARCHAR(128) NOT NULL,
 profile VARCHAR(32) NOT NULL DEFAULT 'modern',
 cpu_width_bits SMALLINT UNSIGNED NOT NULL DEFAULT 8,
 firmware_version VARCHAR(64),
 active BOOLEAN NOT NULL DEFAULT TRUE,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ground_stations (
 ground_station_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 station_key VARCHAR(64) NOT NULL UNIQUE,
 name VARCHAR(128) NOT NULL,
 location_name VARCHAR(128),
 latitude_deg DECIMAL(10,7),
 longitude_deg DECIMAL(10,7),
 enabled BOOLEAN NOT NULL DEFAULT TRUE,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE telemetry_packets (
 telemetry_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 spacecraft_id BIGINT UNSIGNED NOT NULL,
 ground_station_id BIGINT UNSIGNED,
 sequence_no BIGINT UNSIGNED NOT NULL,
 packet_type VARCHAR(64) NOT NULL,
 received_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 spacecraft_time_ms BIGINT UNSIGNED,
 signal_dbm DECIMAL(8,2),
 packet_loss BOOLEAN NOT NULL DEFAULT FALSE,
 raw_payload TEXT,
 UNIQUE KEY uq_telemetry_sequence (spacecraft_id, sequence_no),
 KEY ix_telemetry_received (received_at),
 FOREIGN KEY (spacecraft_id) REFERENCES spacecraft(spacecraft_id),
 FOREIGN KEY (ground_station_id) REFERENCES ground_stations(ground_station_id)
);

CREATE TABLE telemetry_values (
 telemetry_value_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 telemetry_id BIGINT UNSIGNED NOT NULL,
 metric_name VARCHAR(128) NOT NULL,
 metric_value DECIMAL(24,8),
 metric_text VARCHAR(512),
 unit VARCHAR(32),
 status VARCHAR(32) NOT NULL DEFAULT 'OK',
 FOREIGN KEY (telemetry_id) REFERENCES telemetry_packets(telemetry_id),
 KEY ix_metric_name (metric_name)
);

CREATE TABLE commands (
 command_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 spacecraft_id BIGINT UNSIGNED NOT NULL,
 ground_station_id BIGINT UNSIGNED,
 sequence_no BIGINT UNSIGNED NOT NULL,
 command_name VARCHAR(64) NOT NULL,
 command_payload TEXT,
 requested_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 sent_at TIMESTAMP(6),
 acknowledged_at TIMESTAMP(6),
 status VARCHAR(32) NOT NULL DEFAULT 'QUEUED',
 error_text VARCHAR(1024),
 UNIQUE KEY uq_command_sequence (spacecraft_id, sequence_no),
 FOREIGN KEY (spacecraft_id) REFERENCES spacecraft(spacecraft_id),
 FOREIGN KEY (ground_station_id) REFERENCES ground_stations(ground_station_id)
);

CREATE TABLE spacecraft_state (
 state_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 spacecraft_id BIGINT UNSIGNED NOT NULL,
 recorded_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 power_percent DECIMAL(6,2),
 uptime_seconds BIGINT UNSIGNED,
 cpu_load_percent DECIMAL(6,2),
 memory_used_bytes BIGINT UNSIGNED,
 memory_total_bytes BIGINT UNSIGNED,
 latitude_deg DECIMAL(12,8),
 longitude_deg DECIMAL(12,8),
 altitude_m DECIMAL(16,3),
 health_status VARCHAR(32) NOT NULL DEFAULT 'UNKNOWN',
 FOREIGN KEY (spacecraft_id) REFERENCES spacecraft(spacecraft_id),
 KEY ix_state_time (spacecraft_id, recorded_at)
);

CREATE TABLE ground_events (
 event_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 spacecraft_id BIGINT UNSIGNED,
 ground_station_id BIGINT UNSIGNED,
 event_time TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 severity VARCHAR(16) NOT NULL DEFAULT 'INFO',
 event_type VARCHAR(64) NOT NULL,
 message TEXT NOT NULL,
 FOREIGN KEY (spacecraft_id) REFERENCES spacecraft(spacecraft_id),
 FOREIGN KEY (ground_station_id) REFERENCES ground_stations(ground_station_id),
 KEY ix_events_time (event_time)
);

CREATE TABLE data_exports (
 export_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 export_type VARCHAR(32) NOT NULL,
 requested_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 completed_at TIMESTAMP(6),
 file_name VARCHAR(255),
 row_count BIGINT UNSIGNED,
 status VARCHAR(32) NOT NULL DEFAULT 'REQUESTED'
);

INSERT INTO spacecraft (spacecraft_key,name,profile,cpu_width_bits) VALUES ('SAT-001','Simulation Satellite 001','modern',8)
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO ground_stations (station_key,name,location_name) VALUES ('GS-001','Ground Station 001','Simulation Lab')
ON DUPLICATE KEY UPDATE name=VALUES(name);

USE satellite_ground;

CREATE TABLE collection_sources (
 source_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 spacecraft_id BIGINT UNSIGNED NOT NULL,
 subsystem_id VARCHAR(64) NOT NULL,
 source_type VARCHAR(32) NOT NULL,
 sampling_period_ms BIGINT UNSIGNED,
 enabled BOOLEAN NOT NULL DEFAULT TRUE,
 created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 FOREIGN KEY (spacecraft_id) REFERENCES spacecraft(spacecraft_id)
);

CREATE TABLE collection_samples (
 sample_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 source_id BIGINT UNSIGNED NOT NULL,
 onboard_tick BIGINT UNSIGNED NOT NULL,
 received_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 sequence_no BIGINT UNSIGNED,
 metric_name VARCHAR(128) NOT NULL,
 raw_value BIGINT,
 engineering_value DECIMAL(24,8),
 unit VARCHAR(32),
 quality VARCHAR(32) NOT NULL DEFAULT 'VALID',
 source_channel VARCHAR(64),
 FOREIGN KEY (source_id) REFERENCES collection_sources(source_id),
 KEY ix_collection_time (source_id, received_at),
 KEY ix_collection_metric (metric_name, received_at)
);

CREATE TABLE collection_batches (
 batch_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 spacecraft_id BIGINT UNSIGNED NOT NULL,
 started_at TIMESTAMP(6) NOT NULL,
 completed_at TIMESTAMP(6),
 sample_count BIGINT UNSIGNED NOT NULL DEFAULT 0,
 packet_count BIGINT UNSIGNED NOT NULL DEFAULT 0,
 dropped_count BIGINT UNSIGNED NOT NULL DEFAULT 0,
 status VARCHAR(32) NOT NULL DEFAULT 'OPEN',
 FOREIGN KEY (spacecraft_id) REFERENCES spacecraft(spacecraft_id)
);

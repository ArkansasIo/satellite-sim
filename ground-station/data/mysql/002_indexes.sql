USE satellite_ground;
CREATE INDEX ix_telemetry_spacecraft_type_time ON telemetry_packets(spacecraft_id, packet_type, received_at);
CREATE INDEX ix_values_telemetry_metric ON telemetry_values(telemetry_id, metric_name);
CREATE INDEX ix_commands_status_time ON commands(status, requested_at);
CREATE INDEX ix_state_health_time ON spacecraft_state(health_status, recorded_at);
CREATE INDEX ix_events_spacecraft_severity ON ground_events(spacecraft_id, severity, event_time);

USE satellite_ground;
CREATE OR REPLACE VIEW v_latest_spacecraft_state AS
SELECT s.* FROM spacecraft_state s
JOIN (SELECT spacecraft_id, MAX(state_id) state_id FROM spacecraft_state GROUP BY spacecraft_id) x
ON x.state_id=s.state_id;

CREATE OR REPLACE VIEW v_recent_telemetry AS
SELECT t.telemetry_id,s.spacecraft_key,s.name AS spacecraft_name,g.station_key,
t.sequence_no,t.packet_type,t.received_at,t.spacecraft_time_ms,t.signal_dbm,t.raw_payload
FROM telemetry_packets t
JOIN spacecraft s ON s.spacecraft_id=t.spacecraft_id
LEFT JOIN ground_stations g ON g.ground_station_id=t.ground_station_id;

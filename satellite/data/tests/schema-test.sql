SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;
SELECT COUNT(*) AS telemetry_pending FROM telemetry_buffer WHERE downlink_state='PENDING';
SELECT spacecraft_key, firmware_version, protocol_version FROM spacecraft_metadata;

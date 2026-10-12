INSERT INTO onboard_config(config_key,config_value,value_type,version) VALUES
 ('telemetry.period_ms','1000','integer',1),
 ('telemetry.downlink_batch','16','integer',1),
 ('power.minimum_percent','10','integer',1),
 ('watchdog.timeout_ms','2000','integer',1),
 ('mission.mode','SIMULATION','string',1);

INSERT INTO sequence_store
(sequence_id,version,state,start_tick,next_step,definition,checksum)
VALUES
 ('BOOT-HEALTH',1,'STOPPED',NULL,0,'POWER->HEALTH->TELEMETRY->WATCHDOG',0);

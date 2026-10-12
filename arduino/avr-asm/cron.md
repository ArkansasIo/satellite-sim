# Embedded Cron-Style Jobs

The AVR satellite uses a deterministic periodic-job concept inspired by cron.

It is **not** a Unix cron daemon. Jobs run from the simulator's onboard scheduler/mission clock.

## Planned jobs

| Job | Purpose | Priority |
|---|---|---|
| WATCHDOG_SERVICE | Service watchdog and detect missed scheduler execution | Highest |
| HEALTH_SAMPLE | Collect software health/fault state | High |
| TELEMETRY_STATUS | Emit periodic housekeeping telemetry | Medium |
| SEQUENCE_STEP | Advance time-tagged onboard sequence | Medium |
| MEMORY_CHECK | Optional memory integrity check | Low |
| LOG_FLUSH | Flush diagnostic events when capacity permits | Low |

## Determinism

A job is due because the mission clock reaches its scheduled tick, not because the host computer happens to execute a wall-clock callback.

That permits:
- accelerated simulation;
- pause/resume;
- deterministic replay;
- unit testing;
- fault injection;
- historical mission-time scenarios.

## Real-time mapping

A later PC ground-station runtime may expose equivalent jobs through a conventional scheduler or cron-like service, but the onboard AVR implementation remains tick-driven.

## Safety

No cron job should directly perform an uncontrolled actuator action. Jobs generate bounded software events that pass through command validation and subsystem state machines.

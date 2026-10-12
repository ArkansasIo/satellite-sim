# Telemetry Pipeline

## Processing stages

`simulated downlink → frame receiver → integrity check → raw archive → decoder → versioned field dictionary → engineering conversion → alarm/event engine → operator display and archive query`

Keep raw bytes/words immutable. Engineering values are derived products with a dictionary version and conversion provenance.

## Data quality states

Use explicit states such as `valid`, `suspect`, `invalid`, `missing`, `stale`, and `not-yet-decoded`. A contact gap creates missing/stale data states; it must never manufacture zero-valued readings.

## Timing

Each record distinguishes:
- spacecraft onboard time or ticks;
- simulated reception time at the station;
- mission-control ingest time;
- optional decoded/event time.

The simulator clock must be deterministic. If the exact historical onboard time conversion is not implemented from a source, retain raw ticks and label the conversion as approximate.

## Reprocessing

Allow archived raw telemetry to be decoded again using a new dictionary version. Preserve both the original decode and the new decode, including dictionary versions and provenance.

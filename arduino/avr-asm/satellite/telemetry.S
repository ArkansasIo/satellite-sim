; SAT-ASM telemetry scheduler/encoder boundary.
.include "common/atmega328p.inc"
.include "common/protocol.inc"

.section .text
.global telemetry_emit_status

telemetry_emit_status:
    ; r22 = simulated power.
    ; Frame serializer and CRC are separate so the encoder can be tested.
    ret

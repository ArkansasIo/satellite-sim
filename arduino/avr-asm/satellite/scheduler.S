; SAT-ASM cooperative scheduler.
; The scheduler is deliberately deterministic and non-blocking.
.include "common/atmega328p.inc"

.section .data
scheduler_tick:
    .byte 0

.section .text
.global scheduler_step

scheduler_step:
    lds r24, scheduler_tick
    inc r24
    sts scheduler_tick, r24
    ret

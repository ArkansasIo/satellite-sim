; SAT-ASM deterministic cron-style job scheduler.
; "Cron" here means periodic onboard jobs, not a Unix daemon.
; r24/r25 hold the current 16-bit mission tick.
.include "common/atmega328p.inc"

.section .data
cron_tick_lo: .byte 0
cron_tick_hi: .byte 0
cron_telemetry_due: .byte 0
cron_health_due: .byte 0
cron_watchdog_due: .byte 0

.section .text
.global cron_tick
.global cron_run_due

cron_tick:
    lds r24, cron_tick_lo
    lds r25, cron_tick_hi
    adiw r24, 1
    sts cron_tick_lo, r24
    sts cron_tick_hi, r25

    ; Demo periods are expressed in scheduler ticks.
    ; Actual periods must be derived from the configured mission clock.
    andi r24, 0x0F
    brne cron_no_telemetry
    ldi r24, 1
    sts cron_telemetry_due, r24
cron_no_telemetry:

    andi r24, 0x3F
    brne cron_no_health
    ldi r24, 1
    sts cron_health_due, r24
cron_no_health:

    andi r24, 0x7F
    brne cron_no_watchdog
    ldi r24, 1
    sts cron_watchdog_due, r24
cron_no_watchdog:
    ret

cron_run_due:
    ; Dispatch flags. Actual calls are linked from the satellite image.
    lds r24, cron_telemetry_due
    tst r24
    breq cron_health
    clr r24
    sts cron_telemetry_due, r24

cron_health:
    lds r24, cron_health_due
    tst r24
    breq cron_watchdog
    clr r24
    sts cron_health_due, r24

cron_watchdog:
    lds r24, cron_watchdog_due
    tst r24
    breq cron_done
    clr r24
    sts cron_watchdog_due, r24

cron_done:
    ret

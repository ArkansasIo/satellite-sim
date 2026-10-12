; SAT-ASM watchdog support.
; Hardware watchdog integration belongs here. Keep reset behavior explicit.
.include "common/atmega328p.inc"

.section .text
.global watchdog_service

watchdog_service:
    ; Placeholder service boundary. The next implementation should use
    ; the ATmega328P WDT register definitions and a bounded recovery policy.
    ret

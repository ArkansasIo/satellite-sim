; satellite-sim SAT-ASM firmware.
; ATmega328P / 16 MHz / Arduino Uno R3.
; Project-defined embedded simulation firmware, not Voyager flight software.
.include "common/atmega328p.inc"
.include "common/protocol.inc"

.section .data
simulated_power:
    .byte DEFAULT_POWER

.section .text
.global main

main:
    ldi r16, high(RAMEND)
    out 0x3e, r16
    ldi r16, low(RAMEND)
    out 0x3d, r16
    rcall uart_init

satellite_loop:
    rcall scheduler_step
    rcall cron_tick
    rcall cron_run_due
    rcall sequence_step
    rcall watchdog_service
    rcall poll_command
    rjmp satellite_loop

uart_init:
    ldi r16, high(103)
    sts UBRR0H, r16
    ldi r16, low(103)
    sts UBRR0L, r16
    ldi r16, (1<<RXEN0)|(1<<TXEN0)
    sts UCSR0B, r16
    ldi r16, (1<<UCSZ01)|(1<<UCSZ00)
    sts UCSR0C, r16
    ret

poll_command:
    ; Non-blocking parser boundary. The command parser module owns decoding.
    ret

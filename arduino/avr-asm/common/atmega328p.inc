; ATmega328P register constants used by the prototype.
; Values correspond to the device I/O register map.
.equ UDR0,   0xC6
.equ UCSR0A, 0xC0
.equ UCSR0B, 0xC1
.equ UCSR0C, 0xC2
.equ UBRR0L, 0xC4
.equ UBRR0H, 0xC5

.equ RXC0, 7
.equ TXC0, 6
.equ UDRE0, 5
.equ RXEN0, 4
.equ TXEN0, 3
.equ UCSZ01, 2
.equ UCSZ00, 1

.equ DDRB, 0x04
.equ PORTB, 0x05
.equ DDB5, 5

.equ RAMEND, 0x08FF

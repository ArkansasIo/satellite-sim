; Project-defined bench protocol.
; ASCII commands are line-oriented:
; CMD,<sequence>,PING
; CMD,<sequence>,STATUS
; CMD,<sequence>,POWER,<0..100>
;
; Responses:
; TLM,<sequence>,PONG
; TLM,<sequence>,STATUS,<power>,<uptime>
; TLM,<sequence>,POWER,<power>
; ERR,<sequence>,<reason>
;
; This is NOT historical Voyager or DSN framing.

.equ CMD_BUFFER_SIZE, 64
.equ DEFAULT_POWER, 100

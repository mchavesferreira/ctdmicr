;
; aula_serial.asm
;
; Created: 12/11/2026 07:57:44
; Author : mchavesferreira
;

     rjmp  Start

;====================================================================
; CODE SEGMENT
;====================================================================
.include "lib328Pv02.inc"
Start:
      ; Write your code here
	rcall  usart_init ; configura a comunicação serial em 36¨00 bps
	ldi transmit_caracter,'I'	; carrega o caracter
	rcall usart_transmit	; chama a rotina para transmitir o caracter com a USART	
	ldi transmit_caracter,'F'
	rcall usart_transmit
	ldi transmit_caracter,'S'
	rcall usart_transmit
	ldi transmit_caracter,'P'
	rcall usart_transmit
	ldi delay_time,2
    rcall delay_seconds

    rjmp Start

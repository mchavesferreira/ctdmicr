


Seguindo tutorial disponivel no vídeo:  https://www.youtube.com/watch?v=BM-w1pcekxA&t=610s


Acesse o repositorio https://gitlab.com/jjchico-edc/avr-pio-template


Clone ou baixe o .zip deste repositorio em seu computador

modifique o platformio.ino para

 ```ruby
[env:uno]
platform = atmelavr
board = uno
;framework = arduino
; Use the simulator for debugging
debug_tool = simavr
; Use this file for peripheral definitions, that will be shown by the debugger.
debug_svd_path = atmega328p.svd

 ```


 copie o arquivo para atmega328p.svd para  pasta onde esta seu projeto

 muda o nome do arquivo /src/main.c para main.S

 ```ruby

; Blinking LED demo
; Jorge Juan-Chico. May, 2021
;
; Blink: blinking LED demo for ATmega328p Arduino boards.

#include <avr/io.h>


; LED bit in PORTB
.equ LED, PB5   ; Arduino Uno (atmega328p)
;.equ LED, PB7   ; Arduino Mega 2560 (atmega2560)

.text

;
; Main program
;
.global main
main:

    ; Initialization code
    ; cycle counter: r22:r21:r20 (24 bits)

.ORG 0x000
    LDI R16,0b11111111		//carrega R16 com o valor 0xFF
    OUT DDRB,R16

    ; Main loop
loop:
    sbi _SFR_IO_ADDR(PORTB),LED     ; LED on
    call ATRASO                     ; wait
    cbi _SFR_IO_ADDR(PORTB),LED     ; LED off
    call ATRASO                    ; wait
    rjmp loop                       ; repeat

ATRASO:
   LDI R19,80	
volta:		
   DEC  R17			//decrementa R17, comeÁa com 0x00
   BRNE volta 			//enquanto R17 > 0 fica decrementando R17
   DEC  R18			//decrementa R18, comeÁa com 0x00
   BRNE volta			//enquanto R18 > 0 volta decrementar R18
   DEC  R19			//decrementa R19
   BRNE volta
 ret
 
 ```
 

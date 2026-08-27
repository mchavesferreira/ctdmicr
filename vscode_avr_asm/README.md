


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


 Forma rápida,
 
 Baixe o pacote e abra o platformio
 
 platformio_exemplo_pisca_asm.zip

 ```ruby
; Blink: blinking LED demo for ATmega328p Arduino boards.

#include <avr/io.h>

; LED bit in PORTB
.equ LED, PB5   ; Arduino Uno (atmega328p)

.text

;
; Main program
;
.global main
main:
    LDI R16,0b11111111		//carrega R16 com o valor 0xFF
    OUT _SFR_IO_ADDR(DDRB),R16

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

 ```ruby


.global main
main:

    cbi _SFR_IO_ADDR(DDRD), PD7
    sbi _SFR_IO_ADDR(PORTD), PD7
    sbi _SFR_IO_ADDR(PORTB), PB5
  
   ; LDI R16,0b11111111		//carrega R16 com o valor 0xFF
    ;OUT DDRB,R16

    ; Main loop
loop:
    sbis _SFR_IO_ADDR(PORTD),PD7    ; LED on
    rjmp is_zero
    sbi _SFR_IO_ADDR(PORTB), PB5     ; LED on
    rjmp continue
is_zero:
    cbi _SFR_IO_ADDR(PORTB),PB5     ; LED on
continue:
    rjmp loop

 ```    
 

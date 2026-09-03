;====================================================================
; main.S
;
; Programa adaptado para:
;   ATmega328P
;   PlatformIO
;   GNU AVR Assembler
;
; Programa original desenvolvido para AVRASM / Proteus
;====================================================================


;====================================================================
; INCLUDES
;====================================================================

#include <avr/io.h>
#include "lib328P_platformio.inc"


;====================================================================
; DEFINITIONS
;====================================================================

#define M1   PB5        ; PB5 = Arduino UNO pino 13
#define SP1  PB0        ; PB0 = Arduino UNO pino 8


;====================================================================
; VARIABLES - aliases de registradores
;====================================================================

#define caixas r0


;====================================================================
; CODE SEGMENT
;====================================================================

.section .text

.global main


;====================================================================
; MAIN
;====================================================================

main:

Start:

    ;---------------------------------------------------------------
    ; SP1 - PB0 como entrada com pull-up
    ;---------------------------------------------------------------

    cbi _SFR_IO_ADDR(DDRB), SP1
    sbi _SFR_IO_ADDR(PORTB), SP1


    ;---------------------------------------------------------------
    ; M1 - PB5 como saída
    ;---------------------------------------------------------------

    sbi _SFR_IO_ADDR(DDRB), M1


    ;---------------------------------------------------------------
    ; Inicialização do LCD
    ;
    ; VSS = GND
    ; VDD = 5V
    ; VO  = GND
    ;
    ; RS = PD2
    ; RW = GND
    ; E  = PD3
    ;
    ; D4 = PD4
    ; D5 = PD5
    ; D6 = PD6
    ; D7 = PD7
    ;
    ; A = 5V
    ; K = GND
    ;---------------------------------------------------------------

    rcall lcd_init

    ; Limpa LCD
    rcall lcd_clear


    ;---------------------------------------------------------------
    ; Linha 0 - coluna 3
    ; Escreve "CARREGANDO"
    ;---------------------------------------------------------------

    ldi lcd_col,3
    rcall lcd_lin0_col


    ldi lcd_caracter,'C'
    rcall lcd_write_caracter

    ldi lcd_caracter,'A'
    rcall lcd_write_caracter

    ldi lcd_caracter,'R'
    rcall lcd_write_caracter

    ldi lcd_caracter,'R'
    rcall lcd_write_caracter

    ldi lcd_caracter,'E'
    rcall lcd_write_caracter

    ldi lcd_caracter,'G'
    rcall lcd_write_caracter

    ldi lcd_caracter,'A'
    rcall lcd_write_caracter

    ldi lcd_caracter,'N'
    rcall lcd_write_caracter

    ldi lcd_caracter,'D'
    rcall lcd_write_caracter

    ldi lcd_caracter,'O'
    rcall lcd_write_caracter


    ;---------------------------------------------------------------
    ; Linha 1 - coluna 0
    ; Escreve "CAIXAS="
    ;---------------------------------------------------------------

    ldi lcd_col,0
    rcall lcd_lin1_col


    ldi lcd_caracter,'C'
    rcall lcd_write_caracter

    ldi lcd_caracter,'A'
    rcall lcd_write_caracter

    ldi lcd_caracter,'I'
    rcall lcd_write_caracter

    ldi lcd_caracter,'X'
    rcall lcd_write_caracter

    ldi lcd_caracter,'A'
    rcall lcd_write_caracter

    ldi lcd_caracter,'S'
    rcall lcd_write_caracter

    ldi lcd_caracter,'='
    rcall lcd_write_caracter


    ;---------------------------------------------------------------
    ; Inicializa contador de caixas
    ;
    ; caixas = 0
    ;---------------------------------------------------------------

    ldi aux,0
    mov caixas,aux


    ;---------------------------------------------------------------
    ; Mostra valor inicial
    ;---------------------------------------------------------------

    ldi lcd_col,7
    rcall lcd_lin1_col

    mov lcd_number,caixas
    rcall lcd_write_number



;====================================================================
; LOOP PRINCIPAL
;====================================================================

Loop:

    ;---------------------------------------------------------------
    ; Liga motor
    ;---------------------------------------------------------------

    sbi _SFR_IO_ADDR(PORTB), M1



;====================================================================
; Aguarda sensor SP1 ser acionado
;
; PB0 utiliza pull-up:
;
; sensor aberto:
;       PB0 = 1
;
; sensor para GND:
;       PB0 = 0
;====================================================================

SP1_ON:

    ; Skip if Bit in I/O Register is Clear
    ;
    ; Se PB0 = 0, pula RJMP
    ;
    ; Enquanto PB0 = 1 permanece esperando

    sbic _SFR_IO_ADDR(PINB), SP1

    rjmp SP1_ON



;====================================================================
; Aguarda sensor ser liberado novamente
;====================================================================

SP1_OFF:

    ; Skip if Bit in I/O Register is Set
    ;
    ; Se PB0 = 1, pula RJMP
    ;
    ; Enquanto PB0 = 0 permanece esperando

    sbis _SFR_IO_ADDR(PINB), SP1

    rjmp SP1_OFF



    ;---------------------------------------------------------------
    ; Incrementa número de caixas
    ;---------------------------------------------------------------

    inc caixas



    ;---------------------------------------------------------------
    ; Atualiza quantidade no LCD
    ;
    ; Linha 1
    ; Coluna 7
    ;---------------------------------------------------------------

    ldi lcd_col,7
    rcall lcd_lin1_col

    mov lcd_number,caixas
    rcall lcd_write_number



    ;---------------------------------------------------------------
    ; Compara número de caixas com 12
    ;
    ; EOR:
    ;
    ; 12 XOR caixas
    ;
    ; se forem iguais:
    ;
    ; resultado = 0
    ; Z = 1
    ;
    ; BREQ realiza o salto
    ;---------------------------------------------------------------

    ldi aux,12

    eor aux,caixas

    breq ALERTA



    ;---------------------------------------------------------------
    ; Aguarda aproximadamente 1 segundo
    ;---------------------------------------------------------------

    ldi delay_time,1

    rcall delay_seconds


    rjmp Loop



;====================================================================
; ALERTA
;====================================================================

ALERTA:

    ;---------------------------------------------------------------
    ; Desliga motor
    ;---------------------------------------------------------------

    cbi _SFR_IO_ADDR(PORTB), M1



    ;---------------------------------------------------------------
    ; Linha 0 - coluna 3
    ;
    ; Mostra "  PRONTO  "
    ;---------------------------------------------------------------

    ldi lcd_col,3

    rcall lcd_lin0_col


    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,'P'
    rcall lcd_write_caracter

    ldi lcd_caracter,'R'
    rcall lcd_write_caracter

    ldi lcd_caracter,'O'
    rcall lcd_write_caracter

    ldi lcd_caracter,'N'
    rcall lcd_write_caracter

    ldi lcd_caracter,'T'
    rcall lcd_write_caracter

    ldi lcd_caracter,'O'
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter



    ;---------------------------------------------------------------
    ; Aguarda aproximadamente 1 segundo
    ;---------------------------------------------------------------

    ldi delay_time,1

    rcall delay_seconds



    ;---------------------------------------------------------------
    ; Apaga a mensagem
    ;---------------------------------------------------------------

    ldi lcd_col,3

    rcall lcd_lin0_col


    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter

    ldi lcd_caracter,' '
    rcall lcd_write_caracter



    ;---------------------------------------------------------------
    ; Aguarda aproximadamente 1 segundo
    ;---------------------------------------------------------------

    ldi delay_time,1

    rcall delay_seconds


    ; Repete indicação PRONTO
    rjmp ALERTA

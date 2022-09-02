;====================================================================
; programa exemplo de um semaforo de 3 saidas
;
; Created:   seg ago 24 2015
; Processor: ATmega328P
; Compiler:  AVRASM (Proteus)
;====================================================================

;====================================================================
; DEFINITIONS
;====================================================================
.equ VERMELHO = pb5	; Saída	(Atuador)	
.equ AMARELO = pb4	; Saída (Atuador)				
.equ VERDE = pb3	; Entrada  (Sensor)
;====================================================================
; VARIABLES
;====================================================================

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      rjmp  Start

;====================================================================
; CODE SEGMENT
;====================================================================
.include "lib328Pv01.inc"
Start:
      ; configura entradas e saidas
      sbi ddrb,5	; Configura a porta pb5 como saída
      sbi ddrb,4	; Configura a porta pb4 como saída
      sbi ddrb,3	; Configura a porta pb3 como saida
Loop:
fase1: 
      cbi portb,VERMELHO 	; apaga saida pino
      cbi portb,AMARELO	; apaga saida pino
      sbi portb,VERDE 	; SETA saida pino
      ldi delay_time, 2 	; Carrega delay_time com 
      rcall delay_seconds	; Chama rotina de atraso
      
fase2: 
      cbi portb,VERMELHO 	; apaga saida pino
      sbi portb,AMARELO	; apaga saida pino
      cbi portb,VERDE 	; SETA saida pino
      ldi delay_time, 2 	; Carrega delay_time com
      rcall delay_seconds	; Chama rotina de atraso

fase3:      
      sbi portb,VERMELHO 	; apaga saida pino
      cbi portb,AMARELO	; apaga saida pino
      cbi portb,VERDE 	; SETA saida pino
      ldi delay_time, 2 	; Carrega delay_time com 
      rcall delay_seconds	; Chama rotina de atraso
      
      rjmp  Loop

;====================================================================

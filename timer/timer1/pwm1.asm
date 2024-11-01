;====================================================================
; exemplo pwm utilizando timer 1 com biblioteca

;====================================================================

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      rjmp  Start
      
;====================================================================
; DEFINITIONS
;====================================================================

;====================================================================
; BIBLIOTECA
;====================================================================

; Arquivo de sub-rotinas de uso geral para o ATMEGA328P - Versão 01

.def delay_time = r25		
.def display_number = r24		
.def eeprom_address = r23
.def eeprom_number = r22
.def transmit_caracter = r21	
.def receive_caracter = r15	
.def adc_value = r14
.def pwm_value = r20
.def overflow_counter = r13
.def lcd_caracter = r19
.def lcd_number = r18		
.def lcd_col = r17	
.def aux =	r16	


; ### Sub-rotina PWM de 8 bits e 500Hz pela PB2 ###
pwm_write:
	sbi ddrb,pb2
	ldi r30,0b10100001
	sts TCCR1A,r30
	ldi r30,0
	sts OCR1BH,r30
	mov r30,pwm_value
	sts OCR1BL,r30
	ldi r30,0b00000011
	sts TCCR1B,r30
	ret

; ### Sub-rotina Start Timer1 (1 pulso de clock = 62.5ns) Pre-scale de 64 e timer1 de 16bits => Cada estouro acontece a cada 64*65536*62.5ns = 0.262s ###
start_timer1:
	ldi r30,0b00000011		   
	sts TCCR1B,r30			   
	ldi r30,0b00000001		   
	sts TIMSK1,r30			   
	sei						  
	ret						   

; ### Sub-rotina Stop Timer1 (1 pulso de clock = 62.5ns) Pre-scale de 64 e timer1 de 16bits => Cada estouro acontece a cada 64*65536*62.5ns = 0.262s ###
stop_timer1:
	ldi r30,0b00000000			
	sts TCCR1B,r30
	ldi r30,0b00000000			
	sts TIMSK1,r30
	ldi r30,0b00000000			
	sts TCNT1H,r30				
	sts TCNT1L,r30
	ldi r30,0					
	mov overflow_counter,r30
	ret




;====================================================================
; CODE SEGMENT
;====================================================================
;; .include "lib328Pv02.inc"
Start:
  ldi pwm_value,100 
  rcall pwm_write ;executa modulação pwm
  rcall start_timer1
Loop:

      rjmp  Loop


;====================================================================

;====================================================================
; Main.asm file estudo de faixa
;
; Created:   seg nov 16 2015
; Processor: ATmega328P
; Compiler:  AVRASM (Proteus)
;====================================================================

;====================================================================
; DEFINITIONS
;====================================================================

;/*
; registradores para impressao LCD
; lcd_numberL   valores ate 255  - LSB
; lcd_numberH   parte alta do valor em 16 bits MSB

; rcall lcd_write_number_0_999  funcao acionada apos valores atualizados de  lcd_numberL e  lcd_numberH (r20 e r21 reservados)
;*/

;;; ---------------- exemplo com desvios de comparacao: =, <, >
 ;  cp r11,r12  ; ou sub r11,r12
 ;  
 ;   breq r11_igual  ; igual
 ;   brlo r11_menor   ; menor
 ;   brne r11_naoigual
;	brge r11_maior_igual
;	brni negativo
;	brpl positivo


; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      rjmp  Start 

;====================================================================
; CODE SEGMENT
;====================================================================
.include "lib328Pv03.inc"
Start:
      ; Write your code here
	rcall lcd_init	; inicializa o LCD (coluna 0, linha 0)		 
	rcall lcd_clear	;	
	
    clr r21 ;  registrador inicio em zero
	
loop:
    rcall lcd_clear	;  limpa lcd
  	inc r21   ; incremento faixa

	ldi lcd_col,0  ; impressao do registrador 
	rcall lcd_lin0_col
  	mov lcd_numberL,r21  
	rcall lcd_write_number_0_999

	


;;; ------------------ comparacoes e desvios por faixa de valores
    ldi aux,50
	cp r21,aux
	 brlo faixa1   ; r21 <50  
     ldi aux,100
	cp r21,aux
	 brlo faixa2   ; 50<= r21 <100  
	 ldi aux,150
	cp r21,aux
	  brlo faixa3   ;100 <= r21 <150 
	  ldi aux,200
	cp r21,aux
	  brlo faixa4   ;150 <= r21 <200 
	  rjmp faixa5   ; r21>=200

faixa1:              
    ldi lcd_col,0
	rcall lcd_lin1_col
   	ldi lcd_caracter,'*'
	rcall lcd_write_caracter	
	ldi lcd_caracter,'*'
	rcall lcd_write_caracter	
	ldi lcd_caracter,'*'
	rcall lcd_write_caracter	
	rjmp fim_analise

faixa2: 
   	ldi lcd_col,3           
	rcall lcd_lin1_col
   	ldi lcd_caracter,'='
	rcall lcd_write_caracter	
	ldi lcd_caracter,'='
	rcall lcd_write_caracter	
	ldi lcd_caracter,'='
	rcall lcd_write_caracter	
	rjmp fim_analise


faixa3 : 
   	ldi lcd_col,6
	rcall lcd_lin1_col
   	ldi lcd_caracter,'-'
	rcall lcd_write_caracter	
	ldi lcd_caracter,'-'
	rcall lcd_write_caracter	
	ldi lcd_caracter,'-'
	rcall lcd_write_caracter	
	rjmp fim_analise

faixa4:   
   	ldi lcd_col,9
	rcall lcd_lin1_col
   	ldi lcd_caracter,'/'
	rcall lcd_write_caracter	
	ldi lcd_caracter,'/'
	rcall lcd_write_caracter	
	ldi lcd_caracter,'/'
	rcall lcd_write_caracter	
	rjmp fim_analise

faixa5:
	ldi lcd_col,12
	rcall lcd_lin1_col
   	ldi lcd_caracter,'<'
	rcall lcd_write_caracter	
	ldi lcd_caracter,'<'
	rcall lcd_write_caracter	
	ldi lcd_caracter,'<'
	rcall lcd_write_caracter	
	rjmp fim_analise
	


fim_analise:


	  ldi delay_time,100
	rcall delay_miliseconds

rjmp  loop

;====================================================================

;;  define nomes para pinos
.equ bt_enter = PB0  ; entrada
 .equ sensor_vazio = PB4
 .equ sensor_cheio = PB5
 .equ motor_centr = PC0  ; saida
 .equ motor_agitar= PC1
 .equ valv_esvaziar = PC2
 .equ valv_encher = PC3




;;;  biblioteca de frases

;;;;; mensagens
	; imprime mensagem de tempo para LAVAR 1
Mensagem_lavar1:
	rcall lcd_clear
	ldi lcd_col, 0
	rcall lcd_lin0_col
	ldi lcd_caracter, 'T'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'E'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'M'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'P'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'O'
	rcall lcd_write_caracter
	ldi lcd_caracter, ' '
	rcall lcd_write_caracter
	ldi lcd_caracter, 'L'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'A'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'V'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'A'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'R'
	rcall lcd_write_caracter
	ldi lcd_caracter, ' '
	rcall lcd_write_caracter
	ldi lcd_caracter, '1'
	rcall lcd_write_caracter
    RET
  

imprime_enchendo:
	  ldi lcd_col, 0
	  rcall lcd_lin0_col
	  ldi lcd_caracter, 'E'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'n'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'c'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'h'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'e'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'n'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'd'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'o'
	  rcall lcd_write_caracter
	  ret  ; volta para onde ocorreu desvio]


imprime_agitando:
	  ldi lcd_col, 0
	  rcall lcd_lin0_col
	  ldi lcd_caracter, 'A'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'g'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'i'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 't'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'a'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'n'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'd'
	  rcall lcd_write_caracter
	  ldi lcd_caracter, 'o'
	  ret  ; volta para onde ocorreu desvio


EM_OPERACAO:
	rcall lcd_clear
	ldi lcd_col, 0
	rcall lcd_lin0_col
	ldi lcd_caracter, 'E'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'M'
	rcall lcd_write_caracter
	ldi lcd_caracter, ' '
	rcall lcd_write_caracter
	ldi lcd_caracter, 'O'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'P'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'E'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'R'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'A'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'C'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'A'
	rcall lcd_write_caracter
	ldi lcd_caracter, 'O'



;;;;;;;;;;;;;;;;;  escreve mensagem	letra por letra
BemVindo:
    rcall lcd_clear	; Chama rotina limpar o LCD e posicionar na linha 0, coluna 0
;;;;;;;  posiciona cursor
	ldi lcd_col,0   ;define coluna0
	rcall lcd_lin0_col ;define linha 0
	ldi lcd_caracter,'B'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
	ldi lcd_caracter,'E'
	rcall lcd_write_caracter
	ldi lcd_caracter,'M'
	rcall lcd_write_caracter
	ldi lcd_caracter,' '
    rcall lcd_write_caracter
	ldi lcd_caracter,'V'
	rcall lcd_write_caracter
	ldi lcd_caracter,'I'
	rcall lcd_write_caracter
	ldi lcd_caracter,'N'
	rcall lcd_write_caracter
	ldi lcd_caracter,'D'
	rcall lcd_write_caracter
	ldi lcd_caracter,'O'
	rcall lcd_write_caracter
    RET


EscolhaTamanho:
    rcall lcd_clear	; Chama rotina limpar o LCD e posicionar na linha 0, coluna 0
;;;;;;;  posiciona cursor
	ldi lcd_col,0   ;define coluna0
	rcall lcd_lin0_col ;define linha 0
	ldi lcd_caracter,'T'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
	ldi lcd_caracter,'A'
	rcall lcd_write_caracter
	ldi lcd_caracter,'M'
	rcall lcd_write_caracter
	ldi lcd_caracter,' A'
    rcall lcd_write_caracter
	ldi lcd_caracter,'N'
	rcall lcd_write_caracter
	ldi lcd_caracter,'H'
	rcall lcd_write_caracter
	ldi lcd_caracter,'0'
	rcall lcd_write_caracter
	ldi lcd_caracter,'?'
	rcall lcd_write_caracter
    RET

PMG:
;;;;;;;  posiciona cursor
	ldi lcd_col,0   ;define coluna0
	rcall lcd_lin1_col ;define linha 0
	ldi lcd_caracter,'P'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
		
ldi lcd_col,8   ;define coluna0
	rcall lcd_lin1_col ;define linha 0
	ldi lcd_caracter,'M'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
	
ldi lcd_col,15   ;define coluna0
	rcall lcd_lin1_col ;define linha 0
	ldi lcd_caracter,'G'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
    RET


EscolhaAcucar :    ;; imprimir uma mensagem sobre Acuçar?
    rcall lcd_clear	; Chama rotina limpar o LCD e posicionar na linha 0, coluna 0
;;;;;;;  posiciona cursor
	ldi lcd_col,0   ;define coluna0
	rcall lcd_lin0_col ;define linha 0
	ldi lcd_caracter,'A'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
	ldi lcd_caracter,'ç'
	rcall lcd_write_caracter
	ldi lcd_caracter,'u'
	rcall lcd_write_caracter
	ldi lcd_caracter,' c'
    rcall lcd_write_caracter
	ldi lcd_caracter,'a'
	rcall lcd_write_caracter
	ldi lcd_caracter,'r'
	rcall lcd_write_caracter
	ldi lcd_caracter,'?'
	rcall lcd_write_caracter
	RET

IFSP:
	ldi lcd_caracter,'I'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
	ldi lcd_caracter,'F'
	rcall lcd_write_caracter
	ldi lcd_caracter,'S'
	rcall lcd_write_caracter
	ldi lcd_caracter,'P'
	rcall lcd_write_caracter
	ldi lcd_caracter,64  ; = 65 no codigo ascii
	rcall lcd_write_caracter
    RET


SN:
;;;;;;;  posiciona cursor
	ldi lcd_col,0   ;define coluna0
	rcall lcd_lin1_col ;define linha 0
	ldi lcd_caracter,'S'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
		

ldi lcd_col,15   ;define coluna0
	rcall lcd_lin1_col ;define linha 0
	ldi lcd_caracter,'N'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
    RET

seunome:
	ldi lcd_col,1    ;define coluna3
	rcall lcd_lin0_col ;define linha 0
	ldi lcd_caracter,'C'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
	ldi lcd_caracter,'h'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
	ldi lcd_caracter,'a'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
	ldi lcd_caracter,'v'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
	ldi lcd_caracter,'e'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
	ldi lcd_caracter,'s'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
    RET

 seuprontuario:
;;;;;;;  posiciona cursor
	ldi lcd_col,0    ;define coluna5
	rcall lcd_lin1_col ;define linha 1

;;;;;;;;;;;;; imprimir numero	 20  21
        
        ldi lcd_number, 23   ;;; move para o registro da biblioteca LCD
	    rcall lcd_write_number  ;; chama rotina para imprimir numero

        ldi lcd_number, 21   ;;; move para o registro da biblioteca LCD
	    rcall lcd_write_number  ;; chama rotina para imprimir numero 0 -99


    ldi lcd_col,12    ;define coluna5
	rcall lcd_lin1_col ;define linha 1


        ldi lcd_number, 2   ;;; move para o registro da biblioteca LCD
	    rcall lcd_write_numberunidade  ;; chama rotina para numero apenas uma unidade
   
       RET


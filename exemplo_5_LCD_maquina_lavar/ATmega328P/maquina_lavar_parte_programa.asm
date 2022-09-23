; .def delay_time1 = r16
; .def AUX = r16
 .def TL1 = r20
 .def TL2 = r21
 .def TM = r22
 .def TS = r23
 .def TC = r24
 .equ mais = PB0  ; entrada
 .equ menos = PB1
 .equ enter = PB2
 .equ sensor_porta = PB3
 .equ sensor_vazio = PB4
 .equ sensor_cheio = PB5
 .equ motor_centr = PC0  ; saida
 .equ motor_lav = PC1
 .equ valv_esv = PC2
 .equ valv_cheio = PC3
 .equ valv_sab = PC4
 .equ valv_amac = PC5

 .org 0x00
    rjmp  Inicio
    .include "biblioteca.inc"

Inicio:
	ldi aux, 0b00000000  ; definiu PORTB entrada
	out DDRB, aux ; definiu PORTB entrada
	ldi aux, 0b11111111
	out PORTB, aux  ; ativou pull up
	out DDRC, aux  ;;  definiu PORTC SAIDA
	out DDRD, aux  ;   definiu PORTC SAIDA
 	rcall lcd_init ; inicializa LCD
	rcall lcd_clear ; limpa LCD

	ldi TL1,0
	ldi TL2,0
    ldi TC,0
    ldi TM,0
    ldi TS,0

	; impirime mensagem de bem vindo por 5 segundos
Comeco:
	ldi lcd_col, 7  ; posiciona cursor na coluna 7
	rcall lcd_lin0_col ; posiciona cursor na linha 0 LCD
	ldi lcd_caracter,'O' ; envia caracter O para lcd
	rcall lcd_write_caracter ; chama rotina para imprimir caracter
	ldi lcd_caracter,'L'
	rcall lcd_write_caracter
	ldi lcd_caracter,'A'
	rcall lcd_write_caracter
	ldi delay_time, 5  ; define tempo
	rcall delay_seconds ; chama rotina de tempo

	; imprime mensagem de tempo para LAVAR 1
Def_tp_tl1:
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

Imp_tl1:
	ldi lcd_col,8
	rcall lcd_lin1_col  ; chama rotina posicionando na segunda linha
	mov lcd_number, TL1 ; move valor para imprimir TL1
	rcall lcd_write_number

	sbis PINB, 0 ; testa pino B0 sem pressionar =1 pula linha
	rjmp Aum_1 ; botao pressionado

	sbis PINB, 1 ; testa pino B1 sem pressionar =1 pula linha
	rjmp Dim_1 ; botao pressionado

	sbis PINB, 2 ; testa pino B2 sem pressionar =1 pula linha
	rjmp Def_tp_tl2 ; botao pressionado pula para proxima etapa
	rjmp Imp_tl1

Aum_1:
	inc TL1
	ldi delay_time,200
	rcall delay_miliseconds  ; atraso para o botao pressionado
	rjmp Imp_tl1

Dim_1:
	dec TL1
	ldi delay_time,200
	rcall delay_miliseconds  ; atraso para o botao pressionado
	rjmp Imp_tl1


Def_tp_tl2:  ; define tempo lavar 2


Def_tp_mol:  ; define tempo de molho 2



Def_tp_sec:  ; define tempo centrifugar

	;;;;;;;;;;================================================================================
	;;;;;;;;;;;;;  inicializando  maquina de lavar imprime EM OPERACAO
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
	;;;;;;;;
Encher1:
	rcall Parar ; testa porta se porta aberta
	rcall imprime_enchendo  ; chama rotina para imprimir lcd enchendo
	sbi PORTC,valv_cheio   ; liga valvula para encher
Testa_encher:
	sbis PINB, sensor_cheio  ; testa se o sensor de cheio
	rjmp Lavar1 ; =0 pula proxima etapa
	rjmp Testa_encher ; =1 retorna para encher1

Lavar1:
	rcall imprime_lavando1  ; chama rotina para imprimir lcd lavando1
	cbi PORTC,valv_cheio ; desliga valvula encher
	sbi PORTC,valv_sab ; liga valvula sabao
	sbi PORTC,motor_lav ; liga motor lavar
	mov delay_time, TL1 ; define tempo de lavagem 1 movendo valor TL1 para delay_time
	rcall delay_seconds ; chama rotina de delay segundos
	cbi PORTC,motor_lav ; desliga motor lavar
	cbi PORTC,valv_sab ; desliga sabao

Esvaziar1:
    sbi PORTC,valv_esv  ; liga valvula esvaziar
	rcall imprime_esvaziando  ; chama rotina para imprimir lcd _esvaziando:
	rcall Parar ; testa porta se porta aberta
Testa_esvaziar1:
	sbis PINB, sensor_vazio ; testa o nivel vazio
	rjmp Encher2  ; =0 pula proxima etapa
	rjmp Testa_esvaziar1 ;=1 retorna em esvaziar 1




	rjmp Inicio ; retorna ao incio do processo

Parar:
    sbis PINB, 3 ; nao pressionado =1 pula linha retornando
	rjmp suspende ; porta aberta =0  zera saidas
	ret
suspende:
    IN r0, PORTC  ;guarda o estado da portC em aux
	;mov r0, aux  ; armazena r0 valor de aux
	clr aux
	OUT PORTC,aux; zera saidas
loop_parado:
	sbis PINB, 3 ; testa o botao =1 (porta fechada) pula, se =0(porta aberta) e fica em loop
	rcall loop_parado
    mov aux, r0  ; recupera valor de r0 em aux
    OUT PORTC, aux  ; restaura o valor da porta
	ret
	// FIM



	;;;; rotinas para impressao de mensagem durante operacao
imprime_enchendo:
	  ldi lcd_col, 0
	  rcall lcd_lin1_col
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
	  ret  ; volta para onde ocorreu desvio
imprime_esvaziando:
         Ret

;
; Programa_Chaves.asm
;
; Created: 13/12/2017 11:37:58
; Author : LUIZ
;


; Replace with your application code
.equ mart_In1 = pb1
    .equ mart_In2 = pb2
    .equ mart_In3 = pb3
    .equ mart_In4 = pb4
    .equ bt_zera = pd2
    .def enable = r20


    .org 0x0000
    rjmp start

    .org 0x0016  ;  <<< desvio quando TCNT1 alcança valor de OCRA1
     rjmp TIM1_encoder_limite

     .org 0x0050

    .include "lib328Pv03.inc"

    start:

    sbi ddrb,mart_In1
    sbi ddrb,mart_In2
    sbi ddrb,mart_In3
    sbi ddrb,mart_In4
	cbi ddrd,bt_zera
	sbi portb,bt_zera

    ldi enable,1

    ldi r16,0b0101000 ;  modo CTC tabela 9.17

    sts TCCR1A,r16

    ldi r16,0b00001111 ;clock externo pino T1 (pd5) contagem borda subida     modo CTC bit3=1
    sts TCCR1B,r16

    ldi r16,0b00000000 ; NAO ATIVAR INICIALMENTE interrupcao TC1 igualdade de comparacao 0CR1A     
    sts TIMSK1,r16


   ; ldi r16,0        ; define que a contagem começa em 0
    ;sts TCNT1H,r16
    ;ldi r16,0
    ;sts TCNT1L,r16

    ;ldi r16,0x64  ; define que o TOPO de contagem é 100
    ;sts OCR1AH,r16
    ;ldi r16,0
    ;sts OCR1AL,r16


    ;sei.  <<< não liga a interrupcao geral
    
rcall zerar 

loop:
;    exibe mensagem proxima posicao valor de OCR1AL 
 ;   + botao aumenta OCRA1L  > desvia para a funcao mais
  ;  - botao diminui OCRA1L  > desvia para a funcao menos
   ; <enter> botao desvia para ativargiro. ; esta funcao primeiro zera a posicao do motor rodando em sentido contrario ate bater no fim de curso, e depois posiciona o braço no valor de OCRA1L
     

    rjmp loop



mais:
   lds r16,OCR1AL
   inc r16
   lds OCR1AL,r16
   rjmp loop
   
menos:
  lds r16,OCR1AL
  inc r16
  lds OCR1AL,r16
  rjmp loop
   
ativargiro: 
    rcall zerar  ; zera a posicao antes de ir para o proximo passo
    ldi enable, 1
    ldi r16,0b00000010 ;  ATIVAR interrupcao TC1 igualdade de comparacao 0CR1A, quando o valor for alcançado, desviara para 0x16 e desliga a interrupcao e desliga enable   
    sts TIMSK1,r16
    sei    
giro:
    ;Inicia primeiro passo do motor. Energizando pinos 1 e 4
    Primeiro_passo:
      sbi portb,mart_In1
      cbi portb,mart_In2
      cbi portb,mart_In3
      sbi portb,mart_In4
      ldi delay_time,30
      rcall delay_miliseconds
      cpi enable,1 ; compara enable com 1  VERIFICA se timer1 desligou enable 
     brne desliga ; se for diferente de 1 desliga motor

      Segundo_passo:
      
    cbi portb,mart_In1
    sbi portb,mart_In2
    cbi portb,mart_In3
    sbi portb,mart_In4
     
    ldi delay_time,30
    rcall delay_miliseconds
    cpi enable,1 ; compara enable com 1  VERIFICA se timer1 desligou enable 
     brne desliga ; se for diferente de 1 desliga motor

    terceiro_passo:
     
    cbi portb,mart_In1
    sbi portb,mart_In2
    sbi portb,mart_In3
    cbi portb,mart_In4
    ldi delay_time,30
    rcall delay_miliseconds
   cpi enable,1 ; compara enable com 1  VERIFICA se timer1 desligou enable 
     brne desliga ; se for diferente de 1 desliga motor

Quarto_passo:

    sbi portb,mart_In1
    cbi portb,mart_In2
    sbi portb,mart_In3
    cbi portb,mart_In4
    ldi delay_time,30
    rcall delay_miliseconds

     cpi enable,1 ; compara enable com 1 
     brne desliga ; se for diferente de 1 desliga motor
     rjmp giro ; volta os passos até que enable seja desligado por timer1 comparacao OCR1A
         


TIM1_encoder_limite:
     clr enable ; desliga enable
     ldi r16,0b00000000 ;  desliga interrupcao TC1 igualdade de comparacao 0CR1A  
     sts TIMSK1,r16
     reti
     
zerar: 
    ;; ZERAR O BRAÇO, GIRE O BRAÇO EM SENTIDO CONTRARIO até bater no fim de curso
    ;; rodar sentido contrario
    sbic pind,bt_zera
	reti

	 sbi portb,mart_In1
    cbi portb,mart_In2
    sbi portb,mart_In3
    cbi portb,mart_In4
    ldi delay_time,30
    rcall delay_miliseconds

	cbi portb,mart_In1
    sbi portb,mart_In2
    sbi portb,mart_In3
    cbi portb,mart_In4
    ldi delay_time,30
    rcall delay_miliseconds

	cbi portb,mart_In1
    sbi portb,mart_In2
    cbi portb,mart_In3
    sbi portb,mart_In4
    ldi delay_time,30
    rcall delay_miliseconds

	sbi portb,mart_In1
    cbi portb,mart_In2
    cbi portb,mart_In3
    sbi portb,mart_In4
    ldi delay_time,30
    rcall delay_miliseconds


    sbic pind,bt_zera
    rjmp zerar
    reti

	desliga:

	cbi portb,mart_In1
    cbi portb,mart_In2
    cbi portb,mart_In3
    cbi portb,mart_In4

	rjmp desliga

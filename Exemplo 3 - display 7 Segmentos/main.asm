//------------------------------------------------------------------------------------- //
//		AVR e Arduino: T�cnicas de Projeto, 2a ed. - 2012.								//	
//------------------------------------------------------------------------------------- //
//=====================================================================================	//
//		ESCREVENDO EM UM DISPLAY DE 7 SEGMENTOS ANODO COMUM 							//           
//	Toda vez que um bot�o � pressionado o valor do Display muda(0->F)					//
//	mantendo-se o bot�o pressionado o incremento � autom�tico 							//        
//====================================================================================	//

.equ BOTAO    = PB0		//BOTAO � o substituto de PB0 na programa��o      
.equ DISPLAY  = PORTD	//PORTD � onde est� conectado o Display (seg a = LSB)
.def AUX      = R16;	//R16 tem agora o nome de AUX 

//------------------------------------------------------------------------------------
.ORG 0x000	
rjmp Inicializacoes

.include "lib328Pv02.inc"

// define entradas e saidas
Inicializacoes:

	LDI  AUX,0b11111110	//carrega AUX com o valor 0xFE (1 sa�da, 0 entrada)
	OUT  DDRB,AUX    	//configura PORTB, PB0 entrada e PB1 .. PB7 sa�das 
	LDI  AUX,0xFF	    
	OUT  PORTB,AUX  	//habilita o pull-up do PB0 (demais pinos em 1)
	OUT  DDRD, AUX    	//PORTD como sa�da
	 LDI  AUX,0x00	
	OUT  PORTD,AUX   	//desliga o display

	//*Para utilizar os pinos PD0 e PD1 como I/O gen�rico no Arduino � necess�rio 
//	desabilitar as fun��es TXD e RXD desses pinos*/

	STS UCSR0B,R1		//carrega o valor 0x00 (default de R1) em USCR0B, como ele esta na SRAM, usa-se STS

//------------------------------------------------------------------------------------
//   exemplo de um contador
      clr r17
      mov aux, r17 
      RCALL Decodifica	//chama sub-rotina de decodifica��o display 7 segmentos mostra porta D
 loop:

contagem:
      sbis PINB,0  // incrementa contador   R17
      inc R17

      mov aux, r17 
      RCALL Decodifica	//chama sub-rotina de decodifica��o display 7 segmentos mostra porta D
      
     ldi delay_time,1	; Carrega delay_time com 5 (5 segundos)
      rcall delay_seconds	; Chama rotina de atraso

      
       ldi R16, 6
       cp R16, R17
       breq  DESLIGAR  // iguais
        rjmp loop                  // nao igual

DESLIGAR:
        CLR R17
        mov aux, r17   // contador
        RCALL Decodifica	//chama sub-rotina de decodifica��o display 7 segmentos mostra porta D
    
fim:
      rjmp fim
	


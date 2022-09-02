//------------------------------------------------------------------------------------- //
//		AVR e Arduino: Técnicas de Projeto, 2a ed. - 2012.								//	
//------------------------------------------------------------------------------------- //
//=====================================================================================	//
//		ESCREVENDO EM UM DISPLAY DE 7 SEGMENTOS ANODO COMUM 							//           
//	Toda vez que um botão é pressionado o valor do Display muda(0->F)					//
//	mantendo-se o botão pressionado o incremento é automático 							//        
//====================================================================================	//

.equ BOTAO    = PB0		//BOTAO é o substituto de PB0 na programação      
.equ DISPLAY  = PORTD	//PORTD é onde está conectado o Display (seg a = LSB)
.def AUX      = R16;	//R16 tem agora o nome de AUX 

//------------------------------------------------------------------------------------
.ORG 0x000	
rjmp Inicializacoes

.include "lib328Pv02.inc"

// define entradas e saidas
Inicializacoes:

	LDI  AUX,0b11111110	//carrega AUX com o valor 0xFE (1 saída, 0 entrada)
	OUT  DDRB,AUX    	//configura PORTB, PB0 entrada e PB1 .. PB7 saídas 
	LDI  AUX,0xFF	    
	OUT  PORTB,AUX  	//habilita o pull-up do PB0 (demais pinos em 1)
	OUT  DDRD, AUX    	//PORTD como saída
	 LDI  AUX,0x00	
	OUT  PORTD,AUX   	//desliga o display

	//*Para utilizar os pinos PD0 e PD1 como I/O genérico no Arduino é necessário 
//	desabilitar as funções TXD e RXD desses pinos*/

	STS UCSR0B,R1		//carrega o valor 0x00 (default de R1) em USCR0B, como ele esta na SRAM, usa-se STS

//------------------------------------------------------------------------------------
//   exemplo de um contador
      clr r17
      mov aux, r17 
      RCALL Decodifica	//chama sub-rotina de decodificação display 7 segmentos mostra porta D
 loop:

contagem:
      sbis PINB,0  // incrementa contador   R17
      inc R17

      mov aux, r17 
      RCALL Decodifica	//chama sub-rotina de decodificação display 7 segmentos mostra porta D
      
     ldi delay_time,1	; Carrega delay_time com 5 (5 segundos)
      rcall delay_seconds	; Chama rotina de atraso

      
       ldi R16, 6
       cp R16, R17
       breq  DESLIGAR  // iguais
        rjmp loop                  // nao igual

DESLIGAR:
        CLR R17
        mov aux, r17   // contador
        RCALL Decodifica	//chama sub-rotina de decodificação display 7 segmentos mostra porta D
    
fim:
      rjmp fim
	


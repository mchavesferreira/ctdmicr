
//------------------------------------------------------------------------------------
//SUB-ROTINA que decodifica um valor de 0 -> 15 para o display 
//------------------------------------------------------------------------------------
Decodifica:
 
	LDI  ZH,HIGH(Tabela<<1)	//carrega o endereço da tabela no registrador Z, de 16 bits (trabalha como um ponteiro)
	LDI  ZL,LOW(Tabela<<1) 	//deslocando a esquerda todos os bits, pois o bit 0 é para a seleção do byte alto ou baixo no end. de memória
	ADD  ZL,AUX 	   		//soma posição de memória correspondente ao nr. a apresentar na parte baixa do endereço
	BRCC le_tab           	//se houve Carry, incrementa parte alta do endereço, senão lê diretamente a memória
	INC  ZH    
      
le_tab:		
	LPM  R0,Z            	//lê valor em R0
	OUT  DISPLAY,R0   		//mostra no display
	RET
//------------------------------------------------------------------------------------
//	Tabela p/ decodificar o display: como cada endereço da memória flash é de 16 bits, 
//	acessa-se a parte baixa e alta na decodificação
//------------------------------------------------------------------------------------
Tabela: .dw 0x7940, 0x3024, 0x1219, 0x7802, 0x1800, 0x0308, 0x2146, 0x0E06
//             1 0     3 2     5 4     7 6     9 8     B A     D C     F E  
//====================================================================================

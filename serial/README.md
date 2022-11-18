

Utilizando a biblioteca para comunicação serial
```ruby
.def transmit_caracter = r21	
.def receive_caracter = r15	

; ### Sub-rotina de configuração da USART em 9600bps ###
usart_init:
	ldi r30,0			
	sts UBRR0H,r30		 
	ldi r30,103			
	sts UBRR0L,r30		
	ldi r30,0b00011000	
	sts UCSR0B,r30		 
	ret					
	
; ### Sub-rotina para transmissão de caracter pela USART ###
usart_transmit:
	lds r30,UCSR0A		
	sbrs r30,UDRE0     
	rjmp usart_transmit	
	sts UDR0,transmit_caracter		
	ret					

; ### Sub-rotina para transmissão de caracter pela USART ###
usart_receive:
	lds r30,UCSR0A		
	sbrs r30,RXC0		
	rjmp usart_receive	
	lds receive_caracter, UDR0		
	ret
```  

Exemplo enviando a palavra IFSP utilizando a biblioteca:
```ruby
.include "lib328Pv02.inc"
     
	rcall  usart_init ; configura a comunicacao serial em 9600 bps

	ldi transmit_caracter,'I'	; carrega o caracter
	rcall usart_transmit	; chama a rotina para transmitir o caracter com a USART	
	ldi transmit_caracter,'F'
	rcall usart_transmit
	ldi transmit_caracter,'S'
	rcall usart_transmit
```  
	
  
  Rotina para separação de caracteres em LCD ou em comunicações seriais
  
```ruby 
  ; ### Sub-rotina para escrever um numero de 0 a 255 no LCD ###
lcd_write_number_0_999:
	clr   centenas
	clr   dezenas
	clr   unidades
	 
findcentenas:
 	subi  lcd_numberL,100        ;keep subtracting 100
	sbci  lcd_numberH,0          ;across two bytes
	brcs  finddezenas	       ;until number goes negative
	inc   centenas         ;incrementing a "centenas" register
	rjmp  findcentenas     ;each time

finddezenas:
	subi  lcd_numberL,-100       ;add back the last hundred
	subi  lcd_numberL,10	       ;to make the number positive
	brcs  findunidades         ;and repeat the process with dezenas
	inc   dezenas
	rjmp  finddezenas+1

findunidades:
	subi lcd_numberL,-10        ;then repeat with unidades
	mov   unidades,lcd_numberL
	ldi r29,48
 	add centenas,r29   ;  soma 48 para tabela ascii
 	add dezenas,r29
 	add unidades,r29
	mov lcd_caracter,centenas 
	rcall lcd_write_caracter
	mov lcd_caracter,dezenas
	rcall lcd_write_caracter
	mov lcd_caracter,unidades
	rcall lcd_write_caracter
	CLR  lcd_numberL      ;keep subtracting 100
	CLR lcd_numberH          ;across two bytes
	ret
  
```


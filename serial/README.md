# Comunicações seriais disponíveis no ATMEGA 328P

- Usart
- SPI
- I2C

A importância de uma comunicação entre periféricos ou meio externo
<br><img src=imagens/link.png>


Modos de comunicação em apenas uma direção ou simultânea
<br><img src=imagens/modos.png>

Comunicações paralela/série
<br><img src=imagens/serialparalelo.png>

## Vantagens e desvantagens das comunicações série/paralelo

### Modo Serial

•Vantagens:
Confiável, 
Baixo custo, Baixo consumo

•Desvantagens: Lento, Requer controle complexo

###  Modo Paralelo

•Vantagens: Muito rápido, Simples de implementar

•Desvantagens: Não confiável, Curto alcance, Caro, Consome mais energia


## Comunicações Assíncronas 

Não utilizam clock e estabelecem tempo para o envio ou tempo de cada caractere

O remetente envia dados a uma certa velocidade. Para flexibilidade, os protocolos permitem várias velocidades.

Se o destinatário não souber a velocidade ou julgá-la incorretamente, podem ocorrer erros.

<br><img src=imagens/assincrona.png>

## Comunicação síncrona 

Possui uma via de sinal de sincronismo (clock)

O remetente envia um sinal de clock junto com os dados: a cada borda ascendente/descendente do clock, o valor dos dados é lido pelo receptor.

<br><img src=imagens/sincrona.png>


<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/serial/imagens/modosincronismo.png>

## Universal Asynchronous Receiver-Transmitter (UART)
•UART é um protocolo serial half-duplex, assíncrono e simples.
•Comunicação simples entre dois nós equivalentes.
•Qualquer nó pode iniciar a comunicação.
•Como a conexão é half-duplex, as duas vias de comunicação são completamente independentes.

A comunicação USART, a mesa utilizada em RS232

<img src=imagens/usart.png>

Registradores importantes para configuração da comnicação
UBRR0H e  UBRR0L //Ajusta a taxa de transmissão
UCSR0B   //Habilita o transmissor e o receptor 
UCSR0C  //Ajusta o formato do frame:

Exemplo em C para transmitir um caractere
<BR><img src=imagens/modotransmissao.png>
	
Exemplo em C para receber um caractere
<BR><img src=imagens/modotransmissao.png>
	
Registradores de controle
<BR><img src=imagens/controlandStatusregistera.png>

<BR><img src=imagens/controlandStatusregisterb.png>

<BR><img src=imagens/controlandstatusregisterc.png>

Ajuste de baud rate register
<BR><img src=imagens/baudrateregister.png>
	
Ajuste do frame de comunicação
<BR><img src=imagens/ajustedosbits.png>	
	
Equações para o cálculo do registrador UBRR0 da taxa de transmissão
<BR><img src=imagens/equacoesbaud.png>	
	
Utilizando a biblioteca para comunicação serial

```ruby
.def transmit_caracter = r21	
.def receive_caracter = r15	

; ### Sub-rotina de configuração da USART em 9600bps ###
usart_init:
    ldi r30, 0                ; Carrega o valor 0 no registrador r30
    sts UBRR0H, r30           ; Define o registrador UBRR0H (parte alta do Baud Rate) como 0
    ldi r30, 103              ; Carrega o valor 103 no registrador r30
    sts UBRR0L, r30           ; Define o registrador UBRR0L (parte baixa do Baud Rate) com 103
    ldi r30, 0b00011000       ; Carrega o valor binário 00011000 em r30
    sts UCSR0B, r30           ; Define o registrador UCSR0B para habilitar o transmissor e receptor USART
    ret                       ; Retorna da sub-rotina			
	
; ### Sub-rotina para transmissão de caracter pela USART ###
usart_transmit:
    lds r30, UCSR0A          ; Carrega o conteúdo do registrador UCSR0A em r30
    sbrs r30, UDRE0          ; Salta a próxima instrução se o bit UDRE0 (buffer de dados vazio) estiver limpo
    rjmp usart_transmit      ; Se o buffer não estiver vazio, continua tentando (espera buffer estar pronto)
    sts UDR0, transmit_caracter ; Escreve o dado de transmit_caracter no registrador UDR0 para enviar
    ret                      ; Retorna da sub-rotina
				

; ### Sub-rotina para transmissão de caracter pela USART ###
usart_receive:
    lds r30, UCSR0A          ; Carrega o conteúdo do registrador UCSR0A em r30
    sbrs r30, RXC0           ; Salta a próxima instrução se o bit RXC0 (recepção completa) estiver limpo
    rjmp usart_receive       ; Se o bit RXC0 não estiver setado, continua tentando ler (espera o dado chegar)
    lds receive_caracter, UDR0 ; Carrega o dado recebido no registrador UDR0 para receive_caracter
    ret                      ; Retorna da sub-rotina
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
	ldi transmit_caracter,'P'
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

Exemplo utilizando a comunicação serial para configurar uma saida PWM

O código a seguir é um exemplo de ajuste de uma saída serial através da comunicacao serial, onde + e - ajusta a largura de pulso

<details><summary>Código PWM/Serial</summary>

```ruby
.include "lib328Pv02.inc"
Start:
      ; Write your code here
	rcall  usart_init ; configura a comunicaÁ„o serial em 36®00 bps

	ldi transmit_caracter,'+'	; carrega o caracter
	rcall usart_transmit	;transmite o caracter	
	ldi transmit_caracter,' '
	rcall usart_transmit
	ldi transmit_caracter,'A'
	rcall usart_transmit
	ldi transmit_caracter,'u'
	rcall usart_transmit
	ldi transmit_caracter,'m'
	rcall usart_transmit
	ldi transmit_caracter,'e'
	rcall usart_transmit
	ldi transmit_caracter,'n'
	rcall usart_transmit
	ldi transmit_caracter,'t'
	rcall usart_transmit
	ldi transmit_caracter,'a'
	rcall usart_transmit
	
	ldi transmit_caracter,10
	rcall usart_transmit
	ldi transmit_caracter,13
	rcall usart_transmit
	
	ldi transmit_caracter,'-'	
	rcall usart_transmit		
	ldi transmit_caracter,' '
	rcall usart_transmit
	ldi transmit_caracter,'D'
	rcall usart_transmit
	ldi transmit_caracter,'i'
	rcall usart_transmit
	ldi transmit_caracter,'m'
	rcall usart_transmit
	ldi transmit_caracter,'i'
	rcall usart_transmit
	ldi transmit_caracter,'n'
	rcall usart_transmit
	ldi transmit_caracter,'u'
	rcall usart_transmit
	ldi transmit_caracter,'i'
	rcall usart_transmit
	
	ldi transmit_caracter,10
	rcall usart_transmit
	ldi transmit_caracter,13
	rcall usart_transmit
	
	ldi transmit_caracter,'A'	
	rcall usart_transmit		
	ldi transmit_caracter,'P'
	rcall usart_transmit
	ldi transmit_caracter,'E'
	rcall usart_transmit
	ldi transmit_caracter,'R'
	rcall usart_transmit
	ldi transmit_caracter,'T'
	rcall usart_transmit
	ldi transmit_caracter,'E'
	rcall usart_transmit
	ldi transmit_caracter,':'
	rcall usart_transmit
	
	ldi transmit_caracter,10	
	rcall usart_transmit		
	ldi transmit_caracter,13	
	rcall usart_transmit
Loop:
	rcall usart_receive; aguarda a recepcao de caracter
        ldi aux,'+'
        eor aux,receive_caracter ;receive_caracter='+'?	
        breq mais ; sim, desvia para mais
        ldi aux,'-'			 
        eor aux,receive_caracter ; receive _caracter='-'?	
        breq menos ;sim,desvia para menos
rjmp  Loop

mais:
	ldi aux,5
	add pwm_value,aux ;pwm_value=pwm_value-5 (add=soma)
	rcall pwm_write ;executa modulaÁ„o pwm
	rjmp Loop
	
menos:
	ldi aux,5
	sbc pwm_value,aux ;pwm_value=pwm_value-5 (sbc=subtrai)
	rcall pwm_write  ;executa modulaÁ„o pwm
	rjmp Loop
```

</details>

## Conversão de dados

A rotina https://github.com/mchavesferreira/mice/blob/main/serial/CONVERT.asm  pode ser utilizada para converter valores antes da transmissão



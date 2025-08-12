# Microcontroladores e microprocessadores 



## Aulas Turma 2025

- 29/07  - Introdução a Disciplina, Histórico sobre microcomputadores. Revisão de sistemas digitais, conversão de bases, decodificadores e memórias
- 05/08 - Arquitetura de funcionamento de um microprocessador genérico. 
- 12/08 - <a href=https://github.com/mchavesferreira/ctdmicr/tree/main/processadores> Funcionamento básico. Z80. Arquitetura VonNeuman, Havard, CISC, RISC. Memórias Voláteis e não Voláteis
- 19/08 -  Arquitetura de microcontroladores. 8051, PIC16F628, AVR Atmega 328P
- 26/08 -  Primeiras instruções assembly para Atmega328P. [Mapeamento de Memória](#Mapeamento-de-memória) 
- 02/09 -  Ambiente de programação
- 09/09 -  [Programa Pisca Led](#Programa-Pisca-Led), [Programa Reservatorio](#Programa-Reservatorio)
- 16/09 -  Simulador Wowki, Display 7 segmentos  [Dislplay 7 Segmentos](#Dislplay-7-Segmentos)
- 23/09 -  [Display LCD 16x2](#Display-LCD-16x2)
- 30/09 -  Timer0, Projeto Microcontrolado: [Maquina de Lavar](#Maquina-de-Lavar)
- 07/10  -  Interrupções, Temporização - [Interrupção Externa](#Interrupção)<BR>
- 21/10 -  Avaliação Escrita/Trabalho em Grupo
- 28/10 - Introdução e prática com timer 1  <a href=https://github.com/mchavesferreira/mice/tree/main/interrupcao>clique aqui</a>
- 04/11 - <a href=https://github.com/mchavesferreira/mice/tree/main/serial>Comunicação UART/Serial</a>
- 11/11 - Multiplexação de display (cronometro)
- 18/11 - <a href=https://github.com/mchavesferreira/mice/tree/main/conversor_ad>Conversor AD</a>
- 25/11 - <a href=https://github.com/mchavesferreira/mice/blob/main/eeprom/README.MD>Memória EEPROM</a> (prática Timer, Uart, Conversor AD, eeprom, lcd, botões)
- 02/12 - Prova 2
- 09/12 - [PROJETO](#PROJETO) Apresentação FINAL do Projeto da disciplina 
- 16/12 - IFA


 Help:  
 
 https://chatgpt.com/g/g-TFvuISQH5-professor-dos-embarcados
 
## Utilizando Atmega328P para a compreensão e funcionamento de microprocessadores e microcontroladores em geral utilizando a linguagem Assembly.

## Sumário
- <a href=https://github.com/mchavesferreira/mice/tree/main/processadores>Microprocessadores</a>
- [Programas e Simuladores](#simulador-wokwi-e-Atmel-Studio)
- [Mapeamento de Memória](#Mapeamento-de-memória)
- [Configuração de pinos](#Configuração-de-pinos)
- [Diagrama de blocos](#Diagrama-de-blocos)
- [Sistemas de clock](#Sistemas-de-clock)
- [Sistema de Reset](#Sistema-de-Reset)
- [Assembly-primeiro programa](#Assembly-Primeiro-programa)
- [Temporização](#Temporização) : Timer 0, Timer 1, Timer 2 e PWM
- [Conversor AD](#Conversor-AD) 
- [Comunições Seriais](#Comunicação-Serial) 
        - [USART]
        - [SPI]
        - [I2C]
- [Memória EEPROM](#Conversor-AD) 


- [Projetos e Programas](#Projetos-e-Programas)
	- [Pisca Led](#Pisca-Led)
	- 
	- 
	- 




## Simulador Wokwi e Atmel Studio

<center><img src=imagens/wokwi_simulador.png></center>

Simulador <a href=https://wokwi.com/projects/341066839950885460>Atmega328P Assembly Online</a>

Teclas de atalho e tutorial para o <a href=https://docs.wokwi.com/pt-BR/guides/diagram-editor> Simulador Wokwi</a><P>

Atmel Studio:<a href=http://studio.download.atmel.com/7.0.2389/as-installer-7.0.2389-full.exe>Atmel Studio 7.0</a><BR>
  
Gravador para firmware .hex utilizando bootloader Arduino: <a href=https://github.com/mchavesferreira/smie/blob/main/hexloader.zip>Hexloader</a>
 
# Mapeamento-de-memória
 
Instruções principais para a movimentação de bytes na memória do Atmega328
<center><img src=https://raw.githubusercontent.com/mchavesferreira/smie/main/imagens/movimentacao_bits_bytes.png></center>
 
# Configuração de pinos

<center><img src=imagens/pinout_atmega328P.png></center>

## Atmega 328p

https://youtu.be/q9hdLVaBdvM?si=qtBKph2J_WjbxWr6&t=30  Video Laser fibra

# Pinos Arduino UNO

![tabela_arduino](https://github.com/mchavesferreira/mcr/assets/63993080/315726ac-c35e-4365-84e5-910684880c2a)

| Nome do Pino (Porta) | Descrição no Arduino | Funções Principais          |
|----------------------|----------------------|-----------------------------|
| PC0                  | A0                   | ADC0, PCINT8                |
| PC1                  | A1                   | ADC1, PCINT9                |
| PC2                  | A2                   | ADC2, PCINT10               |
| PC3                  | A3                   | ADC3, PCINT11               |
| PC4                  | A4 (SDA)             | ADC4, PCINT12, SDA (TWI)    |
| PC5                  | A5 (SCL)             | ADC5, PCINT13, SCL (TWI)    |
| PD0                  | 0 (RX)               | RXD, PCINT16                |
| PD1                  | 1 (TX)               | TXD, PCINT17                |
| PD2                  | 2                    | INT0, PCINT18               |
| PD3                  | 3 (PWM)              | OC2B, INT1, PCINT19         |
| PD4                  | 4                    | XCK, T0, PCINT20            |
| PD5                  | 5 (PWM)              | OC0B, T1, PCINT21           |
| PD6                  | 6 (PWM)              | AIN0, OC0A, PCINT22         |
| PD7                  | 7                    | AIN1, PCINT23               |
| PB0                  | 8                    | ICP1, CLKO, PCINT0          |
| PB1                  | 9 (PWM)              | OC1A, PCINT1                |
| PB2                  | 10 (PWM, SS)         | OC1B, SS, PCINT2            |
| PB3                  | 11 (PWM, MOSI)       | MOSI, OC2A, PCINT3          |
| PB4                  | 12 (MISO)            | MISO, PCINT4                |
| PB5                  | 13 (SCK, LED)        | SCK, PCINT5                 |



# Diagrama de blocos

O Atmel® ATmega328P é um microcontrolador CMOS de 8 bits de baixa potência baseado na arquitetura RISC aprimorada AVR®. Ao executar instruções poderosas em um único ciclo de clock, o ATmega328P atinge taxas de transferência de aproximadamente 1MIPS por MHz, permitindo otimizar consumo de energia versus a velocidade de processamento.[1]
<center><img src=imagens/diagrama_blocos.png></center

Para maximizar o desempenho e o paralelismo, o AVR usa uma arquitetura harvard – com memórias e barramentos separados para programa e dados. As instruções na memória do programa são executadas com um pipelining de nível único. Enquanto uma instrução está sendo executada, a próxima instrução é pré-buscada na memória do programa. Este conceito permite que as instruções sejam executadas em cada ciclo de clock. A memória do programa é uma memória flash reprogramável no sistema.[1]

O núcleo AVR® combina um rico conjunto de instruções com 32 registradores de trabalho de uso geral(GPR). Todos os 32 registradores são conectados diretamente à unidade lógica aritmética (ULA), permitindo que dois registradores independentes sejam acessados em uma única instrução executada em um ciclo de clock. A arquitetura resultante é mais eficiente em termos de código, ao mesmo tempo em que alcança rendimentos até dez vezes mais rápidos do que os microcontroladores CISC convencionais.
O Atmel® ATmega328P fornece os seguintes recursos: 32K bytes de flash programável no sistema com recursos de leitura durante a gravação, 1K bytes EEPROM, 2K bytes SRAM, 23 linhas de E/S de uso geral, 32 registradores de trabalho de uso geral, três temporizadores flexíveis /Contadores com modos de comparação, interrupções internas e externas, um USART programável serial, uma interface serial de 2 fios orientada a byte, uma porta serial SPI, um ADC de 6 canais e 10 bits (8 canais em pacotes TQFP e QFN/MLF) , um temporizador de watchdog programável com oscilador interno e cinco modos de economia de energia selecionáveis por software. O modo ocioso para a CPU enquanto permite que a SRAM, Temporizador/Contadores, USART, interface serial de 2 fios, porta SPI e sistema de interrupção continuem funcionando. O modo de desligamento salva o conteúdo do registro, mas congela o oscilador, desabilitando todas as outras funções do chip até a próxima interrupção ou reinicialização do hardware. No modo de economia de energia, o temporizador assíncrono continua a funcionar, permitindo que o usuário mantenha uma base de temporizador enquanto o restante do dispositivo está dormindo. O modo de redução de ruído ADC para a CPU e todos os módulos de E/S, exceto temporizador assíncrono e ADC, para minimizar o ruído de comutação durante as conversões ADC. No modo de espera, o oscilador de cristal/ressonador está funcionando enquanto o restante do dispositivo está dormindo. Isto permite um arranque muito rápido combinado com um baixo consumo de energia.[1]


## Core CPU
A principal função do núcleo da CPU (core CPU) é garantir a execução correta do programa. A CPU deve, portanto, ser capaz de acessar memórias, realizar cálculos, controlar periféricos e lidar com interrupções.

<center><img src=imagens/core_cpu.png></center
					      

# Sistemas de clock

Principais sistemas de clock do AVR® e sua distribuição. Todos os clock não precisam estar ativos em um determinado momento. Para reduzir o consumo de energia, os relógios dos módulos que não estão sendo usados podem ser interrompidos usando diferentes modos de suspensão, conforme descrito na Seção "Modes Sleep Gerenciamento de energia e modos de suspensão". 
<center><img src=imagens/distribuicaoclock_f_8_1.png></center>
Para maximizar o desempenho e o paralelismo, o AVR usa uma arquitetura harvard – com memórias e barramentos separados para programa e dados. As instruções na memória do programa são executadas com um pipelining de nível único. Enquanto uma instrução está sendo executada, a próxima instrução é pré-buscada na memória do programa. Este conceito permite que as instruções sejam executadas em cada ciclo de clock. A memória do programa é uma memória flash reprogramável no sistema.[1]

# Sistema de Reset

<center><img src=imagens/sistema_reset.png>Lógica Reset</center>

Durante o reset, todos os registradores de E/S são ajustados para seus valores iniciais, e o programa inicia a execução a partir do vetor de reset. Para o Atmel® ATmega328P, a instrução colocada no vetor de reset deve ser uma instrução RJMP – salto relativo – para a rotina de manipulação de reset. Se o programa nunca habilita uma fonte de interrupção, os vetores de interrupção não são usados e o código de programa regular pode ocupar nesses locais. Este também é o caso se o vetor de reset estiver na seção de aplicação enquanto os vetores de interrupção estiverem na seção de inicialização. As portas de E/S do AVR® são imediatamente redefinidas para seu estado inicial quando uma fonte de redefinição fica ativa. Isso não requer que nenhuma fonte de relógio esteja em execução. Após todas as fontes de reset ficarem inativas, um contador de atraso é invocado, estendendo o reset interno. Isso permite que a potência atinja um nível estável antes do início da operação normal. O tempo limite do contador de atraso é definido pelo usuário através dos fusíveis SUT e CKSEL. 

# Programa Pisca Led

Programa Pisca Led
<center><a href=https://wokwi.com/projects/341066839950885460><img src=https://github.com/mchavesferreira/mcr/blob/main/imagens/pisca.png  width=300 height=300 border=0></a></center>

 ```ruby  
; Pisca LED on PB5(Arduino Uno pin 13)
#define __SFR_OFFSET 0

#include "avr/io.h"  

.global main   ; obrigatorio simulador

.ORG 0x000
main:
  LDI R16,0b11111111		//carrega R16 com o valor 0xFF
	OUT DDRB,R16

principal:
  sbi   PORTB, 5 ; Seta o pino da porta   
  call  ATRASO
  cbi   PORTB, 5   ; Clear(0) o pino da porta   
  call  ATRASO
  rjmp principal

ATRASO:
	LDI R19,80	
volta:		
	DEC  R17			//decrementa R17, comeÁa com 0x00
	BRNE volta 			//enquanto R17 > 0 fica decrementando R17
	DEC  R18			//decrementa R18, comeÁa com 0x00
	BRNE volta			//enquanto R18 > 0 volta decrementar R18
	DEC  R19			//decrementa R19
	BRNE volta
  ret
; Exemplo Pisca Led Avr Projetos

```


## Pisca Led com biblioteca

<details><summary>Código Exemplo Pisca Led com utilização de biblioteca para delay</summary>
<p>

```ruby  
*/
//--------------------------------------------------------------------------- //
//		Fonte: AVR e Arduino: Técnicas de Projeto, 2a ed. - 2012.					  //	
//--------------------------------------------------------------------------- //

.equ LED   = PB5  		//LED é o substituto de PB5 na programação 

.ORG 0x000				//endereço de início de escrita do código 
rjmp INICIO
.include "lib328Pv03.inc"
INICIO:
	LDI R16,0xFF		//carrega R16 com o valor 0xFF
	OUT DDRB,R16		//configura todos os pinos do PORTB como saída

PRINCIPAL:
      SBI PORTB, LED		//coloca o pino PB5 em 5V
      ldi delay_time, 2 	; Carrega delay_time com
      rcall delay_seconds	; Chama rotina de atraso
	 CBI PORTB, LED 	//coloca o pino PB5 em 0V
	 RCALL ATRASO		//chama a sub-rotina de atraso
	 RJMP PRINCIPAL 	//volta para PRINCIPAL
```
</p>
</details> 

Biblioteca: <a href=https://raw.githubusercontent.com/mchavesferreira/mcr/main/programas_livro/lib328Pv03.inc>lib328Pv03.inc</a>

## Programa-Reservatorio

Exemplo de um programa para controle de reservatório.

<BR>Defina pinos de entrada e saída. As entradas com push button aterradas e  pull up ativos. O Programa aguarda “Start” ser pressionado, que liga a  Valvula 1 até que sensor cheio seja acionado. O misturador é acionado  por2 segundos. Esvazia-se o tanque até o sensor vazio ser acionado, retornando ao estado inicial. Considere clock 16Mhz.
<br><BR>Solução:
<br>Para que servem e quais são os registradores de I/O de um AVR Atmega?  Os registradores de IO  funcionam para configurar, ler e escrever cada  pino das portas  do microcontrolador, cada bit representa um pino:  DDRx  quando em 0=entrada e 1=saída. PINx para a leitura do pino quando este é  definido com entrada; PORTx escreve na saída se o pino é definido como  saída ou ativa pull-up se o pino é definido como entrada.
	<Br>
<details><summary>Ilustração da Solução (clique)</summary>
<p>
<br><img src=imagens/oprojeto.jpg>
<br><img src=imagens/configuracaopinos.jpg>
<br><img src=imagens/inicio.jpg>
<br><img src=imagens/principal.jpg>
<br><img src=imagens/encher.jpg>
<br><img src=imagens/misturar.jpg>
<br><img src=imagens/esvaziar.jpg>
<br><img src=imagens/atraso.jpg>
</p>
</details>

<details><summary>Código Solução Controle Reservatório</summary>
<p>

```ruby 
//--------------------------------------------------------------------------- //
// EXEMPLO 					  //	
//--------------------------------------------------------------------------- //

.ORG 0x000				

INICIO:
     LDI R19, 0b00000111	//carrega R19 
     OUT DDRB,R19		//configura todos os pinos
     LDI R19, 0b00111000
     OUT PORTB, R19
; aguarda botao start
PRINCIPAL:      
     SBIC PINB,5		
     RJMP Principal
     RJMP ENCHER

; Liga válvula aguarda sensor cheio
ENCHER:
    SBI PORTB,0
    SBIC PINB,3
    RJMP ENCHER
    RJMP MISTURAR

; desliga V1, liga misturador por 2 seg. 
MISTURAR:
    CBI PORTB,0
    SBI PORTB,2
    RCALL ATRASO 
    RCALL ATRASO 
    CBI PORTB, 2
    RJMP ESVAZIAR

; Liga válvula 2 aguarda sensor vazio
ESVAZIAR:
    SBI PORTB,1
    SBIC PINB,4
    RJMP ESVAZIAR
    CBI PORTB,1
    RJMP PRINCIPAL
; .  .    .   .    .    .    .    .   .     .   
; rotina de atraso 1 segundo. 
ATRASO:	
      LDI R19,80	
volta:		
      DEC  R17	
      BRNE volta
      DEC  R18	
      BRNE volta
      DEC  R19
      BRNE volta
      RET
```
</details>

Simulação:  https://wokwi.com/projects/394247093827346433

![image](https://github.com/mchavesferreira/mcr/assets/63993080/fee83e1b-24d9-4df6-bfa0-f8256ef35413)



 
# Dislplay 7 Segmentos

<a href=https://github.com/mchavesferreira/mice/tree/main/Exemplo%203%20-%20display%207%20Segmentos>Saiba mais</a>
	
# Display LCD 16x2
	

<a href=https://github.com/mchavesferreira/mice/tree/main/exemplo_4_LCD>Display LCD </a>

### Maquina de Lavar	
	
Exemplo Maquina de Lavar
	
<a href=https://github.com/mchavesferreira/smie/tree/main/exemplo_5_LCD_maquina_lavar><img src=imagens/maquinadelavar.png border=0>
Maquina de lavar </a>
	
Código AVR assembly
<a href=https://wokwi.com/projects/341106129478091346>Simulação Maquina de lavar</a> (woki)


## Interrupção
	
### Interrupção Externa

Slide, código para ativação de Int0 e Int1
<a href=https://github.com/mchavesferreira/smie/tree/main/interrupcao>Exemplo Interrupção externa</a>
	
## Temporização

## Timer 0


## Conversor AD
Código para conversão AD utilizando periférico interno
<a href=https://github.com/mchavesferreira/smie/tree/main/conversor_ad>Saiba mais sobre o conversor AD</a>

## Comunicação Serial

Comunicação UART 

<a href=https://github.com/mchavesferreira/smie/tree/main/serial>Saiba mais sobre a comunicação serial</a>

### Pisca Led

<details><summary>Código Exemplo Pisca Led</summary>
<p>

```ruby  
*/
//--------------------------------------------------------------------------- //
//		Fonte: AVR e Arduino: Técnicas de Projeto, 2a ed. - 2012.					  //	
//--------------------------------------------------------------------------- //

.equ LED   = PB5  		//LED é o substituto de PB5 na programação 

.ORG 0x000				//endereço de início de escrita do código 
rjmp INICIO
.include "lib328Pv01.inc"
INICIO:
	LDI R16,0xFF		//carrega R16 com o valor 0xFF
	OUT DDRB,R16		//configura todos os pinos do PORTB como saída

PRINCIPAL:
      SBI PORTB, LED		//coloca o pino PB5 em 5V
      ldi delay_time, 2 	; Carrega delay_time com
      rcall delay_seconds	; Chama rotina de atraso
	 CBI PORTB, LED 	//coloca o pino PB5 em 0V
	 RCALL ATRASO		//chama a sub-rotina de atraso
	 RJMP PRINCIPAL 	//volta para PRINCIPAL


ATRASO:					//atraso de aprox. 200ms
	LDI R19,16	
 volta:		
	DEC  R17			//decrementa R17, começa com 0x00
	BRNE volta 			//enquanto R17 > 0 fica decrementando R17
	DEC  R18			//decrementa R18, começa com 0x00
	BRNE volta			//enquanto R18 > 0 volta decrementar R18
	DEC  R19			//decrementa R19
	BRNE volta			//enquanto R19 > 0 vai para volta
	RET	
```
</p>
</details> 

Simulação:
<a href=https://wokwi.com/projects/341066839950885460> Pisca Led</a><br>
 
### Dislplay 7 Segmentos
	
### Display LCD 16x2
	
Montagem Exemplo 4, esteira com display LCD

<img src=imagens/lcd_simulador.png>
	
	- LCD  > AVR (arduino);
	- RS > PD2 (9)
	- Enable > PD (8)
  
Simulação online utilizando LCD16x2: <a href=https://wokwi.com/projects/342964449732198994>Exemplo LCD </a>

### Maquina de Lavar	
	
Exemplo Maquina de Lavar
	
<a href=https://github.com/mchavesferreira/smie/tree/main/exemplo_5_LCD_maquina_lavar><img src=imagens/maquinadelavar.png border=0>
Maquina de lavar </a>
	
Código AVR assembly
<a href=https://wokwi.com/projects/341106129478091346>Simulação Maquina de lavar</a> (woki)


# PROJETO

## Requisitos
- Utilizar microcontrolador Atmega328P
- Linguagen Assembly
- Montagem prática em matriz de contados(protoboard) utilizando potênciometros como entrada analógica, botões como entradas digitais, e leds como saídas digitais
- Opcionalmente pode-se utilizar sensores e cargas (saídas) reais
- Projeto individual ou dupla
- Programação com envio de código fonte e simulação em proteus ou wokwi inserido no SUAP 
- Utilizar display LCD 16x2
- Utilizar menu com no mínimo 3 alterações de valores em configuração (tempo, limite, etc...) para uma máquina de processo
- Utilizar temporização com interrupção (Timer 0, 1 e 2)
- Utilizar uma saída com ajuste PWM
- Realizar leitura analógica (conversor AD)
- Imprimir na UART (serial) as etapas e "status" de funcionamento
- Registrar ajustes em EEPROM
- Documentar em relatório simples descrendo o projeto, procurem relacionar o uso dos requisitos com aplicações reais.
- Complexidade e criatividade serão ponderadas.  
- Prazo Trabalho prático: 13/12/2024 (Peso do trabalho na nota final: 40%)
<BR>

<BR>Peso das provas escritas: P1 30%  e  P2 30% 
<Br>Confira exemplos de <a href=https://github.com/mchavesferreira/smie/tree/main/timer>projetos</a> de ex-alunos matriculados na disciplina: 


Referências:
[1] Atmega 328P 8-bit AVR Microcontroller with 32K Bytes In-System Programmable Flash - Datasheet
	
[2] <a href=https://github.com/mchavesferreira/mcr/tree/main/dicas%20de%20projetos>Dicas de projeto</a>

## Links de auxilio

Microcontroladores Atmega e placa ESP32

<img src=https://github.com/mchavesferreira/img/blob/main/logogpt.png> https://chatgpt.com/g/g-TFvuISQH5-professor-dos-embarcados

<img src=https://github.com/mchavesferreira/img/blob/main/logogpt.png>  https://chatgpt.com/g/g-thK1Ja9RM-referencias-de-artigos-normas-abnt-nbr

Norma IEC-61131-3: https://plcopen.org/sites/default/files/downloads/intro_iec_march04_portuguese.pdf



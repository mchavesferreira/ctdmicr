# Temporizadores

## Preescaler

Na entrada dos temporizadores há um pré-escalador, que basicamente é um divisor de frequência com diferentes saídas conectadas a um multiplexador. Os temporizadores 0 e 1 compartilham o pré-escalador, mas com seleção independente.

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/divisor.png>

## Timer 0

Datasheet:  https://cdn.awsli.com.br/945/945993/arquivos/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf.pdf4

paginas 74

### Modos para o timer 0

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/modonormal.png>

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/modoctc.png>

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/fasecorrigida.png>

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/pwmrapido.png>

 ### Projetos com pwm

 
# Exemplos de códigos para os modos TIMER 0
<a href=https://github.com/mchavesferreira/ctdmicr/tree/main/timer/exemplos_timer_0_modos>Códigos</a> utilizando temporização e PWM
<BR>

## Timer 1

<a href=https://github.com/mchavesferreira/mice/blob/main/timer/timer1/Timer_1_livro.pdf>Timer 1 Capítulo livro</a>


### Blocos Timer 1

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/bloco_timer1.png>

### Pratique com timer 1

<a href=https://github.com/mchavesferreira/mice/tree/main/timer/timer1> Códigos exemplos timer 1</a>

## exemplo pwm

https://github.com/mchavesferreira/mice/blob/main/timer/timer1/pwm1.asm


## exemplo estouro timer 1 com lcd


https://github.com/mchavesferreira/mice/blob/main/timer/timer1/Timer_1_eventos_100ms.asm




# Microcontroladores e microprocessadores 

 
## Conhecendo Interrupções, Temporizadores e interrupções externas para Atmega 328P

## Interruções
- [Interrupção](#Interrupção)
        - [Interrupção Externa](#Interrupção-Externa)
        - [Timer 0](#Interrupção-Externa)
        - [Timer 1](#Interrupção-Externa)
        - [Timer 2](#Interrupção-Externa)



## Interrupção

Comportamento das interruções
<img src=imagens/comportamento_interrupcao.png>

Flags da interrupção
<img src=imagens/quadro_interrupcoes.png>

Endereços (interrupt vector) das interrupções para Atmega 328P
<img src=imagens/enderecoes_interrupcao.png>



### Interrupção Externa

Pinos da interrupção PD2(Int0) e PD3(int1)
<img src=imagens/pinos_interrupcao_int01.png.png>

Exemplo de um circuito para exemplificar a interrupção

<img src=imagens/enderecoes_interrupcao.png>

Esquema do livro:
<img src=imagens/int0_livro.png>

<a href=https://wokwi.com/projects/346138374477709906><img src=imagens/esquemasimula.png></a>



Modos para o timer

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/modonormal.png>

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/modoctc.png>

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/fasecorrigida.png>

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/pwmrapido.png>

 
### Projetos e Programas utilizando Timer 0 e Timer 1 e PWM
<a href=https://github.com/mchavesferreira/smie/tree/main/timer>Códigos</a> utilizando temporização e PWM
<BR>

## Timer 1

<a href=https://github.com/mchavesferreira/mice/blob/main/timer/timer1/Timer_1_livro.pdf>Timer 1 Capítulo livro</a>

### Preescaler

Na entrada dos temporizadores há um pré-escalador, que basicamente é um divisor de frequência com diferentes saídas conectadas a um multiplexador. Os temporizadores 0 e 1 compartilham o pré-escalador, mas com seleção independente.

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/divisor.png>

### Blocos Timer 1

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/refs/heads/main/imagens/bloco_timer1.png>

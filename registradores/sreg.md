# Aula: Entendendo o Registrador SREG e Aplicação Prática

## Introdução
O registrador de status **SREG** (Status Register) é um dos principais componentes do microcontrolador ATmega328P. Ele armazena informações sobre o estado atual do microprocessador, como flags de operações aritméticas e controle de interrupções. O **SREG** é amplamente utilizado em rotinas críticas e desempenha um papel importante em sistemas embarcados.

---

## Estrutura do SREG

O registrador **SREG** é um registrador de 8 bits, onde cada bit tem uma função específica:

| Bit  | Nome                    | Função                                                                 |
|------|-------------------------|------------------------------------------------------------------------|
| 7    | **I (Global Interrupt Enable)** | Habilita/desabilita todas as interrupções. `1`: Ativa, `0`: Desativa.   |
| 6    | **T (Transfer Bit)**            | Bit auxiliar usado para transferências temporárias e flags customizados. |
| 5    | **H (Half Carry Flag)**         | Indica transporte entre os bits 3 e 4 em operações aritméticas (BCD).    |
| 4    | **S (Sign Flag)**               | Indica o sinal da operação (combinação dos bits N e V).                  |
| 3    | **V (Overflow Flag)**           | Indica um overflow em operações aritméticas.                             |
| 2    | **N (Negative Flag)**           | Indica que o resultado da operação é negativo.                          |
| 1    | **Z (Zero Flag)**               | Indica que o resultado da operação é zero.                              |
| 0    | **C (Carry Flag)**              | Indica transporte/carry em operações aritméticas.                       |

---

## Aplicação Prática: Usando o Bit T como Flag

Neste exemplo, utilizamos o **Timer 0** para verificar o estado de um botão a cada 10 ms. Caso o botão seja pressionado, o **bit T** será ativado como um flag, indicando o evento para o programa principal.

### Código em Assembly

```assembly
.include "m328pdef.inc"

; Definições
.equ BUTTON_PIN = 2         ; Pino do botão (PD2)
.equ BUTTON_PORT = PIND     ; Registrador de entrada do PORTD
.equ BUTTON_DDR = DDRD      ; Registrador de direção do PORTD

.org 0x0000                 ; Vetor de reset
    rjmp RESET

.org 0x0020                 ; Vetor de interrupção de Timer0 Overflow
    rjmp TIMER0_ISR

RESET:
    ; Configuração inicial
    ldi r16, (1 << BUTTON_PIN)
    out BUTTON_DDR, r16      ; Configura BUTTON_PIN como entrada
    cbi PORTD, BUTTON_PIN    ; Habilita pull-up interno

    ; Configuração do Timer0
    ldi r16, (1 << CS02) | (1 << CS00) ; Prescaler 1024
    out TCCR0B, r16                  ; Configura o Timer0
    ldi r16, (1 << TOIE0)            ; Habilita interrupção de overflow
    out TIMSK0, r16

    sei                              ; Habilita interrupções globais

MAIN_LOOP:
    sbic SREG, T                     ; Verifica o flag T
    rjmp HANDLE_FLAG                 ; Se T está configurado, trata o evento
    rjmp MAIN_LOOP                   ; Continua no loop principal

HANDLE_FLAG:
    clt                              ; Limpa o flag T
    ; Coloque aqui a lógica para tratar o evento
    rjmp MAIN_LOOP                   ; Volta ao loop principal

TIMER0_ISR:
    in r16, BUTTON_PORT              ; Lê o estado do botão
    sbrs r16, BUTTON_PIN             ; Verifica se o botão está pressionado (nível baixo)
    rjmp END_ISR                     ; Se não estiver pressionado, sai da ISR
    set                              ; Configura o flag T no SREG
END_ISR:
    reti                             ; Retorna da interrupção

```


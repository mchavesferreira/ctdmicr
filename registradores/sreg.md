


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

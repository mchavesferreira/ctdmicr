# Timer 1

<a href=https://github.com/mchavesferreira/ctdmicr/blob/main/timer/timer1/Timer_1_livro.pdf>Timer 1 Capítulo livro</a>


### Blocos Timer 1

<img src=https://raw.githubusercontent.com/mchavesferreira/ctdmicr/refs/heads/main/imagens/bloco_timer1.png>

## Registradores Timer 1

### TCCR1A
<img src=https://github.com/mchavesferreira/smc/blob/main/interrupcao_timers/imgtimer1/tccr1a.png>


### TCCR1B
<img src=https://github.com/mchavesferreira/smc/blob/main/interrupcao_timers/imgtimer1/tccr1b.png>


### TCCR1C
<img src=https://github.com/mchavesferreira/smc/blob/main/interrupcao_timers/imgtimer1/tccr1c.png>

<img src=https://github.com/mchavesferreira/smc/blob/main/interrupcao_timers/imgtimer1/tabelamodotimer1.png>

### Configuração dos pinos:

<img src=https://github.com/mchavesferreira/smc/blob/main/interrupcao_timers/imgtimer1/tabelatimer1naopwm.png>

<img src=https://github.com/mchavesferreira/smc/blob/main/interrupcao_timers/imgtimer1/timer1pwmrapido.png>

### Prescaler: 
<img src=https://github.com/mchavesferreira/smc/blob/main/interrupcao_timers/imgtimer1/tabelaprescaler.png>

### TIMSK1:
<img src=https://github.com/mchavesferreira/smc/blob/main/interrupcao_timers/imgtimer1/timsk1.png>

### TIFR2
<img src=https://github.com/mchavesferreira/smc/blob/main/interrupcao_timers/imgtimer1/tifr2.png>

### Pratique com timer 1

<a href=https://github.com/mchavesferreira/mice/tree/main/timer/timer1> Códigos exemplos timer 1</a>

### PWM Timer 1

https://github.com/mchavesferreira/ctdmicr/blob/main/timer/timer1/pwm1.asm





## exemplo estouro timer 1 com display


https://github.com/mchavesferreira/ctdmicr/blob/main/timer/timer1/Timer_1_eventos_1000ms.asm



## Utilize timer 1 no lugar do delay

Substitua delay_seconds por uma contagem de tempo. No método com atraso, liga-se o motor e chama a rotina de atraso de CPU.


 ```ruby  
ANTES

Lavar1
   │
   ├── Liga motor
   │
   ├── delay_seconds
   │       ↓
   │   CPU conta o tempo
   │
   └── Desliga motor
```   
Utilizando Timer 1 Overflow.  Configuramos o timer 1 para tratar a interrupção a cada 1000ms. No programa principal inicia r2 com o tempo desejado. Então na rotina de desvio testa se r2>0 e decrementa.

No programa principal verifica se r2=0, se sim, é por que passou o tempo desejado então desliga o motor.


 ```ruby  
DEPOIS

Programa principal                Timer1
      │                              │
      ├── Liga motor                 │
      ├── r2 = TL1                   │
      │                              │
      │                         a cada 1 s
      │                              │
      │                         r2 > 0 ?
      │                              │
      │                           DEC r2
      │                              │
      ├── testa r2 ←─────────────────┘
      │
      ├── r2 != 0 → aguarda
      │
      └── r2 = 0 → desliga motor
```

## Confira os códigos:

### programa principal

 ```ruby  
;=========================================================
; ETAPA DE LAVAGEM
;=========================================================

Lavar1:

    sbi PORTC, motor_lav     ; liga motor de lavar
    ldi r16, TL1             ; tempo em segundos
    mov r2, r16              ; inicializa contador

Aguarda_Lavar1:
    tst r2                   ; r2 chegou a zero?
    brne Aguarda_Lavar1      ; não: continua aguardando
    cbi PORTC, motor_lav     ; sim: desliga motor
    rjmp Proxima_Etapa
```
### Rotina de tratamento da temporização:

 ```ruby  
;=========================================================
; TIMER1 - interrupção a cada 1000 ms
;=========================================================
TIM1_OVERFLOW:
    ; recarrega TCNT1 = 0xC2F6
    ldi r16, 0xC2
    sts TCNT1H, r16
    ldi r16, 0xF6
    sts TCNT1L, r16

evento_1seg:
    tst r2               ; verifica r2
    breq fim_timer1      ; se r2 = 0, não decrementa
    dec r2               ; senão, decrementa 1 segundo

fim_timer1:
    reti

```

; Biblioteca de sub-rotinas de uso geral para ATmega328P
; Versão adaptada para GNU AVR / PlatformIO
;
; IMPORTANTE:
; - Este arquivo deve ser incluído a partir de um arquivo .S, usando:
;       #include "lib328P_platformio.inc"
; - Não use .include para este arquivo, pois as diretivas #define e
;   #include precisam passar pelo pré-processador C.
; - As instruções SBI/CBI/SBIC/SBIS/IN/OUT usam o espaço de I/O.
;   Por isso os registradores definidos em <avr/io.h> são convertidos
;   com _SFR_IO_ADDR(...).

#ifndef LIB328P_PLATFORMIO_INC
#define LIB328P_PLATFORMIO_INC

#include <avr/io.h>

; ============================================================
; Alias de registradores
; AVRASM/Microchip Studio: .def delay_time = r25
; GNU AVR em arquivo .S:   #define delay_time r25
; ============================================================

#define delay_time         r25
#define display_number     r24
#define eeprom_address     r23
#define eeprom_number      r22
#define transmit_caracter  r21
#define receive_caracter   r15
#define adc_value           r14
#define pwm_value           r20
#define overflow_counter    r13
#define lcd_caracter        r19
#define lcd_number          r18
#define lcd_col             r17
#define aux                 r16

; Bits de controle do LCD
#define rs_lcd              PD2
#define enable_lcd          PD3

.section .text


; ============================================================
; Atraso em segundos
; delay_time = quantidade aproximada de segundos
; CPU considerada: 16 MHz
; ============================================================
delay_seconds:
    ldi r31,82
    ldi r30,0
    ldi r29,0

loop_delay:
    dec r29
    brne loop_delay
    dec r30
    brne loop_delay
    dec r31
    brne loop_delay
    dec delay_time
    brne delay_seconds
    ret


; ============================================================
; Atraso em milissegundos
; delay_time = quantidade aproximada de milissegundos
; CPU considerada: 16 MHz
; ============================================================
delay_miliseconds:
    ldi r30,22
    ldi r29,0

loop_delayms:
    dec r29
    brne loop_delayms
    dec r30
    brne loop_delayms
    dec delay_time
    brne delay_miliseconds
    ret


; ============================================================
; Aproximação de atraso por NOPs
;
; Observação:
; 16 NOPs = 1 us a 16 MHz, porém RCALL e RET acrescentam ciclos.
; Portanto, quando chamada com RCALL, esta rotina NÃO representa
; exatamente 1 us entre a chamada e o retorno.
; ============================================================
delay_1microsecond:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret


; ============================================================
; Mostra dezena e unidade em dois displays de 7 segmentos
; Dezena : PD7..PD4
; Unidade: PD3..PD0
; ============================================================
display_write:
    ldi aux,0b11111111
    out _SFR_IO_ADDR(DDRD),aux

    ldi r30,0
    ldi r31,0
    mov r31,display_number
    cpi display_number,10
    brlo display_show

display_loop:
    sbci r31,10
    inc r30
    cpi r31,10
    brlo display_show
    rjmp display_loop

display_show:
    ldi r29,0
    mov r29,r30
    swap r29
    or r29,r31
    out _SFR_IO_ADDR(PORTD),r29
    ret


; ============================================================
; Apaga o display de 7 segmentos
; ============================================================
display_off:
    ldi aux,0b11111111
    out _SFR_IO_ADDR(DDRD),aux

    ldi r30,0b11111111
    out _SFR_IO_ADDR(PORTD),r30
    ret


; ============================================================
; Escrita na EEPROM
; eeprom_address = endereço
; eeprom_number  = dado
; ============================================================
eeprom_write:
    sbic _SFR_IO_ADDR(EECR),EEPE
    rjmp eeprom_write

    out _SFR_IO_ADDR(EEARL),eeprom_address
    out _SFR_IO_ADDR(EEDR),eeprom_number

    sbi _SFR_IO_ADDR(EECR),EEMPE
    sbi _SFR_IO_ADDR(EECR),EEPE
    ret


; ============================================================
; Leitura da EEPROM
; eeprom_address = endereço
; retorno em eeprom_number
; ============================================================
eeprom_read:
    sbic _SFR_IO_ADDR(EECR),EEPE
    rjmp eeprom_read

    out _SFR_IO_ADDR(EEARL),eeprom_address
    sbi _SFR_IO_ADDR(EECR),EERE
    in eeprom_number,_SFR_IO_ADDR(EEDR)
    ret


; ============================================================
; Inicialização USART em 9600 bps
; F_CPU = 16 MHz
; UBRR0 = 103
; 8 bits, configuração padrão do frame
; ============================================================
usart_init:
    ldi r30,0
    sts UBRR0H,r30

    ldi r30,103
    sts UBRR0L,r30

    ldi r30,0b00011000
    sts UCSR0B,r30
    ret


; ============================================================
; Transmissão de caractere pela USART
; caractere em transmit_caracter
; ============================================================
usart_transmit:
    lds r30,UCSR0A
    sbrs r30,UDRE0
    rjmp usart_transmit

    sts UDR0,transmit_caracter
    ret


; ============================================================
; Recepção de caractere pela USART
; retorno em receive_caracter
; ============================================================
usart_receive:
    lds r30,UCSR0A
    sbrs r30,RXC0
    rjmp usart_receive

    lds receive_caracter,UDR0
    ret


; ============================================================
; ADC com resultado de 8 bits
; ADLAR = 1 -> resultado usado em ADCH
; Referência AVCC
; Canal ADC0
; Prescaler = 128
; ============================================================
analog_read:
    ldi r30,0b00100000
    sts ADMUX,r30

    ldi r30,0b11000111
    sts ADCSRA,r30

loop_ad:
    lds r30,ADCSRA
    sbrc r30,ADSC
    rjmp loop_ad

    lds adc_value,ADCH
    ret


; ============================================================
; PWM de 8 bits em OC1B / PB2
; Aproximadamente 490 Hz com F_CPU = 16 MHz e prescaler 64
; pwm_value = duty cycle de 0 a 255
; ============================================================
pwm_write:
    sbi _SFR_IO_ADDR(DDRB),PB2

    ldi r30,0b10100001
    sts TCCR1A,r30

    ldi r30,0
    sts OCR1BH,r30

    mov r30,pwm_value
    sts OCR1BL,r30

    ldi r30,0b00000011
    sts TCCR1B,r30
    ret


; ============================================================
; Start Timer1
; Prescaler = 64
; Overflow aproximado:
; 64 * 65536 * 62,5 ns = 0,262144 s
; ============================================================
start_timer1:
    ldi r30,0b00000011
    sts TCCR1B,r30

    ldi r30,0b00000001
    sts TIMSK1,r30

    sei
    ret


; ============================================================
; Stop Timer1
; ============================================================
stop_timer1:
    ldi r30,0b00000000
    sts TCCR1B,r30

    ldi r30,0b00000000
    sts TIMSK1,r30

    ldi r30,0b00000000
    sts TCNT1H,r30
    sts TCNT1L,r30

    ldi r30,0
    mov overflow_counter,r30
    ret


; ============================================================
; Inicialização do LCD 4 bits no PORTD
;
; RS     = PD2
; ENABLE = PD3
; D4..D7 = PD4..PD7
; ============================================================
lcd_init:
    sbi _SFR_IO_ADDR(DDRD),PD2
    sbi _SFR_IO_ADDR(DDRD),PD3
    sbi _SFR_IO_ADDR(DDRD),PD4
    sbi _SFR_IO_ADDR(DDRD),PD5
    sbi _SFR_IO_ADDR(DDRD),PD6
    sbi _SFR_IO_ADDR(DDRD),PD7

    cbi _SFR_IO_ADDR(PORTD),rs_lcd
    cbi _SFR_IO_ADDR(PORTD),enable_lcd

    cbi _SFR_IO_ADDR(PORTD),PD7
    cbi _SFR_IO_ADDR(PORTD),PD6
    cbi _SFR_IO_ADDR(PORTD),PD5
    cbi _SFR_IO_ADDR(PORTD),PD4

    ldi delay_time,15
    rcall delay_miliseconds

    cbi _SFR_IO_ADDR(PORTD),PD7
    cbi _SFR_IO_ADDR(PORTD),PD6
    sbi _SFR_IO_ADDR(PORTD),PD5
    sbi _SFR_IO_ADDR(PORTD),PD4
    rcall pulse_enable

    ldi delay_time,5
    rcall delay_miliseconds

    cbi _SFR_IO_ADDR(PORTD),PD7
    cbi _SFR_IO_ADDR(PORTD),PD6
    sbi _SFR_IO_ADDR(PORTD),PD5
    sbi _SFR_IO_ADDR(PORTD),PD4
    rcall pulse_enable

    ldi delay_time,5
    rcall delay_miliseconds

    cbi _SFR_IO_ADDR(PORTD),PD7
    cbi _SFR_IO_ADDR(PORTD),PD6
    sbi _SFR_IO_ADDR(PORTD),PD5
    sbi _SFR_IO_ADDR(PORTD),PD4
    rcall pulse_enable

    ldi delay_time,5
    rcall delay_miliseconds

    cbi _SFR_IO_ADDR(PORTD),PD7
    cbi _SFR_IO_ADDR(PORTD),PD6
    sbi _SFR_IO_ADDR(PORTD),PD5
    cbi _SFR_IO_ADDR(PORTD),PD4
    rcall pulse_enable

    ldi delay_time,1
    rcall delay_miliseconds

    ldi lcd_caracter,0x28
    rcall lcd_write_caracter

    ldi lcd_caracter,0x0C
    rcall lcd_write_caracter

    ldi lcd_caracter,0x01
    rcall lcd_write_caracter

    ldi delay_time,2
    rcall delay_miliseconds

    ldi lcd_caracter,0x06
    rcall lcd_write_caracter

    sbi _SFR_IO_ADDR(PORTD),rs_lcd
    ret


; ============================================================
; Limpa o LCD
; ============================================================
lcd_clear:
    cbi _SFR_IO_ADDR(PORTD),rs_lcd

    ldi lcd_caracter,1
    rcall lcd_write_caracter

    ldi delay_time,2
    rcall delay_miliseconds

    sbi _SFR_IO_ADDR(PORTD),rs_lcd
    ret


; ============================================================
; Escreve um caractere/comando no LCD em modo de 4 bits
; lcd_caracter = byte a transmitir
; ============================================================
lcd_write_caracter:
    sbrc lcd_caracter,7
    sbi _SFR_IO_ADDR(PORTD),PD7
    sbrs lcd_caracter,7
    cbi _SFR_IO_ADDR(PORTD),PD7

    sbrc lcd_caracter,6
    sbi _SFR_IO_ADDR(PORTD),PD6
    sbrs lcd_caracter,6
    cbi _SFR_IO_ADDR(PORTD),PD6

    sbrc lcd_caracter,5
    sbi _SFR_IO_ADDR(PORTD),PD5
    sbrs lcd_caracter,5
    cbi _SFR_IO_ADDR(PORTD),PD5

    sbrc lcd_caracter,4
    sbi _SFR_IO_ADDR(PORTD),PD4
    sbrs lcd_caracter,4
    cbi _SFR_IO_ADDR(PORTD),PD4

    rcall pulse_enable

    sbrc lcd_caracter,3
    sbi _SFR_IO_ADDR(PORTD),PD7
    sbrs lcd_caracter,3
    cbi _SFR_IO_ADDR(PORTD),PD7

    sbrc lcd_caracter,2
    sbi _SFR_IO_ADDR(PORTD),PD6
    sbrs lcd_caracter,2
    cbi _SFR_IO_ADDR(PORTD),PD6

    sbrc lcd_caracter,1
    sbi _SFR_IO_ADDR(PORTD),PD5
    sbrs lcd_caracter,1
    cbi _SFR_IO_ADDR(PORTD),PD5

    sbrc lcd_caracter,0
    sbi _SFR_IO_ADDR(PORTD),PD4
    sbrs lcd_caracter,0
    cbi _SFR_IO_ADDR(PORTD),PD4

    rcall pulse_enable
    ret


; ============================================================
; Gera pulso de Enable do LCD e aguarda aproximadamente 50 us
; ============================================================
pulse_enable:
    cbi _SFR_IO_ADDR(PORTD),enable_lcd
    rcall delay_1microsecond

    sbi _SFR_IO_ADDR(PORTD),enable_lcd
    rcall delay_1microsecond

    cbi _SFR_IO_ADDR(PORTD),enable_lcd

    ldi r26,50

loop_pulse:
    rcall delay_1microsecond
    dec r26
    cpi r26,0
    brne loop_pulse
    ret


; ============================================================
; Posiciona cursor na linha 0
; lcd_col = coluna
; ============================================================
lcd_lin0_col:
    cbi _SFR_IO_ADDR(PORTD),rs_lcd

    ldi r30,0x80
    add lcd_col,r30
    mov lcd_caracter,lcd_col

    rcall lcd_write_caracter

    sbi _SFR_IO_ADDR(PORTD),rs_lcd
    ret


; ============================================================
; Posiciona cursor na linha 1
; lcd_col = coluna
; ============================================================
lcd_lin1_col:
    cbi _SFR_IO_ADDR(PORTD),rs_lcd

    ldi r30,0xC0
    add lcd_col,r30
    mov lcd_caracter,lcd_col

    rcall lcd_write_caracter

    sbi _SFR_IO_ADDR(PORTD),rs_lcd
    ret


; ============================================================
; Escreve número de 0 a 99 no LCD
; lcd_number = número
; ============================================================
lcd_write_number:
    ldi r31,0
    ldi r30,0
    mov r30,lcd_number

    cpi lcd_number,10
    brlo lcd_show

lcd_loop:
    sbci r30,10
    inc r31
    cpi r30,10
    brlo lcd_show
    rjmp lcd_loop

lcd_show:
    ldi r29,48
    add r30,r29
    add r31,r29

    mov lcd_caracter,r31
    rcall lcd_write_caracter

    mov lcd_caracter,r30
    rcall lcd_write_caracter
    ret


; ============================================================
; Escreve número de 0 a 9 no LCD
; ============================================================
lcd_write_numberunidade:
    mov r30,lcd_number

    ldi r29,48
    add r30,r29

    mov lcd_caracter,r30
    rcall lcd_write_caracter
    ret


#endif

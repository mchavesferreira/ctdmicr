


Exemplo EEPROM


```ruby

.equ SP1 = pb0
.equ AL = pb4
.equ M1 = pb5

.def caixas = r0

      ; Reset Vector
      rjmp  Start

.include "lib328Pv01.inc"
Start:
      ; Write your code here
      cbi ddrb,0
      sbi portb,0
      sbi ddrb,4
      sbi ddrb,5
      ldi eeprom_address,0
      rcall eeprom_read
      mov caixas,eeprom_number
      mov display_number,caixas
      rcall display_write
Loop:
      sbi portb,M1
      cbi portb,AL
 SP1ON:
      sbic pinb,SP1
      rjmp SP1ON
 SP1OFF:
      sbis pinb,SP1
      rjmp SP1OFF
      
      inc caixas
      mov display_number,caixas
      rcall display_write
      mov eeprom_number,caixas
      rcall eeprom_write
      ldi aux,12
      eor aux,caixas
      breq ALERTA
      rjmp  Loop

 ALERTA:
      cbi portb,M1
      sbi portb,AL
      ldi eeprom_number,0
      rcall eeprom_write
      ldi delay_time,1
      rcall delay_seconds
      cbi portb,AL
      ldi delay_time,1
      rcall delay_seconds
      rjmp ALERTA



```

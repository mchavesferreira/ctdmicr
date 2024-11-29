# EEPROM 

Memória para armazernar dados não voláteis

A memória EEPROM é utilizada em aplicações onde é necessário armazenar dados que podem ser modificados durante a execução do programa. Para evitar que o programa precise monitorar continuamente o término de uma escrita, é possível usar uma interrupção da EEPROM, que notifica quando a operação é concluída.

Ela não é adequada para armazenar dados fixos que nunca serão alterados; nesse caso, a memória flash é mais apropriada, salvo situações onde há limitações de espaço na flash.

No microcontrolador ATmega328, a EEPROM possui 1 kbyte, organizada como uma memória separada, permitindo a leitura e gravação de bytes individualmente. A EEPROM é projetada para suportar pelo menos 100 mil ciclos de gravação e apagamento. A interação com a CPU ocorre através de registradores específicos para endereço, dados e controle.

Para realizar uma gravação segura na EEPROM e evitar alterações indesejadas, é necessário seguir uma sequência de passos específicos, embora a ordem de alguns passos seja flexível.

De acordo com os registradores e bits de trabalho da EEPROM, os seguintes passos são necessários para efetuar-se uma escrita (a ordem dos passos 2 e 3 não é importante). Esses passos são necessários para se evitar um eventual escrita acidental.

**1. Esperar até que o bit EEPE do registrador EECR se torne zero.**

**2. Escrever o novo endereço da EEPROM no registrador EEAR** (opcional).

**3. Escrever o dado a ser gravado no registrador EEDR (opcional).**

**4. Escrever 1 lógico no bit EEMPE enquanto escreve 0 no bit EEPE do registrador EECR.**

**5. Dentro de quatro ciclos de clock após ativar EEMPE, escrever 1 lógico no bit EEPE.**

## Biblioteca para EEPROM

```ruby
.def eeprom_address = r23   ; Define o registrador r23 como eeprom_address para armazenar o endereço da EEPROM.
.def eeprom_number = r22    ; Define o registrador r22 como eeprom_number para armazenar o dado a ser gravado ou lido.

; ### Sub-rotina para escrita na EEPROM ###
eeprom_write:               
	sbic EECR,EEPE           ; Verifica se o bit EEPE no registrador EECR está limpo (0).
	                         ; EEPE indica que uma operação de gravação está em andamento.
	                         ; Se EEPE estiver limpo, a próxima instrução será executada.
	rjmp eeprom_write        ; Se EEPE estiver definido (1), salta de volta para eeprom_write para esperar até estar pronto.
	out EEARL,eeprom_address ; Especifica o endereço na EEPROM onde os dados serão gravados.
	                         ; O valor de eeprom_address (r23) é movido para o registrador EEARL.
	out EEDR,eeprom_number   ; Coloca o dado a ser gravado no registrador de dados da EEPROM (EEDR).
	                         ; O valor de eeprom_number (r22) é movido para EEDR.
	sbi EECR,EEMPE           ; Define o bit EEMPE no registrador EECR para habilitar a operação de gravação.
	                         ; Este bit é temporário e deve ser definido antes de ativar EEPE.
	sbi EECR,EEPE            ; Define o bit EEPE para iniciar a gravação.
	                         ; Isso transfere o valor em EEDR para o endereço especificado em EEARL.
	ret                      ; Retorna da sub-rotina após iniciar a gravação.

; ### Sub-rotina para leitura na EEPROM ###
eeprom_read:                
	sbic EECR,EEPE           ; Verifica se o bit EEPE no registrador EECR está limpo (0).
	                         ; Isso garante que nenhuma operação de gravação esteja em progresso.
	rjmp eeprom_read         ; Se EEPE estiver definido (1), salta de volta para eeprom_read para esperar.
	out EEARL,eeprom_address ; Especifica o endereço na EEPROM a ser lido.
	                         ; O valor de eeprom_address (r23) é movido para o registrador EEARL.
	sbi EECR,EERE            ; Define o bit EERE no registrador EECR para iniciar a leitura.
	                         ; O valor armazenado na EEPROM no endereço EEARL é transferido para o registrador EEDR.
	in eeprom_number,EEDR    ; Move o valor lido de EEDR para eeprom_number (r22).
	                         ; Agora o dado da EEPROM está armazenado no registrador eeprom_number.
	ret                      ; Retorna da sub-rotina após concluir a leitura.

```

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
      ldi eeprom_address,0   ;  define o endereço da memoria
      rcall eeprom_read      ;  chama a leitura e faz a leitura no endereço
      mov caixas,eeprom_number   ; o valor é recuperado em eeprom_number
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

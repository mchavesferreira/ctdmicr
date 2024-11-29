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

## Exemplo de uso da memória eeprom

A EEPROM é utilizada para armazenar o valor atual de caixas. Sempre que o valor de caixas é incrementado no loop principal, ele é escrito na EEPROM. Se ocorrer a condição de alarme (caixas = 12), o valor armazenado na EEPROM é resetado para 0.

O código  armazena e gerencia valores na EEPROM de forma persistente, ou seja, não volátil.

```ruby
.equ SP1 = pb0              ; Define o nome SP1 para representar o pino PB0.
.equ AL = pb4               ; Define o nome AL para representar o pino PB4 (provavelmente usado para um alarme).
.equ M1 = pb5               ; Define o nome M1 para representar o pino PB5 (provavelmente usado para controlar um motor).

.def caixas = r0            ; Define o registrador `r0` como o registrador usado para armazenar o valor "caixas".

; Reset Vector
rjmp Start                  ; Após um reset, o código pula para a label `Start`.

.include "lib328Pv01.inc"   ; Inclui a biblioteca ou cabeçalho com definições específicas do microcontrolador ATmega328P.

Start:
    ; Configuração inicial
    cbi ddrb,0              ; Configura o pino PB0 como entrada.
    sbi portb,0             ; Ativa o pull-up interno no pino PB0.
    sbi ddrb,4              ; Configura o pino PB4 como saída (possivelmente para o alarme).
    sbi ddrb,5              ; Configura o pino PB5 como saída (possivelmente para o motor).

    ; Leitura inicial da EEPROM
    ldi eeprom_address,0    ; Carrega o endereço 0 no registrador `eeprom_address`.
    rcall eeprom_read       ; Chama a sub-rotina `eeprom_read` para ler o valor armazenado na EEPROM no endereço 0.
    mov caixas,eeprom_number ; Move o valor lido da EEPROM para o registrador `caixas`.
    mov display_number,caixas ; Copia o valor de `caixas` para `display_number` (usado para exibir o valor no display).
    rcall display_write     ; Atualiza o display com o valor inicial de `caixas`.

Loop:
    ; Controle do motor e do alarme
    sbi portb,M1            ; Ativa o motor (sinal no pino PB5).
    cbi portb,AL            ; Desativa o alarme (sinal no pino PB4).

    ; Aguarda o acionamento do SP1
SP1ON:
    sbic pinb,SP1           ; Verifica se o pino PB0 (SP1) está baixo. Se não estiver, pula a próxima instrução.
    rjmp SP1ON              ; Se SP1 não foi acionado, continua verificando.

    ; Aguarda o desligamento do SP1
SP1OFF:
    sbis pinb,SP1           ; Verifica se o pino PB0 (SP1) está alto. Se não estiver, pula a próxima instrução.
    rjmp SP1OFF             ; Se SP1 ainda está acionado, continua verificando.

    ; Incrementa o valor de caixas e atualiza a EEPROM
    inc caixas              ; Incrementa o valor armazenado em `caixas`.
    mov display_number,caixas ; Move o valor incrementado para `display_number` para exibição.
    rcall display_write     ; Atualiza o display com o novo valor de `caixas`.
    mov eeprom_number,caixas ; Move o novo valor de `caixas` para `eeprom_number`.
    rcall eeprom_write      ; Chama a sub-rotina `eeprom_write` para salvar o valor atualizado na EEPROM.

    ; Verificação de alarme
    ldi aux,12              ; Carrega o valor 12 no registrador `aux`.
    eor aux,caixas          ; Compara `caixas` com 12 usando XOR. O resultado será 0 se forem iguais.
    breq ALERTA             ; Se `aux` for zero (caixas == 12), pula para a label `ALERTA`.
    rjmp Loop               ; Retorna ao início do loop.

ALERTA:
    ; Ativação do alarme
    cbi portb,M1            ; Desativa o motor (sinal no pino PB5).
    sbi portb,AL            ; Ativa o alarme (sinal no pino PB4).
    ldi eeprom_number,0     ; Prepara para gravar o valor 0 na EEPROM.
    rcall eeprom_write      ; Grava o valor 0 na EEPROM no endereço especificado.

    ; Sinalização do alarme com atraso
    ldi delay_time,1        ; Configura o atraso de 1 segundo.
    rcall delay_seconds     ; Aguarda 1 segundo.
    cbi portb,AL            ; Desativa o alarme.
    ldi delay_time,1        ; Configura outro atraso de 1 segundo.
    rcall delay_seconds     ; Aguarda mais 1 segundo.
    rjmp ALERTA             ; Retorna para o início do alarme (loop infinito).



```

# Microprocessadores 

## Introdução


## Montando um processador de 8 bits em protoboard

https://www.youtube.com/watch?v=pcL8EIsQNwk&list=PLZ8dBTV2_5HTB43Mhfz-TyIATkECrp8XY&index=2

## Microprocessador Z80

<img src=https://terremoth.github.io/z80-simulator/assets/z80-1.jpg>


# Relação dos Pinos do Processador Z80

## Alimentação e Clock

- **VCC**: Fornece a tensão de alimentação ao processador (geralmente +5V).
- **GND**: Conexão ao terra, completando o circuito elétrico.
- **CLK (Clock)**: Entrada de sinal de clock que sincroniza as operações do processador. Cada ciclo de clock corresponde a um passo nas operações do Z80.

## Barramento de Endereços e Dados

- **A0-A15 (Address Bus)**: Barramento de endereços de 16 bits. Estes pinos são usados para selecionar os locais de memória ou dispositivos de I/O que o Z80 acessará.
- **D0-D7 (Data Bus)**: Barramento de dados de 8 bits. Utilizado para transferência bidirecional de dados entre o processador e os dispositivos conectados.

## Controle de Memória e I/O

- **MREQ (Memory Request)**: Ativo quando o Z80 está acessando a memória.
- **IORQ (I/O Request)**: Indica que o processador está acessando um dispositivo de I/O.
- **RD (Read)**: Sinal utilizado para ler dados da memória ou I/O.
- **WR (Write)**: Sinal utilizado para gravar dados na memória ou I/O.
- **M1 (Machine Cycle One)**: Ativo durante o primeiro ciclo de máquina de uma instrução, geralmente para buscar a operação de instrução.

## Controle do Sistema

- **RESET**: Reseta o processador, colocando-o em seu estado inicial e reiniciando a execução a partir de um endereço específico.
- **HALT**: Indica que o processador está em um estado de espera, aguardando uma interrupção.
- **WAIT**: Indica ao Z80 que o dispositivo periférico não está pronto para a comunicação, fazendo o processador esperar.
- **INT (Interrupt Request)**: Usado por dispositivos externos para solicitar a interrupção do processador.
- **NMI (Non-Maskable Interrupt)**: Um sinal de interrupção que não pode ser ignorado pelo processador, usado para condições críticas.
- **BUSREQ (Bus Request)**: Solicita ao processador a liberação do barramento de endereços e dados.
- **BUSACK (Bus Acknowledge)**: Indica que o processador liberou o barramento.
- **RFSH (Refresh)**: Sinal usado para indicar que o processador está realizando um ciclo de refresh de memória dinâmica.

## Barramento de Controle

- **WAIT**: Indica que um dispositivo não está pronto, fazendo o Z80 esperar antes de continuar.
- **NMI (Non-Maskable Interrupt)**: Sinal de interrupção não mascarável que força o Z80 a atender a interrupção imediatamente.
- **INT (Interrupt)**: Solicitação de interrupção mascarável, que pode ser ignorada dependendo da configuração do processador.
- **BUSREQ (Bus Request)**: Solicitação para liberar os barramentos de dados e endereço.
- **BUSACK (Bus Acknowledge)**: Resposta do Z80 indicando que liberou os barramentos.

## Outros

- **RFSH (Refresh)**: Usado para atualizar a memória dinâmica (DRAM).
- **WAIT**: Informa ao Z80 que um dispositivo está ocupado e o processador deve esperar.
- **HALT**: Indica que o processador entrou em modo de espera.
- **RESET**: Reinicia o processador.


# Processador Z80: Características Principais

O Zilog Z80 é um microprocessador de 8 bits lançado em 1976, amplamente utilizado em computadores pessoais, sistemas embarcados e videogames das décadas de 1970 e 1980. Foi projetado como uma evolução do Intel 8080, oferecendo compatibilidade com seu conjunto de instruções e introduzindo melhorias significativas em termos de funcionalidade e eficiência.

## Características Principais

- **Arquitetura de 8 bits**: O Z80 opera com dados de 8 bits, podendo endereçar até 64KB de memória através de seu barramento de endereços de 16 bits.

- **Barramento de Endereços de 16 bits**: Permite acessar diretamente até 64KB de memória, que era o espaço máximo de endereçamento em muitos sistemas da época.

- **Instruções**: Suporta mais de 150 instruções diferentes, incluindo operações aritméticas, lógicas, de controle e manipulação de dados, além de um conjunto expandido em relação ao 8080.

- **Registros**:
  - **Registros Gerais**: O Z80 possui seis registros de 8 bits (B, C, D, E, H, L) que podem ser combinados em três registros de 16 bits (BC, DE, HL).
  - **Registros de Propósito Específico**: Inclui o acumulador (A) e o registrador de flags (F), além de dois pares de registros (IX/IY) usados para operações de indexação.
  - **Ponteiro de Pilha (SP)**: Gerencia a pilha na memória.
  - **Contador de Programa (PC)**: Aponta para a próxima instrução a ser executada.

- **Interrupções**: Suporta múltiplos modos de interrupção, incluindo interrupções mascaráveis e não-mascaráveis, oferecendo flexibilidade no gerenciamento de eventos externos.

- **Ciclos de Máquina**: O Z80 pode executar instruções em um número variável de ciclos de máquina, com operações mais simples executando em poucos ciclos, aumentando a eficiência.

- **Ciclo de Refresh**: Integra um ciclo automático de refresh de memória, crucial para o suporte a DRAMs.

## Conjunto de Instruções

O conjunto de instruções do Z80 é um dos seus pontos mais fortes, oferecendo uma grande variedade de operações:

- **Operações Aritméticas e Lógicas**:
  - **ADD, ADC, SUB**: Operações de adição e subtração.
  - **AND, OR, XOR**: Operações lógicas.
  - **INC, DEC**: Incremento e decremento de registros.

- **Transferência de Dados**:
  - **LD**: Carrega dados entre registros, memória e I/O.
  - **EX**: Troca o conteúdo de dois registradores.
  - **PUSH, POP**: Operações com a pilha.

- **Controle de Fluxo**:
  - **JP, JR**: Saltos incondicionais e condicionais.
  - **CALL, RET**: Chamadas e retornos de subrotinas.
  - **RST**: Reinício de rotina em um endereço fixo.

- **Manipulação de Bits**:
  - **BIT, SET, RES**: Verifica, seta e reseta bits individuais.

- **Operações de I/O**:
  - **IN, OUT**: Entrada e saída de dados de dispositivos periféricos.

- **Instruções de Indexação e Deslocamento**:
  - **INX, DEX**: Incremento e decremento de registradores de índice.
  - **RL, RR**: Rotações de bits, utilizadas em operações mais complexas.

- **Instruções de Controle**:
  - **NOP**: Não faz nada, usado para sincronização.
  - **HALT**: Coloca o processador em estado de espera.



https://ps4star.github.io/z80studio/

https://ignaciosearles.github.io/Z80-AssemblerAndEmulator/


https://marmsx.msxall.com/cursos/assembly/assembly4.html


https://terremoth.github.io/z80-simulator/



IDE
https://www.oshonsoft.com/downloads.php

Simuladores online

Simulador CPU-VSIM
https://www.merlot.org/merlot/viewMaterial.htm?id=773407108



https://cpulator.01xz.net/?sys=mipsr6
Instruçoes:
https://cpuvisualsimulator.github.io/manual



https://www.101computing.net/LMC/#


Enigma
https://www.101computing.net/enigma-machine-emulator/



Link Materiais
https://download.file-hunter.com/Books/PT/


https://chatgpt.com/g/g-ndeyJ4Bo3-fluxcore-z80


http://www.z80.info/z80-op.txt



Tk 85   layout
https://ekaww4.wixsite.com/tecnologia/post/projeto-7-tk-85-microdigital-%C3%BAltimo-projeto-de-2019



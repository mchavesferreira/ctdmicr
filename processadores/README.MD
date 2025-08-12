
# Processador Z80



## Computadores com Z80

Exemplo Z80 - https://www.8bity.cz/files/zx80_schema.pdf


## Montando um processador de 8 bits em protoboard

https://www.youtube.com/watch?v=pcL8EIsQNwk&list=PLZ8dBTV2_5HTB43Mhfz-TyIATkECrp8XY&index=2

## Microprocessador Z80

<img src=https://terremoth.github.io/z80-simulator/assets/z80-1.jpg>


## Relação dos Pinos do Processador Z80

### Alimentação e Clock

- **VCC**: Fornece a tensão de alimentação ao processador (geralmente +5V).
- **GND**: Conexão ao terra, completando o circuito elétrico.
- **CLK (Clock)**: Entrada de sinal de clock que sincroniza as operações do processador. Cada ciclo de clock corresponde a um passo nas operações do Z80.

### Barramento de Endereços e Dados

- **A0-A15 (Address Bus)**: Barramento de endereços de 16 bits. Estes pinos são usados para selecionar os locais de memória ou dispositivos de I/O que o Z80 acessará.
- **D0-D7 (Data Bus)**: Barramento de dados de 8 bits. Utilizado para transferência bidirecional de dados entre o processador e os dispositivos conectados.

### Controle de Memória e I/O

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

### Barramento de Controle

- **WAIT**: Indica que um dispositivo não está pronto, fazendo o Z80 esperar antes de continuar.
- **NMI (Non-Maskable Interrupt)**: Sinal de interrupção não mascarável que força o Z80 a atender a interrupção imediatamente.
- **INT (Interrupt)**: Solicitação de interrupção mascarável, que pode ser ignorada dependendo da configuração do processador.
- **BUSREQ (Bus Request)**: Solicitação para liberar os barramentos de dados e endereço.
- **BUSACK (Bus Acknowledge)**: Resposta do Z80 indicando que liberou os barramentos.

### Outros

- **RFSH (Refresh)**: Usado para atualizar a memória dinâmica (DRAM).
- **WAIT**: Informa ao Z80 que um dispositivo está ocupado e o processador deve esperar.
- **HALT**: Indica que o processador entrou em modo de espera.
- **RESET**: Reinicia o processador.


## Processador Z80: Características Principais

O Zilog Z80 é um microprocessador de 8 bits lançado em 1976, amplamente utilizado em computadores pessoais, sistemas embarcados e videogames das décadas de 1970 e 1980. Foi projetado como uma evolução do Intel 8080, oferecendo compatibilidade com seu conjunto de instruções e introduzindo melhorias significativas em termos de funcionalidade e eficiência.

### Características Principais

<img src=https://raw.githubusercontent.com/mchavesferreira/mice/main/processadores/ass04.gif>

- **Arquitetura de 8 bits**: O Z80 opera com dados de 8 bits, podendo endereçar até 64KB de memória através de seu barramento de endereços de 16 bits.

- **Barramento de Endereços de 16 bits**: Permite acessar diretamente até 64KB de memória, que era o espaço máximo de endereçamento em muitos sistemas da época.

- **Instruções**: Suporta mais de 150 instruções diferentes, incluindo operações aritméticas, lógicas, de controle e manipulação de dados, além de um conjunto expandido em relação ao 8080.

- **Registros**:
  - **Registros Gerais**: O Z80 possui seis registros de 8 bits (B, C, D, E, H, L) que podem ser combinados em três registros de 16 bits (BC, DE, HL).
  - **Registros de Propósito Específico**: Inclui o acumulador (A) e o registrador de flags (F), além de dois pares de registros (IX/IY) usados para operações de indexação.
  - **Ponteiro de Pilha (SP)**: Gerencia a pilha na memória.
  - **Contador de Programa (PC)**: Aponta para a próxima instrução a ser executada.

<a href=https://github.com/IgnacioSearles/Z80-AssemblerAndEmulator/blob/master/Z80%20Instructions.pdf>Registradores do Z80</a>


- **Interrupções**: Suporta múltiplos modos de interrupção, incluindo interrupções mascaráveis e não-mascaráveis, oferecendo flexibilidade no gerenciamento de eventos externos.

- **Ciclos de Máquina**: O Z80 pode executar instruções em um número variável de ciclos de máquina, com operações mais simples executando em poucos ciclos, aumentando a eficiência.

- **Ciclo de Refresh**: Integra um ciclo automático de refresh de memória, crucial para o suporte a DRAMs.

## Conjunto de Instruções

<a href=https://github.com/mchavesferreira/mice/blob/main/processadores/Z80.pdf>resumo das instruções</a>

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

## Abra o simulador


https://ignaciosearles.github.io/Z80-AssemblerAndEmulator/


Copie o seguinte codigo


```java
org 10
start:
ld B, 0
ld D, 17         
ld E, 15                 
loop:
INC D                              
inc D                   
CP 10
JR z,fim
jr loop
fim:
LD B, 0

```

### IDE

https://www.oshonsoft.com/downloads.php

## Simuladores online

### Simulador CPU-VSIM

https://www.merlot.org/merlot/viewMaterial.htm?id=773407108

https://cpulator.01xz.net/?sys=mipsr6

### Instruçoes:

https://cpuvisualsimulator.github.io/manual

https://www.101computing.net/LMC/#

# Exercícios na prática 12/0/2025 

Apostila sobre Z80 Português  > https://github.com/mchavesferreira/ctdmicr/blob/main/processadores/z80a.pdf

## Enigma
https://www.101computing.net/enigma-machine-emulator/



Link Materiais

https://download.file-hunter.com/Books/PT/


https://chatgpt.com/g/g-ndeyJ4Bo3-fluxcore-z80


http://www.z80.info/z80-op.txt

# Computador Apolo 11

1960- https://en.wikipedia.org/wiki/Honeywell_800


1964  - IBM 360

https://dodlithr.blogspot.com/2011/10/apollo-guidance-computer-agc-software.html

https://en.wikipedia.org/wiki/IBM_System/360


## Apolo 11 1969

http://www.righto.com/2019/09/a-computer-built-from-nor-gates-inside.html

## Vídeo com AGC da Apolo 11

https://www.youtube.com/watch?v=2KSahAoOLdU&list=PL-_93BVApb59FWrLZfdlisi_x7-Ut_-w7

## Construção:

https://apollo11space.com/apollo-guidance-computer-agc/

## A memória

Construção Manual da Memória (Core Rope Memory)
O AGC tinha cerca de 72 kilobytes de memória disponível, 



## Tk 85   layout
https://ekaww4.wixsite.com/tecnologia/post/projeto-7-tk-85-microdigital-%C3%BAltimo-projeto-de-2019



## Core X ALU

### em estudo de microprocessadores, podemos afirmar que core seria equivalente ao numero de  ALU?


Não, o número de cores de um processador não é diretamente equivalente ao número de ALUs (Unidades Lógicas e Aritméticas). Embora exista uma relação entre cores e ALUs, são conceitos distintos.
Explicação dos Termos:

    Core (núcleo): Um core é uma unidade independente de processamento em um microprocessador moderno, capaz de executar suas próprias instruções. Cada core tem seus próprios componentes, como unidades de controle, cache, e pode conter uma ou mais ALUs. Um processador multicore possui vários núcleos, permitindo a execução paralela de várias tarefas (multithreading ou multitasking).

    ALU (Arithmetic Logic Unit): A ALU é um componente dentro de um core que realiza operações aritméticas (como adição, subtração) e lógicas (como AND, OR, NOT). Um core pode ter uma ou mais ALUs, dependendo do design da arquitetura. A ALU é essencialmente a parte "matemática" do core, mas o core também inclui outras unidades, como as de controle e de acesso à memória.

Diferença entre Cores e ALUs:

    Core: Refere-se a uma unidade de processamento completa, capaz de buscar, decodificar, executar instruções e interagir com a memória e outros componentes.
    ALU: É um componente dentro de um core. Um único core pode conter mais de uma ALU para melhorar o desempenho ao permitir que várias operações matemáticas sejam realizadas simultaneamente.

Exemplo em Processadores Modernos:

Nos processadores modernos, como os da série Intel Core ou AMD Ryzen, um core pode ter várias ALUs. Além disso, muitos processadores também possuem unidades vetoriais (como as unidades SIMD) e FPUs (Unidades de Ponto Flutuante), que realizam operações matemáticas mais complexas.

Portanto, afirmar que o número de cores é equivalente ao número de ALUs não está correto. Um processador com múltiplos cores pode ter múltiplas ALUs por core, mas as duas métricas (cores e ALUs) são diferentes e tratam de aspectos distintos da arquitetura do processador.

# Thread

Um thread é uma unidade de execução de um programa ou processo. Em termos simples, é o caminho que o código percorre durante sua execução.

Em processadores modernos, como os da Intel e AMD, um core pode processar vários threads simultaneamente usando uma tecnologia chamada hyper-threading (Intel) ou simultaneous multithreading (SMT) (AMD).

Cada core pode gerenciar um ou mais threads. Por exemplo, se um processador tem 4 núcleos e suporta hyper-threading, ele pode executar 8 threads simultaneamente (2 threads por núcleo).

Um thread pode acessar recursos como a ALU, mas um thread não é equivalente a uma ALU; é apenas um caminho de execução.

O primeiro processador a implementar a tecnologia de hyper-threading foi o Intel Pentium 4 da série Northwood, lançado em 2002. Este processador marcou o início da aplicação comercial de multithreading simultâneo (SMT), onde um único núcleo físico era capaz de executar dois threads simultaneamente.

# Explicação da Imagem: Estrutura de Processador Hyper-Threading

<img src=https://upload.wikimedia.org/wikipedia/commons/2/27/Hyper-threaded_CPU.png>

A imagem ilustra a arquitetura de um processador com **hyper-threading**, com foco em como um único núcleo físico pode executar múltiplas threads simultaneamente.

## Componentes da Imagem

### 1. Threads (Parte Superior)
- Representadas por blocos coloridos.
- Cada bloco simboliza uma **thread**, ou seja, uma sequência de instruções que o processador deve executar.
- Em processadores com **hyper-threading**, várias threads podem ser processadas por um único núcleo.

### 2. Front End (Parte Intermediária)
- O **front end** organiza e decodifica as instruções das threads antes de enviá-las para a execução.
- Aqui, as threads são preparadas para serem distribuídas entre as unidades de execução do núcleo.

### 3. Execution Core (Parte Inferior)
- A seção chamada **execution core** contém as unidades de execução, como as **ALUs (Arithmetic Logic Units)**, onde as instruções são processadas.
- As threads compartilham essas unidades para realizar cálculos e operações lógicas.

### 4. Fluxo de Instruções
- A seta azul indica o caminho que as threads seguem desde o front end até o execution core, demonstrando o fluxo de instruções dentro do processador.

## Interpretação Geral
- A imagem representa um processador com **um único núcleo** que suporta **hyper-threading**, permitindo que múltiplas threads sejam executadas simultaneamente, compartilhando os recursos do núcleo.


Arquiteturas:

CPU (Unidade Central de Processamento):

GPU (Unidade de Processamento Gráfico):

Arquiteturas Emergentes: TPUs, IPUs, NPUs

Arquiteturas Baseadas em FPGA (Field-Programmable Gate Arrays):


# Referências

Intel Processador
https://userpages.umbc.edu/~squire/intel_book.pdf


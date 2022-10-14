# Microcontroladores e microprocessadores 

 
## Utilizando Atmega328P para a compreensão e funcionamento de microprocessadores e microcontroladores em geral utilizando a linguagem Assembly.

## Aulas
- [Programas e Simuladores](#simulador-wokwi-e-Atmel-Studio)
- [Mapeamento de Memória](#Mapeamento-de-memória)
- [Configuração de pinos](#Configuração-de-pinos)
- [Diagrama de blocos](#Diagrama-de-blocos)
- [Sistemas de clock](#Sistemas-de-clock)
- [Sistema de Reset](#Sistema-de-Reset)
- [Projetos e Programas](#Projetos-e-Programas)

## Simulador Wokwi e Atmel Studio

<center><img src=imagens/wokwi_simulador.png></center>

Simulador <a href=https://wokwi.com/projects/341066839950885460>Atmega328P Assembly Online</a>

Teclas de atalho e tutorial para o <a href=https://docs.wokwi.com/pt-BR/guides/diagram-editor> Simulador Wokwi</a><P>

Atmel Studio:<a href=http://studio.download.atmel.com/7.0.2389/as-installer-7.0.2389-full.exe>Atmel Studio 7.0</a><BR>
  
Gravador para firmware .hex utilizando bootloader Arduino: <a href=https://github.com/mchavesferreira/smie/blob/main/hexloader.zip>Hexloader</a>
 
## Mapeamento-de-memória
 
Instruções principais para a movimentação de bytes na memória do Atmega328
<center><img src=https://raw.githubusercontent.com/mchavesferreira/smie/main/imagens/movimentacao_bits_bytes.png></center>
 
## Configuração de pinos

<center><img src=imagens/pinout_atmega328P.png></center>

## Diagrama de blocos
O Atmel® ATmega328P é um microcontrolador CMOS de 8 bits de baixa potência baseado na arquitetura RISC aprimorada AVR®. Ao executar instruções poderosas em um único ciclo de clock, o ATmega328P atinge taxas de transferência de aproximadamente 1MIPS por MHz, permitindo otimizar consumo de energia versus a velocidade de processamento.[1]
<center><img src=imagens/diagrama_blocos.png></center

O núcleo AVR® combina um rico conjunto de instruções com 32 registradores de trabalho de uso geral(GPR). Todos os 32 registradores são conectados diretamente à unidade lógica aritmética (ULA), permitindo que dois registradores independentes sejam acessados em uma única instrução executada em um ciclo de clock. A arquitetura resultante é mais eficiente em termos de código, ao mesmo tempo em que alcança rendimentos até dez vezes mais rápidos do que os microcontroladores CISC convencionais.
O Atmel® ATmega328P fornece os seguintes recursos: 32K bytes de flash programável no sistema com recursos de leitura durante a gravação, 1K bytes EEPROM, 2K bytes SRAM, 23 linhas de E/S de uso geral, 32 registradores de trabalho de uso geral, três temporizadores flexíveis /Contadores com modos de comparação, interrupções internas e externas, um USART programável serial, uma interface serial de 2 fios orientada a byte, uma porta serial SPI, um ADC de 6 canais e 10 bits (8 canais em pacotes TQFP e QFN/MLF) , um temporizador de watchdog programável com oscilador interno e cinco modos de economia de energia selecionáveis por software. O modo ocioso para a CPU enquanto permite que a SRAM, Temporizador/Contadores, USART, interface serial de 2 fios, porta SPI e sistema de interrupção continuem funcionando. O modo de desligamento salva o conteúdo do registro, mas congela o oscilador, desabilitando todas as outras funções do chip até a próxima interrupção ou reinicialização do hardware. No modo de economia de energia, o temporizador assíncrono continua a funcionar, permitindo que o usuário mantenha uma base de temporizador enquanto o restante do dispositivo está dormindo. O modo de redução de ruído ADC para a CPU e todos os módulos de E/S, exceto temporizador assíncrono e ADC, para minimizar o ruído de comutação durante as conversões ADC. No modo de espera, o oscilador de cristal/ressonador está funcionando enquanto o restante do dispositivo está dormindo. Isto permite um arranque muito rápido combinado com um baixo consumo de energia.[1]


Core CPU
A principal função do núcleo da CPU (core CPU) é garantir a execução correta do programa. A CPU deve, portanto, ser capaz de acessar memórias, realizar cálculos, controlar periféricos e lidar com interrupções.

<center><img src=imagens/core_cpu.png></center
Diagrama de Blocos da Arquitetura AVR

Para maximizar o desempenho e o paralelismo, o AVR usa uma arquitetura harvard – com memórias e barramentos separados para programa e dados. As instruções na memória do programa são executadas com um pipelining de nível único. Enquanto uma instrução está sendo executada, a próxima instrução é pré-buscada na memória do programa. Este conceito permite que as instruções sejam executadas em cada ciclo de clock. A memória do programa é uma memória flash reprogramável no sistema.[1]

## Sistemas de clock

Principais sistemas de clock do AVR® e sua distribuição. Todos os clock não precisam estar ativos em um determinado momento. Para reduzir o consumo de energia, os relógios dos módulos que não estão sendo usados podem ser interrompidos usando diferentes modos de suspensão, conforme descrito na Seção "Modes Sleep Gerenciamento de energia e modos de suspensão". 
<center><img src=imagens/distribuicaoclock_f_8_1.png></center>
Para maximizar o desempenho e o paralelismo, o AVR usa uma arquitetura harvard – com memórias e barramentos separados para programa e dados. As instruções na memória do programa são executadas com um pipelining de nível único. Enquanto uma instrução está sendo executada, a próxima instrução é pré-buscada na memória do programa. Este conceito permite que as instruções sejam executadas em cada ciclo de clock. A memória do programa é uma memória flash reprogramável no sistema.[1]

## Sistema de Reset

<center><img src=imagens/sistema_reset.png>Lógica Reset</center>

Durante o reset, todos os registradores de E/S são ajustados para seus valores iniciais, e o programa inicia a execução a partir do vetor de reset. Para o Atmel® ATmega328P, a instrução colocada no vetor de reset deve ser uma instrução RJMP – salto relativo – para a rotina de manipulação de reset. Se o programa nunca habilita uma fonte de interrupção, os vetores de interrupção não são usados e o código de programa regular pode ocupar nesses locais. Este também é o caso se o vetor de reset estiver na seção de aplicação enquanto os vetores de interrupção estiverem na seção de inicialização. As portas de E/S do AVR® são imediatamente redefinidas para seu estado inicial quando uma fonte de redefinição fica ativa. Isso não requer que nenhuma fonte de relógio esteja em execução. Após todas as fontes de reset ficarem inativas, um contador de atraso é invocado, estendendo o reset interno. Isso permite que a potência atinja um nível estável antes do início da operação normal. O tempo limite do contador de atraso é definido pelo usuário através dos fusíveis SUT e CKSEL. 

 
## Programas-Assembly
 
Exemplos de programas Assembly

01 - <a href=https://wokwi.com/projects/341066839950885460> Pisca Led</a><br>
 

<BR> Exemplo Maquina de Lavar
<br><a href=https://github.com/mchavesferreira/smie/tree/main/exemplo_5_LCD_maquina_lavar><img src=imagens/maquinadelavar.png border=0>
<BR> <a href=https://github.com/mchavesferreira/smie/tree/main/exemplo_5_LCD_maquina_lavar>Maquina de lavar </a> - Código AVR assembly
<br><a href=https://wokwi.com/projects/341106129478091346>Simulação Maquina de lavar</a> (woki)

Referências:
[1] Atmega 328P 8-bit AVR Microcontroller with 32K Bytes In-System Programmable Flash - Datasheet

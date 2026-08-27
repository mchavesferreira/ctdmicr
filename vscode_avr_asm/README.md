


Seguindo tutorial disponivel no vídeo:  https://www.youtube.com/watch?v=BM-w1pcekxA&t=610s


Acesse o repositorio https://gitlab.com/jjchico-edc/avr-pio-template


Clone ou baixe o .zip deste repositorio em seu computador

modifique o platformio.ino para

[env:uno]
platform = atmelavr
board = uno
;framework = arduino
; Use the simulator for debugging
debug_tool = simavr
; Use this file for peripheral definitions, that will be shown by the debugger.
debug_svd_path = atmega328p.svd



 copie o arquivo para atmega328p.svd para  pasta onde esta seu projeto

 muda o nome do arquivo /src/main.c para main.S

 

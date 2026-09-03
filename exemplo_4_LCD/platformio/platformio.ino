; PlatformIO Project Configuration File
;
;   Build options: build flags, source filter
;   Upload options: custom upload port, speed and extra flags
;   Library options: dependencies, extra library storages
;   Advanced options: extra scripting
;
; Please visit documentation for the other options and examples
; https://docs.platformio.org/page/projectconf.html

[env:uno]
platform = atmelavr
board = uno
;framework = arduino
; Use the simulator for debugging
debug_tool = simavr
; Use this file for peripheral definitions, that will be shown by the debugger.
debug_svd_path = atmega328p.svd

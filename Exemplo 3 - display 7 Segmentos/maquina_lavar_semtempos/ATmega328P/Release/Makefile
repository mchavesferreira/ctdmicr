###############################################################################
# Makefile for project 
###############################################################################

## General options
PROJECT = 
MCU = ATmega328P
COMPILER = "AVRASM (Proteus)"
TARGET = Release
SHELL = C:\WINDOWS\system32\cmd.exe

## Tools general options
ASMFLAGS=-fI -i"C:\Program Files (x86)\Labcenter Electronics\Proteus 8 Professional\Tools\AVRASM\appnotes\m328Pdef.inc" -i"C:\Program Files (x86)\Labcenter Electronics\Proteus 8 Professional\Tools\AVRASM\appnotes\m328Pdef.inc"

## Processing Tools
ASM=avrasm2.exe
#  H:/OneDrive - ifsp.edu.br/ifsp aulas/2021-1/mcr/Assembly códigos/exemplo_4_LCD/ATmega328P/Release/Release.hex: TOOL=ASM
#     H:/OneDrive - ifsp.edu.br/ifsp aulas/2021-1/mcr/Assembly códigos/exemplo_4_LCD/ATmega328P/main.asm

# Build tree:
all:	Release

Release:	Release.hex
	cp "Release.hex" "H:/OneDrive - ifsp.edu.br/ifsp aulas/2021-1/mcr/Assembly códigos/exemplo_4_LCD/ATmega328P.hex"

Release.hex:	../main.asm 
	$(ASM) $(ASMFLAGS)  -o "Release.hex" -l Release.lst "..\main.asm"

# tidy - delete all temporary files which are not involved in the target generation
tidy:
	rm -rf Release.lst

# cleanup - delete all generated files
clean:	tidy
	rm -rf Release.hex

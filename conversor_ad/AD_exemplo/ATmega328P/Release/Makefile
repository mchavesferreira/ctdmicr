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
ASMFLAGS=-fI -i"C:\Program Files (x86)\Labcenter Electronics\Proteus 8 Professional\Tools\AVRASM\appnotes\m328Pdef.inc"

## Processing Tools
ASM=avrasm2.exe
#  I:/Programas/LCD_4bits/exemplo_AD/exemplo_AD/ATmega328P/Release/Release.hex: TOOL=ASM

# Build tree:
all:	Release

Release:	Release.hex
	cp "Release.hex" "I:/Programas/LCD_4bits/exemplo_AD/exemplo_AD/ATmega328P.hex"

Release.hex:	
	$(ASM) $(ASMFLAGS)  -o "Release.hex" -l Release.lst %INFILE_DOS_QUOTED%

# tidy - delete all temporary files which are not involved in the target generation
tidy:
	rm -rf Release.lst

# cleanup - delete all generated files
clean:	tidy

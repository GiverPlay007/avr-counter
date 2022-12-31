@echo off
set OUT=build\out
set CHIP_INC=C:\Program Files\Microchip\MPLABX\v6.05\packs\Microchip\ATmega_DFP\3.0.158\avrasm\inc

if not exist "build" (
  mkdir build
)

avrasm2 -fI -W+ie -I "%CHIP_INC%" -i m328Pdef.inc -d %OUT%.obj -S %OUT%.tmp -o %OUT%.hex -m %OUT%.map -l %OUT%.lss main.asm
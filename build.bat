@echo off
set OUT=build\out
set CHIP_INC=%ARDUINO%\MPLABX\v5.50\packs\Microchip\ATmega_DFP\2.3.126\avrasm\inc

if not exist "build" (
  mkdir build
)

avrasm2 -fI -W+ie -I "%CHIP_INC%" -i m328Pdef.inc -d %OUT%.obj -S %OUT%.tmp -o %OUT%.hex -m %OUT%.map -l %OUT%.lss main.asm
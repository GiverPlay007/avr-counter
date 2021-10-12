.ORG 0X0

.EQU DIG_0 = 0b01111110
.EQU DIG_1 = 0b00110000
.EQU DIG_2 = 0b01101101
.EQU DIG_3 = 0b01111001
.EQU DIG_4 = 0b00110011
.EQU DIG_5 = 0b01011011
.EQU DIG_6 = 0b01011111
.EQU DIG_7 = 0b01110000
.EQU DIG_8 = 0b01111111
.EQU DIG_9 = 0b01111011


BEGIN:

  LDI R16,   0b11111111
  OUT DDRD,  R16

  LDI R16,   0X0
  OUT PORTD, R16

  LDI R16,   0b0
  OUT DDRB,  R16

  LDI R21,   0x0

LOOP:
  
  SBIS  PINB, PB2
  RCALL INCREMENT
  
  RCALL COMPARE
  OUT   PORTD, R21
  
  RJMP  LOOP

INCREMENT:

  INC  R20
  LDI  R16, 10
  CPSE R20, R16
  RJMP RET_INC
  RJMP RES_INC
RES_INC:
  LDI  R20, 0x0
RET_INC:
  RET

COMPARE:
  
  LDI  R16, DIG_0
  CPI  R20, 0
  BREQ RETURN

  LDI  R16, DIG_1
  CPI  R20, 1
  BREQ RETURN

  LDI  R16, DIG_2
  CPI  R20, 2
  BREQ RETURN

  LDI  R16, DIG_3
  CPI  R20, 3
  BREQ RETURN

  LDI  R16, DIG_4
  CPI  R20, 4
  BREQ RETURN

  LDI  R16, DIG_5
  CPI  R20, 5
  BREQ RETURN

  LDI  R16, DIG_6
  CPI  R20, 6
  BREQ RETURN

  LDI  R16, DIG_7
  CPI  R20, 7
  BREQ RETURN

  LDI  R16, DIG_8
  CPI  R20, 8
  BREQ RETURN

  LDI  R16, DIG_9
  CPI  R20, 9
  BREQ RETURN
RETURN:
  MOV  R21, R16
  RET
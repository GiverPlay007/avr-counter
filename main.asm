.ORG 0X0

.EQU DIG_0 = 0b00111111
.EQU DIG_1 = 0b00000110
.EQU DIG_2 = 0b01011011
.EQU DIG_3 = 0b01001111
.EQU DIG_4 = 0b01100110
.EQU DIG_5 = 0b01101101
.EQU DIG_6 = 0b01111101
.EQU DIG_7 = 0b00000111
.EQU DIG_8 = 0b01111111
.EQU DIG_9 = 0b01101111


BEGIN:

  LDI R16,   0b11111111
  OUT DDRD,  R16

  LDI R16,   0x0
  OUT PORTD, R16

  LDI R16,   0b0
  OUT DDRB,  R16

  LDI R21,   0x0
  OUT PORTD, R21


LOOP:
  
  RCALL UPDATE_INC
  RCALL UPDATE_DEC
  
  RJMP  LOOP


UPDATE_INC:
  
  SBIS PINB, PB2
  RET

  RCALL INCREMENT
  RCALL COMPARE
  OUT   PORTD, R21
STAY_INC:
  SBIC PINB, PB2
  RJMP STAY_INC
  RET


UPDATE_DEC:
  
  SBIS PINB, PB1
  RET

  RCALL DECREMENT
  RCALL COMPARE
  OUT   PORTD, R21
STAY_DEC:
  SBIC PINB, PB1
  RJMP STAY_DEC
  RET


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


DECREMENT:

  LDI  R16, 0x0
  CPSE R20, R16
  RJMP RET_DEC
  RJMP RES_DEC
RES_DEC:
  LDI  R20, 9
  RET
RET_DEC:
  DEC  R20
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
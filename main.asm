.ORG 0X0

; Display digits bits
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

  LDI R16,   0b11111111  ; All pins are output
  OUT DDRD,  R16         ; Set pins as output

  LDI R16,   0x0         ; Clear all bits
  OUT PORTD, R16         ; Clear all PORTD bits

  LDI R16,   0b0         ; All pins are input
  OUT DDRB,  R16         ; Set pins as input

  LDI R21,   0x0         ; Set counter to 0
  OUT PORTD, R21         ; Apply the display digit


LOOP:
  
  RCALL UPDATE_INC
  RCALL UPDATE_DEC
  
  RJMP  LOOP        ; Repeat infinitely


UPDATE_INC:
  
  SBIS PINB, PB2    ; End increment subroutine if increment the button is not pressed
  RET

  RCALL INCREMENT   ; Call the increment subroutine
  RCALL COMPARE     ; Set the display digit
  OUT   PORTD, R21  ; Apply the display digit
STAY_INC:
  SBIC PINB, PB2
  RJMP STAY_INC     ; Stay while the increment button is pressed
  RET


UPDATE_DEC:
  
  SBIS PINB, PB1    ; End decrement subroutine if the decrement button is not pressed
  RET

  RCALL DECREMENT   ; Call the decrement subrountine
  RCALL COMPARE     ; Set the display digit
  OUT   PORTD, R21  ; Apply the display digit
STAY_DEC:
  SBIC PINB, PB1
  RJMP STAY_DEC     ; Stay while the decrement button is pressed
  RET


INCREMENT:

  INC  R20
  LDI  R16, 10   ; if (counter == 10)
  CPSE R20, R16
  RJMP RET_INC
  RJMP RES_INC
RES_INC:
  LDI  R20, 0x0  ; Set to 0 if counter is greater than 9
RET_INC:
  RET


DECREMENT:

  LDI  R16, 0x0
  CPSE R20, R16  ; if (counter == 0)
  RJMP RET_DEC
  RJMP RES_DEC
RES_DEC:
  LDI  R20, 0x9  ; Set to 9 if counter is less than 0
  RET
RET_DEC:
  DEC  R20
  RET

; Set display digit according to the counter register value
COMPARE:
  
  LDI  R16, DIG_0  ; if (counter == 0)
  CPI  R20, 0      ; digit = DIG_0
  BREQ RETURN

  LDI  R16, DIG_1  ; if (counter == 1)
  CPI  R20, 1      ; digit = DIG_1
  BREQ RETURN

  LDI  R16, DIG_2  ; if (counter == 2)
  CPI  R20, 2      ; digit = DIG_2
  BREQ RETURN

  LDI  R16, DIG_3  ; if (counter == 3)
  CPI  R20, 3      ; digit = DIG_3
  BREQ RETURN

  LDI  R16, DIG_4  ; if (counter == 4)
  CPI  R20, 4      ; digit = DIG_4
  BREQ RETURN

  LDI  R16, DIG_5  ; if (counter == 5)
  CPI  R20, 5      ; digit = DIG_5
  BREQ RETURN

  LDI  R16, DIG_6  ; if (counter == 6)
  CPI  R20, 6      ; digit = DIG_6
  BREQ RETURN

  LDI  R16, DIG_7  ; if (counter == 7)
  CPI  R20, 7      ; digit = DIG_7
  BREQ RETURN

  LDI  R16, DIG_8  ; if (counter == 8)
  CPI  R20, 8      ; digit = DIG_8
  BREQ RETURN

  LDI  R16, DIG_9  ; if (counter == 9)
  CPI  R20, 9      ; digit = DIG_9
  BREQ RETURN
; Set display digit bits
RETURN:
  MOV  R21, R16
  RET
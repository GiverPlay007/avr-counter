.ORG 0x0

; Display digits bits
DIGITS: .DB 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111

BEGIN:

  LDI R16,   0b11111111  ; All pins are output
  OUT DDRD,  R16         ; Set pins as output

  LDI R16,   0x0         ; Clear all bits
  OUT PORTD, R16         ; Clear all PORTD bits

  LDI R16,   0b0         ; All pins are input
  OUT DDRB,  R16         ; Set pins as input

  LDI   R20,   0x0       ; Set counter to 0
  RCALL LOAD_DIGIT
  OUT   PORTD, R21       ; Apply the display digit


LOOP:
  
  RCALL UPDATE_INC
  RCALL UPDATE_DEC
  
  RJMP  LOOP        ; Repeat infinitely


UPDATE_INC:
  
  SBIS  PINB, PB2   ; End increment subroutine if increment the button is not pressed
  RET

  RCALL INCREMENT   ; Call the increment subroutine
  RCALL LOAD_DIGIT  ; Set the display digit
  OUT   PORTD, R21  ; Apply the display digit
STAY_INC:
  SBIC  PINB, PB2
  RJMP  STAY_INC    ; Stay while the increment button is pressed
  RET


UPDATE_DEC:
  
  SBIS  PINB, PB1   ; End decrement subroutine if the decrement button is not pressed
  RET

  RCALL DECREMENT   ; Call the decrement subrountine
  RCALL LOAD_DIGIT  ; Set the display digit
  OUT   PORTD, R21  ; Apply the display digit
STAY_DEC:
  SBIC  PINB, PB1
  RJMP  STAY_DEC     ; Stay while the decrement button is pressed
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

; Load digit bits into the display register
LOAD_DIGIT:
  LDI R30, low(DIGITS)
  LDI R31, high(DIGITS)
  ADD R30, R20
  ADC R31, R1
  LPM R21, Z
  RET

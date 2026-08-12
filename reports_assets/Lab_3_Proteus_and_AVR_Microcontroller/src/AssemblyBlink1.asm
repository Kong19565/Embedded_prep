;====================================================================
; Title: AssemblyBlink1.asm
; Created: 11/22/2013
; Author: khatathapswatdipisal
; Description: Blink all LEDs on PORTB and PORTD simultaneously
;====================================================================

.nolist
.include "m328pdef.inc"
.list

; Start at main after reset
rjmp main

main:
    ldi r16, 0xFF       ; Load 0xFF into R16 (all bits set to 1)
    out DDRB, r16       ; Configure Port B pins as Outputs
    out DDRD, r16       ; Configure Port D pins as Outputs
    ldi r16, 0x00       ; Clear R16 to 0x00

loop:
    com r16             ; Complement R16 (toggle bits between 0x00 and 0xFF)
    out PORTB, r16      ; Write R16 to Port B
    out PORTD, r16      ; Write R16 to Port D
    call MY_DELAY       ; Delay for simulation timing
    rjmp loop           ; Loop indefinitely

; Delay Subroutine
MY_DELAY:
    ldi r20, 8
L1:
    ldi r21, 200
L2:
    ldi r22, 250
L3:
    dec r22             ; Decrement R22
    brne L3             ; Loop if R22 != 0
    dec r21             ; Decrement R21
    brne L2             ; Loop if R21 != 0
    dec r20             ; Decrement R20
    brne L1             ; Loop if R20 != 0
    ret                 ; Return from subroutine

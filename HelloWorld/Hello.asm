; Hello world! for MSX
; use sjasm 0.39 to build
; MSX bios calls
CHPUT: equ #A2                     ; Displays one character
CHGET: equ #9F                     ; One character input (waiting)
CHGMOD: equ #5F                    ; Switches to given	screenmode

    org 4000h                       ; start at 4000H

    db "AB"                         ; expansion ROM header
    dw execute                      ; start of the init code, 0 if no initcode
    dw 0h
    dw 0h
    dw 0h

execute:
    call CHGMOD                     ; Select screen mode 0
    ld HL, text1                    ; HL = Character Message Address
    call print                      ; print text
    ld HL, text2
    call print
    call CHPUT
    call CHGET                      ; wait for keypress
    ret                             ; return to MSX-BASIC

print:
    ld A, (HL)                      ; A = Character
    or A                            ; A |= A
    ret Z                           ; IF (Character == Zero) return
    call CHPUT                      ; CALL System Routine To Display A Character To The Screen
    inc HL                          ; Character Message Address++
    jr print                        ; Continue Printing

text1:  db "Hello, World!"
        db 13, 10, 0
text2:  db "My name is Alexel37"
        db 13, 10, 0

    ds      (#C000-$), #FF          ; Fill space

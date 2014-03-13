    ;
    ; Title: HW7
    ; Author: Josh Gillham
    ; Class: CS2400
    ; Instructor: Dr. Zhu
    ; Description:
    ;  Reads user input in the form of hex numbers, translates them into 2's
    ; compliment binary code, and outputs the decimal value.
    ;
    AREA parse, CODE
SWI_WriteC    EQU     &0        ; Software interrupt outputs the character in r0.
SWI_Exit    EQU        &11        ; Software interrupt exits the program.
TwoComp     DCD     &0      ; Declares TwoComp as a 32 bit number 0.
; Should this be initialized to 0?
DecStr      %       12      ; Declares DecStr as to be 12 bytes.
    ALIGN
;
; Program -- Outline
; . Read 8 chars of user input.
; . Store input into memory.
; . Convert input from 2's compliment to displayable text.
; . Subproceedure devides a positive 32-bit by 10 and outputs q and r.
; . Store proceedure output into DecStr.
; . Output result to the terminal.
;
    ENTRY
    
    MOV R1, #0                      ; Set R1 to 0
    MOV R4, #0                      ; Shift amount.
    ADR R4, TwoComp                 ; Get the address of TwoComp.
LOOP
    SWI 4                           ; Call system interupt to input number.
;
; For the following we expect the input to within '0' .. '9'
; or within 'A' .. 'F'. Otherwise, the input is out of range.
;
; For the numbers 0 .. 9, whose ASCII hex values are 0x31 and 0x39.
; Check to see if the input is a number character.
; If '0' < input < '9'
    CMP R0, #&30                    ; Compare input to 0x30 or '0'.
    BLT BAD_INPUT                   ; Input is out of range.
    CMP R0, #&39                    ; Compare input to 0x39 or '9'
    BGT CHECK_LETTERS               ; Input is not a number character.
    ; Why 0x30? For ASCII '0', we want the number zero.
    ; Stated as a formula: 0x30 - x = 0x00.
    SUB R2, R0, #&30                ; Translate the ASCII into a number.
    B END_IF                        ; Go to the end of the 'if' statement.
; For the letters A .. F, whose ASCII hex values are 0x41 and 0x46.
; If &41 < input < &46
CHECK_LETTERS
    CMP R0, #&41                    ; Compare input to 0x41 or 'A'.
    BLT BAD_INPUT                   ; Input is out of range.
    CMP R0, #&46                    ; Compare input to 0x46 or 'F'.
    BGT BAD_INPUT                   ; Input is out of range.
    ; Why 0x37? For ASCII 0x41 or 'A', we want the number to be 0xA.
    ; Stated as a formula: 0x41 - x = 0x0A.
    SUB R2, R0, #&37                ; Translate the ASCII into a number.
END_IF
    
    STRB R2, [R4], #1               ; Use the R4 pointer to store the result.
    CMP R1, #8                      ; This loop will continue only 8 rounds.
    BLT LOOP                        ; Repeat while on or under 8 rounds.

;-------------------------------------------------------------------------------
; The following code has not been tested and is under construction.
    ADR R4, TwoComp
    LDR R2, [R4]
    TST R2, #&80000000              ; Test if r2 is negative.
    BEQ POSITIVE_SWITCH_SIGN        ; Skip conversion for positive numbers.

; For negative numbers, switches the sign in 2's compliment.
NEGATIVE_SWITCH_SIGN                
    SUB R2, R2, #1                  ; Subtract 1 from R3.
    MOV R7, #&000000FF
    EOR R2, R2, R7                  ; Flip every bit.
    B   RESULT_SUM                  ; Skip the other sign flip.

; For positive numbers, switches the sign in 2's compliment.
POSITIVE_SWITCH_SIGN
    MOV R7, #&FFFFFFFF
    EOR R2, R2, R7                  ; Flip every bit.
    ADD R2, R2, #1                  ; Add 1 to R3.
    
    MOV R0, R2, LSR #24
    CMP R0, #&10
    BGE PRINT_LETTERS
PRINT_NUMBERS
    ADD R0, R0, #&30                ; Change the value into a ASCII code.
PRINT_LETTERS
    ADD R0, R0, #&37                ; Change the value into a ASCII code.
    SWI SWI_WriteC
;-------------------------------------------------------------------------------

BAD_INPUT    
    SWI SWI_Exit                    ; Exit the program

    ALIGN
    END

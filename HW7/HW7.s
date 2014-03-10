;homework7
	AREA parse, CODE
SWI_WriteC	EQU 	&0	; Software interupt will write character in r0 to output
SWI_Exit	EQU	&11	; Software interupt will exit the program
TwoComp     DCD &0
DecStr      %   12
    ALIGN
; . Read 8 chars of user input.
; . Store input into memory.
; . Convert input from 2's compliment to displayable text.
; . Subproceedure devides a positive 32-bit by 10 and outputs q and r.
; . Store proceedure output into DecStr.
; . Output result to the terminal.
	ENTRY
    
    MOV R1, #0                                       ; Set R1 to 0
    MOV R4, #0                                       ; Shift amount.
    ADR R4, TwoComp                                 ; Get the address of TwoComp.
LOOP
    SWI 4                                           ; Call system interupt to input number.
; For the numbers 0 .. 9
; If &30 < input < &39

    CMP R0, #&30
    BLT CHECK_LETTERS
    CMP R0, #&39
    BGT CHECK_LETTERS
    SUB R2, R0, #&30
    B END_IF
; For the letters A .. F
; If &41 < input < &46
CHECK_LETTERS
    CMP R0, #&41
    BLT BAD_INPUT
    CMP R0, #&46
    BGT BAD_INPUT
    SUB R2, R0, #&37
END_IF
    
    STRB R2, [R4], #1                               ; Store R4 into r2
    CMP R1, #8                                       ; Compare R1 to 8.
    BLT LOOP
 
BAD_INPUT
	SWI	SWI_Exit	; Exit the program

	ALIGN
	END

;homework5
	AREA parse, CODE
SWI_WriteC	EQU 	&0	; Software interupt will write character in r0 to output
SWI_Exit	EQU	&11	; Software interupt will exit the program
city        DCD     "Greenwood Village"
sales       DCB     28,39, 34, 26, 50
; Allocate 5000 bytes for fifoQueue
x           DCD     &13579BDF
y           DCD     &12000000
	ENTRY
start
    ADR R0, city
    ADR R1, sales
    ADR R3, x
    LDR R0, [R3]
    ADR R3, y
    LDR R1, [R3]
    BL calculate


	SWI	SWI_Exit	; Exit the program

; @arg r0 is the first number.
; @arg r1 is the second number.
calculate
    MOV r6, r0      ; sum is r6. r6 = r0
    MOV r7, #0      ; r7 is the "i". r7 = 0
BEGIN_WHILE
    CMP r7, #3      ; How does r7 compare to #3?
    BGE END_WHILE   ; End the while when r7 >= r3.
    ADD r6, r6, r1   ; sum = sum + n2.
    ADD r7, r7, #1  ; ++i
    B BEGIN_WHILE
END_WHILE
    MOV pc, lr      ; Return

	ALIGN
	END

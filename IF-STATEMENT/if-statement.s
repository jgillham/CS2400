		;*****************************************************************************
		; File: if-statement.s
		; Programmer: Josh Gillham
		; Description:
		;  This program is an example of an "if" statement.
		;
		; Date: 2-17-2014
		;******************************************************************************


	AREA parse, CODE
SWI_Exit	EQU		&11	; Software interupt will exit the program
	ENTRY

	MOV	r1, #0		; Set r1 = 0

	CMP r1, #10		; r1 - 10. Compare is like a subtraction that does not store the result,
					; but, the results are seen in the CPU flags.
	BGE ELSE		; if r1 >= 10 then jump to the "else" part.
	
	SUB R2, R2, R1	; R2 = R2 - R1
	ADD R1, R1, #1	; R1 = R1 + 1
	
	B ENDIF			; Jump to the end of the if statement, that is, skip the "else" part.
ELSE				; Label for the "else" part.
	ADD R2, R1, #18	; R2 = R1 - 18
	SUB R1, R1, #1	; R1 = R1 + 1
ENDIF				; The end of the "if" statement.
	SWI SWI_Exit	; Command the OS to terminate the program.

	ALIGN
	END

		;*****************************************************************************
		; File: 
		; Programmer: Josh Gillham
		; Description:
		;
		; Project: HW3
		; Date: 9-28-12
		;******************************************************************************


	AREA parse, CODE
SWI_WriteC	EQU 	&0	; Software interupt will write character in r0 to output
SWI_Exit	EQU		&11	; Software interupt will exit the program

	ENTRY
start

	MOV	r1, #0		; Set r7= 0

	CMP r1, #10
	BLT ENDIF1
	
	SUB R2, R2, R1
	ADD R1, R1, #1
	
	B ENDIF1
ELSE1
	ADD R2, R1, #18
	SUB R1, R1, #1
ENDIF1
	SWI SWI_Exit

	ALIGN
	END

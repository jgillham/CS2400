		;*****************************************************************************
		; File: parse.s
		; Programmer: Josh Gillham
		; Description:
		;	Takes the string in STR1 and analyses it. Modifies the
		; string while analysing to replace the lower case vowels with
		; upper case corresponding letters. Prints the count of vowel
		; letters at the end of the program.
		;
		; Project: HW3
		; Date: 9-28-12
		;******************************************************************************


	AREA parse, CODE
SWI_WriteC	EQU 	&0	; Software interupt will write character in r0 to output
SWI_Exit	EQU		&11	; Software interupt will exit the program
DATA1 		DCD 	&12345678

	ENTRY
start
	ADR	r7, DATA1	; Get the memory address of DATA1
	LDR r6, [r7]    ; Get the value located at the memory.

	MOV	r7, #0		; Set r7= 0

FOR1
	CMP r7, #10
	BGE ENDFOR1
	ADD r7, r7, #1
	B FOR1
ENDFOR1
	SWI SWI_Exit

	ALIGN
	END

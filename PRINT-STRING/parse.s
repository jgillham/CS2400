		;*****************************************************************************
		; File: parse.s
		; Programmer: Josh Gillham
		; Description:
                ; This program shows how to print a string.
		;
		; Date: 2-24-2014
		;******************************************************************************


	AREA parse, CODE
SWI_WriteC	EQU 	&0	; Software interupt will write character in r0 to output
SWI_Exit	EQU	&11	; Software interupt will exit the program
STR1	DCB	 "What an earth shuttering discovery!",&0D,&0A,0
        ALIGN
	ENTRY
start
	ADR	r1, STR1	; Copy in pointer to string
	BL	print_string	; Call print string
        SWI     SWI_Exit        ; Kill program.

; print_string iterates through each character in the string and prints them.
; @arg r1 is address to the string
print_string
	LDRB 	r0, [r1], #1	; r0= *(r1++); Store the value from the pointer r5 then increment r5
	CMP	r0, #0		; Check for null
	MOVEQ	pc, r14		; If null, Return ; r14 is special
	SWI	SWI_WriteC	; Print single character in r0
	B	print_string	; Loop back
	END

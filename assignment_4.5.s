	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	; AREA    main, CODE, READONLY
	AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 4 code
    ; Assignment 4.5
	
	; Test for complex roots in solution to following quadratic equation
	;	ax^2 + bx + c = 0
	
	; Solution has complex roots: if b^2 - 4ac < 0   ; r3 = 1
	; Solution has real roots:	  otherwise 		 ; r3 = 0
	; a in r0, b in r1, c in r2
	
	; Verify program with equation: x^2 + 7x + 12 = 0
	
	; Hints: MUL, LSL, CMP, MOVLT, MOVGE

		LDR	r1, =a 	
		LDR r0, [r1]   ; r0 = a
		LDR r2, =b
		LDR r1, [r2]   ; r1 = b
		LDR r3, =c
		LDR r2, [r3]   ; r2 = c
		
		LDR r8, =4

		MUL r4, r0, r2 ; r4 = a*c
		MUL r4, r4, r8 ; r4 = d*r4 = 4*r4
		MUL r5, r1, r1 ; r5 = b*b = b^2
		SUB r6, r5, r4 ; r6 = r5 - r4 = b^2 - 4*ac
		
		CMP r6, #0
		MOVLT r3, #1  ; store 1 in r3 if r6 < 0
		CMP r6, #0
		MOVGE r3, #0  ; store 0 in r3 if r6 >= 0

		
stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
a	DCD	1
b	DCD 7
c	DCD 12
	
d	DCD 4

	END
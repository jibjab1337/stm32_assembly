	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 3 code
    ; Assignment 3.2
	
	; z = x % y
	; Modulus operation
	; Dividend = Divisor(Quotient) + Remainder
	;     7    =     2      (3)    +     1
	; Remainder = Dividend - Divisor(Quotient)
	;     1    =     7     -    2       (3)
	
	; Hint: Use SDIV, MLS
	; SDIV r0, r2, r1 ; r0 = r2/r1
	; MLS r0, r1, r2, r3 ; r0 = r3 - (r1*r2)
	
	LDR r0, =x;
	LDR r1, [r0]; r1 = x = 7
	LDR r0, =y;
	LDR r2, [r0]; r2 = y = 2
	LDR r0, =z;
	LDR r3, [r0]; r3 = z = 0
	
	SDIV r0, r1, r2 ; r0 = 7/2 = 3
	MLS r3, r2, r0, r1 ; z = 7 - (2*3) = 1
	; r3 is the remainder

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
	
x	DCD 0x00000007 
y	DCD 0x00000002
z	DCD 0x00000000	
	
	END
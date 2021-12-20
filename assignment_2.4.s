	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 2 code
    ; Assignment 2.4
	
	LDR r9, =a 
	LDR r0, [r9] ; 0x00000001
	LDR r9, =b
	LDR r1, [r9] ; 0x00000000
	
	;1) 17*x
	ADD r1, r0, r0, LSL #4 ; y = 16*x + x = 17*x --- 11 (in hex) = 17 (in binary)
	STR r5, [r1]
	
		; Reverse Subtract 
		; RSB r0, r1, r2 ; r0 = r2 - r1
	
	;2) y = 31*x
	RSB r0, r1, r1, LSL #5 ; y = 32*x - x = 31*x --- I'm doing 31*17 = 20F (in hex) = 527 (in binary)
	STR r6, [r0]
	
	LDR r0, =c
	
	;3) y = 38*x
	LDR r9, =a
	LDR r0, [r9] ; r0 = 0x00000001
	LDR r2, [r9] ; r2 loads value from r9
	
	ADD r1, r0, r0, LSL #5 ; r1 = r0 + 32*r0 = 33*r0
	ADD r3, r2, r2, LSL #2 ; r3 = 4*r2 + r2 = 5*r2
	ADD r0, r3, r1		   ; r0 = 33*r0 + 5*r2 = 33*r0 + 5*r0 = 38*r0
	STR r7, [r0]
	
	;4) y = 24*x Hint: 16*x + 8*x = 32*x - 8*x = 24*x
	LDR r0, =c
	LDR r9, =a
	LDR r0, [r9] ; r0 = 0x00000001
	LDR r2, [r9] ; r2 loads value from r9
	
	ADD r2, r2, r2, LSL #4 
	ADD r0, r0, r0, LSL #3 
	ADD r9, r0, r2
	STR r8, [r9]
	
	;5) y = 61*x = 64*x - 3*x

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
	
a	DCD 0x00000001 
b	DCD 0x00000000
c	DCD 0	
	
	END
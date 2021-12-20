	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	; AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 4 code
    ; Assignment 4.7
	
	; Write assembly program that calculates the cost function below
	; cost(x) = 9x	if x <= 10
	;		    8x	if x >  10   and x <= 100
	;			7x	if x >  100  and x <= 1000
	;			6x	if x >  1000
	
	; Assume unsigned integer input x is in register r0
	; cost is in register r1
	

		LDR	r1, =x 	
		LDR r0, [r1]   ; r0 = x
		LDR r2, =b
		LDR r1, [r2]   ; r1 = ct = cost ; Set to 0 for now
		LDR r2, =0	   ; r2 = 0	
		
		CMP r0, #10    ; Compare x to 10
		BLE then_9x    ; go to then_9x if x <= 10
		
		CMP r0, #100   ; Compare x to 100		
		BLE then_8x	   ; go to then_8x if x <= 100
		
		CMP r0, #1000  ; Compare x to 1000		
		BLE then_7x	   ; go to then_7x if x <= 1000
		BGT then_6x	   ; go to then_6x if x >  1000		

		
then_9x	LDR r3, =9
		MUL r2, r0, r3 	; r1 = 9*x
		STR r1, [r2]
		B	endif	

then_8x	LDR r3, =8
		MUL r1, r0, r3 	; r1 = 8*x
		STR r1, [r1]
		B	endif

then_7x	LDR r3, =7
		MUL r1, r0, r3 	; r1 = 7*x
		STR r1, [r1]
		B	endif
			
then_6x	LDR r3, =6
		MUL r1, r0, r3 	; r1 = 6*x
		STR r1, [r1]
		B	endif				
	
endif

		
stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
x	DCD 99
b	DCD 0
	
	END
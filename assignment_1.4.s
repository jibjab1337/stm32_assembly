	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 2 code
    ; For code
	LDR r1, =a 
	LDR r2, [r1]
	LDR r3, =b
	
	LDR r4, [r3]
	LDR r6, =c
	LDR r7, [r6] ; assign zeros to r7
	MSR apsr_nzcvq, r7 ; resetting all flags to zero
	SUBS r5, r2, r4
	
	STR r5, [r6]
	
stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
a	DCD 5
b	DCD 4
c	DCD 0
	
	END
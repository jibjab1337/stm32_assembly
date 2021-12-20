	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
    ; For code
	LDR r1, =a ; r1 is set to the address a
	LDR r2, [r1] ; loads address from r1
	LDR r3, =b ; r3 is set to address b
	LDR r4, [r3] ; loads address from r3
	ADDS r5, r2, r4 ; r5 = r2 + r4
	LDR r6, =c ; r6 is set to the address c
	STR r5, [r6] ; stores r5 TO r6
  
stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
a	DCD 1 ; area where you initialize the variables used
b	DCD 2
c	DCD 0	
	
	END







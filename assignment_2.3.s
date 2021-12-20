	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 2 code
    ; Assignment 2.4
	
	LDR r9, =a 
	LDR r0, [r9] ; 0
	LDR r9, =b
	LDR r1, [r9] ; 1
	
	ADD r1, r0, r0, LSL #4 ;	

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
	
a	DCD 1 
b	DCD 0			
	
	END
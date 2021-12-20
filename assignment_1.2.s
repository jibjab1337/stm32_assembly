	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
    ; For code
	LDR r1, =x ; r1 is set to the address x
	LDR r7, [r1] ; loads address from r1
	LDR r2, =y ; r2 is set to address y
	LDR r8, [r2] ; loads address from r2
	ADDS r9, r7, r8 ; r9 = r7 + r8 = 3 + 2 = 5
	LDR r3, =k ; r3 is set to the address k
	LDR r4, [r3] ; loads address to r4
	ADDS r10, r9, r4 ; r10 = r9 + r4 = 5 + 1 = 6
	STR r5, [r10] ; stores value from r10 in r5
  
stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
x	DCD 3
y	DCD 2
k	DCD 1	
	
	END
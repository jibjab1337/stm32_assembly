	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 3 code
    ; Assignment 3.8
	
	; r0 = 0xABCDEF99
	
	; AND - Reset all EVEN bits of r0 to 0, keep odd bits unchanged ; Store value in r5
	; ORR - Set all ODD bits of r0 to 1, keep even bits unchanged   ; Store value in r6
	; EOR - Toggle all ODD bits of r0, keep even bits unchanged     ; Store value in r7

	; Hint: Use EOR, ORR, MVN (or MOV), BIC
	
	LDR r1, =x
	LDR r0, [r1]
	LDR r1, =a
	LDR r2, [r1]
	
	AND r5, r0, r2 ; 0x01454511 - correct
	ORR r6, r0, r2 ; 0xFFDDFFDD - correct
	EOR r7, r0, r2 ; 0xFE98BACC - correct
	

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
x	DCD 0xABCDEF99
y	DCD 0x00000000

a	DCD 0x55555555 ; hex equivalent of 32 bit binary 0b0101....0101

	END
	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 3 code
    ; Assignment 3.3
	
	; Find result of following operations
	
	; RBIT r1, r0
	; REV r2, r0
	; REV16 r3, r0
	; REVSH r4, r0
	
	; RBIT 0x3D591E6A
	
	; Hint: Use LDR rd, =0x56789ABC to directly load 32 bit number
	LDR r0, =0x56789ABC

	RBIT r1, r0
	REV r2, r0
	REV16 r3, r0
	REVSH r4, r0
	
	; REV
	; 56|78|9A|BC
	; 4  3  2  1
	; BC|9A|78|56
	; 1  2  3  4
	
	; REV16
	; 56|78|9A|BC
	; 4  3  2  1
	; 78|56|BC|9A
	; 3  4  1  2
	
	; REVSH
	; 56|78|9A|BC
	; 4  3  2  1
	; FFFFF|BC|9A
	;       1  2
	

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
	
	
	END
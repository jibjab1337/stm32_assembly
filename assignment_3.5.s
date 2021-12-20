	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 3 code
    ; Assignment 3.5
	
	; Swap upper half-word and lower half-word of a register
	; Start: 0x12345678 (use any register)
	; End:   0x56781234
	; Use any register
	
	; Hint: Use 
	; LDR 
	; LSR 
	; ORR Rd, Rn, Rm, LSL --> ORR r7, r6, r5, LSL #2 
	; 							First shift r5 to left by 2 bits
	; 							and ORR with r6
	; 							then store the result in r7
	; ORR Rd, Rn, Rm, LSR
	
	LDR r0, =a
	LDR r1, [r0] ;r1 = 0x12345678
	LDR r0, =b
	
	; Half-word 1 becomes Half-word 0
	LSR r2, r1, #16 ;0x00001234
	
	; Half-word 0 becomes Half-word 1
	LSL r3, r1, #16 ;0x56780000
	
	; Add them all up with ORR
	ORR r0, r2, r3  ;0x56781234
	

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
a	DCD	0x12345678
b	DCD 0x00000000
	
	END
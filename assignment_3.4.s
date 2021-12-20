	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 3 code
    ; Assignment 3.4
	
	; Reverse the byte order of a register
	; Start: 0x12345678
	; End:   0x78563412
	; Do not use REV
	; Store result in r0
	
	; Hint: Use 
	; LDR 
	; LSR 
	; AND
	; ORR Rd, Rn, Rm, LSL --> ORR r7, r6, r5, LSL #2 
	; 							First shift r5 to left by 2 bits
	; 							and ORR with r6
	; 							then store the result in r7
	; ORR Rd, Rn, Rm, LSR
	
	LDR r0, =a
	LDR r1, [r0] ;r1 = 0x12345678
	LDR r0, =b
	
	; Byte 0 becomes Byte 3
	LSR r2, r1, #24 ;0x00000012
	
	; Byte 3 becomes Byte 0
	LSL r3, r1, #24 ;0x78000000
	
	; Byte 1 becomes Byte 2	
	LSL r4, r1, #16 ;0x56780000
	LSR r4, r4, #24 ;0x00000056
	LSL r4, r4, #16 ;0x00560000
	
	; Byte 2 becomes Byte 1	
	LSL r5, r1, #8  ;0x34567800
	LSR r5, r5, #24 ;0x00000034
	LSL r5, r5, #8  ;0x00003400
	
	; Add them all up with ORR
	ORR r6, r5, r4  ;0x00563400
	ORR r0, r2, r3  ;0x78000012
	ORR r0, r0, r6  ;0x78563412
	

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
a	DCD	0x12345678
b	DCD 0x00000000
	
	END
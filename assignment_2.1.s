	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 2 code
    ; Assignment 2.2
	LDR r0, =b 
	LDR r1, [r0] ; LSB A 0xF0000000
	LDR r2, =d
	LDR r3, [r2] ; LSB B 0x80000000
	LDR r4, =a
	LDR r5, [r4] ; MSB A 0x10000001
	LDR r6, =c
	LDR r7, [r6] ; MSB B 0x10000000
	LDR r8, =e
	LDR r9, [r8] ; LSB A + LSB B, set to 0
	LDR r10, =f
	LDR r11, [r10] ; MSB A + MSB B, set to 0
	
	MSR apsr_nzcvq, r11 ; resetting all flags to zero
	
	ADDS r9, r1, r3	
	STR r8, [r9] ; storing the result of LSB back into r8 since it's already loaded
	
	ADC r11, r5, r7
	STR r10, [r11] ; storing the result of MSB back into r10 since it's already loaded
	

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
b	DCD 0xF0000000	; LSB A
d	DCD 0x80000000	; LSB B
	
a	DCD 0x10000001	; MSB A
c	DCD 0x10000000	; MSB B

	
e	DCD 0 ; for LSB A + LSB B
f	DCD 0 ; for MSB A + MSB B
	
	END
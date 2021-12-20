	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 2 code
    ; Assignment 2.2
	
	LDR r9, =c 
	LDR r0, [r9] ; LSB A 0xFFFFFFFF
	LDR r9, =f
	LDR r3, [r9] ; LSB B 0x00000001
	LDR r9, =b
	LDR r1, [r9] ; middle LSB A 0x00000002
	LDR r9, =e
	LDR r4, [r9] ; middle LSB B 0x00000004
	LDR r9, =a
	LDR r2, [r9] ; MSB A 0x10001234
	LDR r9, =d
	LDR r5, [r9] ; MSB B 0x12345678
	LDR r9, =i
	LDR r6, [r9] ; i
	LDR r9, =h
	LDR r7, [r9] ; h
	LDR r9, =g
	LDR r8, [r9] ; g
	
	MSR apsr_nzcvq, r9 ; resetting all flags to zero
	
	SUBS r6, r0, r3	
	;STR r6, [r9] ; storing the result of LSB into r9
	
	SBCS r7, r1, r4
	;STR r7, [r9] ; storing the result of middle LSB into r10

	SBCS r8, r2, r5
	;STR r8, [r9] ; storing the result of MSB into r10

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		;00001234 00000002 FFFFFFFF 
		;a			b		c
		;			(-)
		;12345678 00000004 00000001
		;d			e		f
		;			(=)
		;MSB		middle	LSB
		;g			h		i
c	DCD 0xFFFFFFFF	; LSB A
f	DCD 0x00000001	; LSB B		
		
b	DCD 0x00000002	; middle LSB A
e	DCD 0x00000004	; middle LSB B
	
a	DCD 0x10001234	; MSB A
d	DCD 0x12345678	; MSB B

	
i	DCD 0 ; for LSB A + LSB B
h	DCD 0 ; for middle LSB A + middle LSB B
g	DCD 0 ; for MSB A + MSB B
	
	END
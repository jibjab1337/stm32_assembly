	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	; AREA    main, CODE, READONLY
	AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 4 code
    ; Assignment 4.4
	
	; Write program that calculates sum given below
	;	sum = sigma (i = 1 to i = n) i^2 = 1^2 + 2^2 + ... + n^2
	
	; Variable n is saved in register r0
	; sum is saved in register r1
	
	; Example: n = 5 --> 5^2 + 4^2 + 3^2 + 2^2 + 1^2 = 55 = 0b55 = 0x37 
	;					 25  + 16  +  9  +  4  +  1

		LDR	r1, =n 	
		LDR r0, [r1]   ; r0 = n
		LDR r2, =sum
		LDR r1, [r2]   ; r1 = sum or where sum will be stored
		LDR r3, =1 	   ; r3 = nth term starting at 1
		LDR r6, =0	   ; r6 = counter starting at 1
		
loop	MUL r5, r3, r3 ; r5 = r3 * r3 = nth term^2
		ADD r3, r3, #1 ; r3 will be incremented by 1 and will start at 1
		ADD r1, r5, r1 ; r1 = sum inside loop
		ADD r6, r6, #1 ; r6 = counter will be incremented by 1 and will start at 1
		CMP r6, r0	   ; checks if counter = nth term
		BNE loop	   ; if counter DNE nth term, continue the loop
		
stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
n	DCD	5
sum	DCD 0

	END
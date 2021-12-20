	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	; AREA    main, CODE, READONLY
	AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 4 code
    ; Assignment 4.2
	; Define an array with 10 unsigned integers
	; Write program that calculates mean (average) of 10 integers
	; truncate the result to an integer
	
	; Hint: 
	; Defining an array --> a	DCD	12, 65, 2
	; Use following instructions:
	;	CMP, BGT, ADD, ADDS, LDR, LSL, UDIV
	
	; The array used for this program is a = 1, 2, 3,..., 9, 10
	; The sum of this array is 55 so when finding the mean, it should be 55/10 = 5 for nearest integer

		LDR	r1, =a 		; array
		LDR	r0, =b 		; 0
		LDR r2, [r0]
		LDR r3, [r0] 
		LDR r4, [r0]
		
loop	LDR r2, [r1], #4	; Load 1 element of the array & increase address pointer a by 4 bytes
		ADD r3, r2, r3		; r3 will store the sum of each of the array elements from r2
		ADD r4, r4, #1		; r4 will be the counter. Will add to itself by 1 thru every loop cycle until it reaches 10
		CMP	r4, #10			; Check if r4 = 10 which will happen by the end of the array since it only has 10 elements
		BNE	loop			; Continue loop if r4 < 10
							; by the end of the loop: r3 = the sum of all elements in array from address a & r4 = 10
							; r3 = 1 + 2 + 3 + ... + 10 = 55 or 0b55 = 0x37
			
		UDIV r6, r3, r4		; Once loop is done, divide r3 by r4 to get mean --> r6 = r3 (the sum) / r4 (number of terms or 10)
							; 													 r6 = 55 / 10 = 5 
		
stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
a	DCD	1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ; starts at address 0x20000000 and goes up to 0x200000024 or 36 bytes. Every number is 4 bytes apart
b	DCD 0

	END
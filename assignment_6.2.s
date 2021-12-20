	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY ;;;;;;;;change back if not working with strings
	;AREA string_copy, CODE, READONLY
	
	EXPORT	__main						; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 6 code
    ; Assignment 6.2
	
	; Write a program that uses a subroutine to find how many 1 bits exists in a 32 bit number.
	; Every hex digit gives 4 bits in binary --> Program has to count all 1's in a 32 bit number
	
	; Hint: Use barrel shifter, bit mask and ORR operations
	
	MOV r2, #0		; r2 = counter -- starts at 1 goes to 32
	MOV r3, #0		; r3 = shifter or the number of bits we will shift by
	MOV r4, #0		; r4 = tracker 	-------------------------------------->	This is where we will store the total number of 1 bits in the value x
	
	BL	BitCheck	; Call BitCheck subroutine
	
					; By the end of this long loop, r4 our tracker should be 4 because there should be four 1 bits in 0x0000000F 
	B	stop

	ENDP			; End of main PROC
		
BitCheck PROC

bitlp	LDR r0, =x		; 0x0000000F -------------------------------------> 0xF = 0b1111 so there should be 4 total number of 1 bits in the entire value x
		LDR r1, [r0]	; Set r1 to x or our value. This is to make sure we always start with the same value defined in the data
		
		LSR r0, r1, r3	; Take r1 (our value) and shift by r3 (shifter) number of bits, then store result in r0

		ADD r3, r3, #1	; Shifter is incremented by 1 -- Shifter starts at 1 and is the register that holds number of bits we will shift by

		LSL r0, r0, #31	; LSL by 31 bits
		LSR r0, r0, #31 ; LSR by 31 bits 
						; From the above, we shifted a bit to the right, then shifted it all the way to the left and then shifted back all the way to the right
						; This is how we will isolate each and every bit sequentially. By doing this, we will have either 0x00000001 or 0x00000000 so we can compare
		ADD r2, r2, #1	; Increment counter 

		CMP r0, #1		; Compare that LSL shifted number to 1

		ADDEQ r4, r4, #1	; Increment tracker if 1 is found -- Tracker starts at 0

		CMP r2, #32
		BLE bitlp		; If counter <= 32, branch back to bitlp		
		BX LR			; else, end the subroutine --> Takes you back to where you called the subroutine originally
	
stop	B	stop						; Dead loop. Embedded program never exits.

	ENDP
								
	ALIGN			
	AREA    myData, DATA, READWRITE
	ALIGN
		
x	DCD	0x0000000F

	END
	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY ;;;;;;;;change back if not working with strings
	;AREA string_copy, CODE, READONLY
	
	EXPORT	__main						; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 6 code
    ; Assignment 6.3
	
	; Write an assembly program that reverses all bits of a 32 bit number without using the RBIT instruction.	
	; Hint: Use barrel shifter, bit mask and logic (ORR specifically) operations
	
	; NOTE: My program has input x = 0x0000000F. Register r3 will store the reversed-bit value of x
	;		So if x is 0x0000000F, the reversed-bit value in r3 will be 0xF0000000
	
	LDR r0, =shft
	LDR r3, [r0]	; r3 = where we will store the reversed bit value
	MOV r4, #0		; r4 = shifter --> This will shift the original value by 1, 2, 3... bits so that the bit we want to move
					; will be at the lowest or highest address depending on the LSR/LSL operation
	BL	BitRev		; Call BitRev subroutine
	LDR r0, =x		
	LDR r1, [r0]	; Just storing the original value to r1 so that you can compare x to reversed-bit x stored in r3 in the table.

	B	stop		; Branch to stop to end the program
	
	ENDP			; End of main PROC
		
BitRev PROC						; Subroutine BitRev
			
firsthalv	LDR r0, =x			; 0x0000000F -----------> 0xF = 0b1111
			LDR r1, [r0]		; Set r1 to x or our value. This is to make sure we always start with the same value defined in the data section

			LSL r0, r1, r4		; We want to isolate every bit sequentially from lowest to highest (or vice versa) address, one at a time
								; This will be done by using a shifter value which will increment by 1 each loop and shift the original value by a # of bits
			LSR r1, r0, #31		; With the bit that we want isolated to the lowest/highest address, we shift it to the furthest address so that we can delete all other bits
			LSL r0, r1, r4		; Take the shifted and isolated bit value and shift by r4 number of bits, then store result in r0
								; By doing this, we can move a bit from its original index to the reversed index which will be stored in another register r3	
			ORR r3, r0, r3		; r3 = [ shifted bit value OR (r3 = 0x00000000) ] --> This is how we will store all the shifted bits. This will work regardless if a bit is 1 or 0
			
			ADD r4, r4, #1		; We increment shifter by 1 so that with the next shift, we can shift x by shifter +1 bits and get the next bit index			
			
			CMP r4, #16			; Compare the shifter value to 16
			BGT	rstr			; if shifter > 16, that means we completed reversing and shifting the first half of x so we branch to rstr to begin the second half of x operations
			B	firsthalv		; else, branch back to firsthalv to continue the loop
			
rstr		MOV r4, #0			; We reset the shifter value to 0 again
			B	sechalv			; Branch to sechalv
			
sechalv		LDR r0, =x	
			LDR r1, [r0]
			
			LSR r0, r1, r4					
			LSL r1, r0, #31			
			LSR r0, r1, r4		; we do the same operations as in firsthalv -- but starting from the rightmost address
			
			ORR r3, r0, r3		

			ADD r4, r4, #1		
			
			CMP r4, #16			; Compare shifter to 16
			BGT	endloop 		; If shifter > 16, branch to the endloop
			B	sechalv			; else, branch back to sechalv and continue doing the bit operations.
			
endloop		BX LR				; end the subroutine --> Takes you back to where you called the subroutine originally
	
stop	B	stop				; Dead loop. Embedded program never exits.

	ENDP
								
	ALIGN			
	AREA    myData, DATA, READWRITE
	ALIGN		
x		DCD	0x0000000F
shft	DCD 0x00000000
	END
	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY 		;;;;;;;; change back if not working with strings
	;AREA string_copy, CODE, READONLY
	
	EXPORT	__main						; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Fibonacci Sequence calculator
	; Write a program that calculates the Fibonacci sequence up to a certain number n (and n must be greater than 2)
	; Take the average of the first 10 FibSeq numbers
	; i.e If n = 5 --> FibSeq = 0 + 1* = 1^ / 1* + 1^ = 2** / 1^ + 2** = 3^^ / 2** + 3^^ = 5~ ---> this is the 5th term so when n = 5, FibSeq = 0x5 or 5
	;						  f(0) f(1) f(2)           f(3)             f(4)              f(5)
	
	LDR r0, =n	
	LDR r1, [r0]	; r1 = integer n or the nth FibSeq term we want to find the value of; 
					
	MOV r2, #0		; r2 = 0 ---> The "previous" FibSeq term that will be replaced by the following term, which is r3.
	MOV r3, #1		; r3 = 1 ---> The "present" FibSeq term that will be replaced by the term following it
	
	MOV r4, #2		; r4 = 2 ---> r4 is our checker or the value of the nth index in the loop. Will increment by 1 until it reaches n i.e 1, 2, 3... n
					; Since the first two terms of the FibSeq are 0 and 1, we start counting from the 2nd index of the FibSeq
	MOV r5, #1		; r5 will hold the sum of the FibSeq numbers. We give it a value of 1 because the first two FibSeq numbers are 0 and 1
	MOV r6, #10		; r6 = 10 --> will use this register to divide by 10
	
	BL	FibSeq	; Call FibSeq subroutine
	
	; Once we finish our FibSeq calculations we should have the following value in r5: 0x0000008F = 143 in decimal
	; This is correct because the first 10 FibSeq numbers add up to this value --> 0 + 1 + 1 + 2 + 3 + 5 + 8 + 13 + 21 + 34 + 55 = 143
	
	UDIV r5, r5, r6 ; r5 = (r5 / r6) = (sum of our FibSeq numbers up to 10) / 10 = 143 / 10 = 14 = 0x0000000E

	B	stop		; Branch to stop to end the program
	
	ENDP			; End of main PROC
		
FibSeq PROC					; Subroutine FibSeq
		
loop	ADD r0, r2, r3		; r0 = r2 + r3 = previous FibSeq + present FibSeq -------> r0 is the register that will hold the value of the nth term of the FibSeq
		MOV r2, r3			; We set the previous FibSeq term to present one in r3
		MOV r3, r0			; We set the present FibSeq term to the new one in r0
		ADD r4, r4, #1		; r4 = r4 + 1 = r4++
		ADD r5, r5, r0		; r5 = r5 + r0 (the new FibSeq number)
		
		CMP r4, r1			; Compare our checker or current index value to n to make sure we stop at the nth term
		BLE	loop			; If current index value r4 < nth index r1, branch back to loop
		B	endif			; Otherwise, if r4 > r1 or our index value > nth term, that means we're done (since in the last loop, it will do the nth operation and r4 will be n + 1) 
		
endif		
		BX LR				; end the subroutine --> Takes you back to where you called the subroutine originally
		
	
stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
								
	ALIGN			
	AREA    myData, DATA, READWRITE
	ALIGN		
n	DCD	0x0000000A	; n1 = 10 in decimal
	END
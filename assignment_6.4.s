	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY ;;;;;;;;change back if not working with strings
	;AREA string_copy, CODE, READONLY
	
	EXPORT	__main						; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 6 code
    ; Assignment 6.4
	
	; Write a program that checks whether an unsigned number is a prime number or not.
	
	; A prime number is a number that is only divisible by 1 and itself i.e 13 is divisible by 1 and 13
	; Assume that n is your number that you want to check
	; Method: Start a loop with a value that increments by 1 that starts at 2 (we start at 2 because we know that 1 will always be a factor) 
	;         and ends at n - 1
	;		  So you start at 2, perform modulus operation on your value to check if mod(n,2) DNE 0. If you get 0, set up a flag in a register
	;		  (just add 1 to a register) and have program note that the flag has been raised, therefore your value is not a prime
	;		  But if mod(n,2) DNE 0, then increment 2 by 1 to get 3 and go back to loop to do mod(n,3).
	;		  If you still get 0 for 3, 4, 5... n-1 value then once you hit n-1 and mod(n, n-1) DNE 0, then you know you have a prime number
	
	LDR r0, =n2		; n1 = 37, n2 = 59, n3 = 4 ----> values of n that can be used to test prime program
	LDR r1, [r0]	; r1 = prime value
	MOV r2, #2		; r2 = checker or the value that will be used to test for prime. Will increment up to n - 1
					; r3 = remainder of the mod operation
	MOV r4, #0		; r4 = the register that will confirm if n is a prime --------------------------------------> NOTE: if r4 = 1, n is a prime; if r4 = 0, n is not a prime
	
	BL	Primer		; Call Primer subroutine

	B	stop		; Branch to stop to end the program
	
	ENDP			; End of main PROC
		
Primer PROC						; Subroutine Primer
							
		SUB r5, r1, #1      ; r5 = n - 1
		
loop	UDIV r0, r1, r2    	; r0 =  n / r2  
		MLS r3, r2, r0, r1 	; remainder = r2 - ( [n / r2] * n ) --> modulus operation will tell us if n is a prime if mod(n, r2) = 0
		
		ADD r2, r2, #1	   	; r2 = r2 + 1 = r2++

		CMP r2, r5			; Compare r2 to r5 = n - 1
		BGT yes				; If we reach this point where r2 > n - 1, we can assume that all previous values from 2 to n - 1
							; resulted in mod(n, r2) DNE 0 and thus, values 2 to n - 1 are not factors of n
							
		CMP r3, #0         	; Compare remainder to 0 --> need to check if mod(n, r2) = 0
		BNE loop           	; if mod(n, r2) DNE 0 --> we branch back to loop and perform the same mod operation with r2 ++ to continue our search of possible factors
		B	no				; else, mod(n, r2) = 0 and thus it is divisible by a number between or at 2 to n - 1, therefore it cannot be a prime
		
no		ADD r4, r4, #0		; r4 = 0 which means that n is not a prime
		B	endif

yes		ADD r4, r4, #1 		; r4 = r4 + 1 = 1 which means that n is a prime
		B	endif
endif		
		BX LR				; end the subroutine --> Takes you back to where you called the subroutine originally
	
stop	B	stop				; Dead loop. Embedded program never exits.

	ENDP
								
	ALIGN			
	AREA    myData, DATA, READWRITE
	ALIGN		
n1	DCD	0x00000025	; n1 = 37 in decimal
n2	DCD	0x0000003B	; n2 = 59 in decimal
n3	DCD 0x00000004	; n3 = 4 in decimal	
	END
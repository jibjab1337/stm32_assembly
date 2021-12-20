	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY ;;;;;;;;change back if not working with strings
	;AREA string_copy, CODE, READONLY
	
	EXPORT	__main						; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 6 code
    ; Assignment 6.5
	
	; Write an assembly program that checks whether an integer is a square of some integer. For example, 25 = 5^2
	
	LDR r0, =n1		
	LDR r1, [r0]	; r1 = integer n to test for perfect square; 
					;      n1 = 400, n2 = 59 ------------> values of n that will be used to test square finder program
	MOV r2, #1		; r2 = the value that will be squared in each loop. Will increment up to n / 2 or half of n

	MOV r4, #0		; r4 = the register that will confirm if n is a perfect square -------------> NOTE: if r4 = 1, n is a perfect square; if r4 = 0, n is not a perfect square
	MOV r5, #2		; r5 = 2
	
	BL	SquareNum	; Call SquareNum subroutine

	B	stop		; Branch to stop to end the program
	
	ENDP			; End of main PROC
		
SquareNum PROC				; Subroutine SquareNum
							
		UDIV r3, r1, r5     ; r3 = n / 2 ---------> we will check for squares sequentially up until half the value of an input n
							; I pick n / 2 as an arbitrary stop point because the roots of perfect squares beyond 2 are less than
							; half of a perfect square. i.e 25 = 5^2 and 5 < (25/2).
		
loop	MUL r0, r2, r2		; r0 = r2 * r2 = r2^2
		ADD r2, r2, #1	   	; r2 = r2 + 1 = r2++
		
		CMP r0, r1			; Compare r2^2 to r1 or the original value n that we're testing
 		BEQ yes				; Branch to yes if r2^2 = r1
		
		CMP r2, r3			; Compare r2 to r3 = n / 2
		BLE loop			; Branch back to loop if r2 <= n / 2 meaning that we can still increment r2 to check for more r2^2 values
		BGT no				; If we reach this point where r2 > n / 2, we can assume that all previous values from 1 to n / 2
							; resulted in r2^2 DNE r1 and thus, n cannot be a perfect square
		
no		ADD r4, r4, #0		; r4 = 0 which means that n is not a perfect square
		B	endif

yes		ADD r4, r4, #1 		; r4 = r4 + 1 = 1 which means that n is a perfect square
		B	endif
endif		
		BX LR				; end the subroutine --> Takes you back to where you called the subroutine originally
	
stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
								
	ALIGN			
	AREA    myData, DATA, READWRITE
	ALIGN		
n1	DCD	0x00000190	; n1 = 400 in decimal
n2	DCD	0x0000003B	; n2 = 59  in decimal
	END
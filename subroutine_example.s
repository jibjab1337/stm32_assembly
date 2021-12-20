	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY ;;;;;;;;change back if not working with strings
	;AREA string_copy, CODE, READONLY
	
	EXPORT	__main						; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 6 code
    ; Assignment 6.1
	
	; Write a subroutine called MoviePrice that calculates the movie ticket
	; price based on the input argument called age. If the age is 12 or
	; under, the price is $6.00. If the age is between 13 and 64, the price is
	; $8.00. If the age is 65 or over, the price is $7.00
	
	; Read chapter 8 for Subroutine info
	
	
	MOV r4, #100	; set r4 to 100
	
	BL	MoviePrice	; call MoviePrice
	
	ADD	r4, r4, #1	; Because MoviePrice recovers originally r4 despite changing it, it's still r4 = 100 + 1 = 100
	
	B	stop

	ENDP			; End of main PROC
		
MoviePrice PROC	; establishing the subroutine MoviePrice
	
	PUSH {r4} 	; preserve r4 which is originally 100
	
	MOV r4, #10 ; foo changes r4 to 10
	
	POP {r4} 	; Recover r4 which was originally 100	

	BX LR		; ending the subroutine --> Takes you back to where you called the subroutine originally	LR stands for Link Register or r14
	
stop	B	stop						; Dead loop. Embedded program never exits.

	ENDP		; End of MoviePrice
								
	ALIGN			
	AREA    myData, DATA, READWRITE
	ALIGN
		
age	DCD	5

	END
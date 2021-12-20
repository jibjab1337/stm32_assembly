	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY ;;;;;;;;change back if not working with strings
	;AREA string_copy, CODE, READONLY
	
	EXPORT	__main						; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 6 code
    ; Assignment 6.1
	
	; Write a subroutine called MoviePrice that calculates the movie ticket price based on the input argument called age. 
	; If the age is 12 or under, the price is $6. If the age is between 13 and 64, the price is $8. If the age is 65 or over, the price is $7.
	
	
	; For this program, the price will be stored in r2 and will change as the age inputs change, just to see what happens.
	
	LDR r0, =age1
	LDR r1, [r0]	; r1 = 5 years old
	
	BL	MoviePrice	; call MoviePrice
	
	LDR r0, =age2
	LDR r1, [r0]	; r1 = 25 years old
	
	BL	MoviePrice
	
	LDR r0, =age3	
	LDR r1, [r0]	; r1 = 73 years old
	
	BL	MoviePrice
	
	B	stop

	ENDP			; End of main PROC
		
MoviePrice PROC	; establishing the subroutine MoviePrice
	
	SUB r2, r2, r2      ; Price = Price - Price = 0 ---> Set price to 0 so that we can see how it changes with different age inputs
	CMP r1, #12			; If age is <= 12 ....
	ADDLE r2, r2, #6	; Price = 0 + 6 = 6 --> Set price to 6 dollars if person is 12 and younger
	CMP r1, #64			; If age is <= 64 ....
	ADDLE r2, r2, #8	; Price = 0 + 8 = 8 --> Set price to 8 dollars if person is between 13 and 64 years old
	CMP r1, #65			; If age is >= 65 ....
	ADDGE r2, r2, #7	; Price = 0 + 7 = 7 --> Set price to 7 dollars if person is 65 and older
	BX LR				; ending the subroutine --> Takes you back to where you called the subroutine originally	LR stands for Link Register or r14
	
stop	B	stop						; Dead loop. Embedded program never exits.

	ENDP		; End of MoviePrice
								
	ALIGN			
	AREA    myData, DATA, READWRITE
	ALIGN
		
age1	DCD	5		; 5 year old
age2	DCD 25		; 25 year old
age3	DCD	73		; 73 year old
price	DCD	0		; establishes price, initially set to zero

	END
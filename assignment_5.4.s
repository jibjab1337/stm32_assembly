	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	; AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 5 code
    ; Assignment 5.4
	
	; Write a program that checks if given year is a leap year

	; leap year is divisible by 400 OR only divisible by 4, not by 100
	
	; I do the modulus operation because a leap year % 4 = 0
	
	; r5 will be the answer to whether x is a leap year 
	; If r5 = 1, x is a leap year
	; If r5 = 0, x is not a leap year


	LDR r0, =x;
	LDR r1, [r0]; r1 = x = leap year
	LDR r2, =4  ; r2 = 4
	LDR r5, =0  ; r5 = 0 --> where we will store the result of x being leap year or not
	
	SDIV r0, r1, r2    ; r0 =  x / 4  
	MLS r4, r2, r0, r1 ; remainder = 4 - ( [x/4] * x ) --> modulus operation will tell us if x is a leap year
	CMP r4, #0         ; Compare remainder to 0 --> need to check if (leap year % 4) = 0
	BEQ lp_yr          ; if max % x = 0 --> we go to lp_yr
	
	ADD r5, r5, #0     ; else, r5 = 0 which means that x is not a leap year
	B	endif

lp_yr	ADD r5, r5, #1 ; r5 = r5 + 1 = 1 which means that x is a leap year
	B	endif

endif

stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
x	DCD 0x000007E1 ; ---> 0x7E0 = 2016 in dec so 0x7E1 = 2017

	END
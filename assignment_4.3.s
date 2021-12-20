	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	; AREA    main, CODE, READONLY
	AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 4 code
    ; Assignment 4.3
	
	; Write program that calculates following function
	;	f(x) = -1 if x < 0
	;			0 if x = 0
	;			1 if x > 0
	; Assume the signed integer input x is stored in register r0
	; and result f(x) is saved in register r1
	; x = -120
	
	; Hint: 
	; Use MOV, EQ, GT, LT, CMP

		LDR	r1, =x 	
		LDR r0, [r1] ; r0 = x
		LDR r1, =0   ; r1 = fx or where fx will be stored
		
		CMP r0, #0
		BLT then    ; go to then if x < 0
		CMP r0, #0
		BGT elseif  ; go to elseif if x > 0
		CMP r0, #0
		BEQ else	; go to else if x = 0
		
then	MOV r1, #-1 ; r1 = fx = -1 if x < 0
		B	endif
elseif	MOV r1, #1  ; r1 = fx =  1 if x > 0
		B	endif
else	MOV r1, #0  ; r1 = fx =  0 if x = 0
		B	endif
	
endif
			
stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
x	DCD	120

	END
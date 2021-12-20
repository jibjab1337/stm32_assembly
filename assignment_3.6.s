	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 3 code
    ; Assignment 3.6
	
	; Mask = 0x00000F0F
	;    P = 0xABCDABCD
	; What is the result of the following operations?
	; AND  		  Q = P & Mask  ; store Q in r3
	; ORR  		  Q = P | Mask  ; store Q in r4
	; EOR  		  Q = P ^ Mask  ; store Q in r5
	; NOT/Inverse Q = ~Mask     ; store Q in r6
	; AND NOT	  Q = P & ~Mask ; store Q in r7
	
	; Hint: Use 
	; MVN, BIC, AND, ORR, EOR
	
	LDR r0, =P
	LDR r1, [r0]  ;P
	
	LDR r0, =Mask
	LDR r2, [r0]  ;Mask
	
	LDR r0, =Q
	LDR r3, [r0]	
	
	AND r3, r1, r2 ;0x00000B0D
	ORR r4, r1, r2 ;0xABCDAFCF
	EOR r5, r1, r2 ;0xABCDA4C2
	BIC r6, r1, r2 ;0xABCDA0C0
	AND r7, r1, r6 ;0xABCDA0C0
	

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
Mask	DCD	0x00000F0F
P	DCD 0xABCDABCD
Q	DCD 0x00000000
	
	END
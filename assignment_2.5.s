	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 2 code
    ; Assignment 2.5
	
	LDR r9, =a 
	LDR r0, [r9] ; 0x0F0F0F0F 
	LDR r9, =b
	LDR r1, [r9] ; 0xFEDCBA98
	
	EOR r2, r1, r0
	ORR r3, r1, r0
	AND r4, r1, r0
	BIC r5, r1, r0
	MVN r6, r1
	MVN r7, r0
	MVN r8, r0
	ADD r8, r1, r8
	
	; The three operations I chose for hand calculations are
	; EORR, ORR and AND
	
	; Hand calculations are uploaded to a .pdf file
	
	; Solutions from my hand calculations are below
	;EOR: 11110001110100111011010110010111 ---> F1D3B597 CORRECT!
	;AND: 00001110000011000000101000001000 ---> E0C0A08  CORRECT!
	;ORR: 11111111110111111011111110011111 ---> FFDFBF9F CORRECT!

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
	
a	DCD 0x0F0F0F0F 
b	DCD 0xFEDCBA98			
	
	END
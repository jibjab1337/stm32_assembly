	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	; AREA    main, CODE, READONLY
	AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 4 code
    ; Assignment 4.6
	
	; Translate the C program into assembly program
	
	; if (a < b && a < c) {
	; 		min = a;
	;}else if (b < a && b < c){
	;		min = b;
	;}else {
	;		min = c;
	;}
	
	; C program above finds minimal value of three signed integers
	; A stored in r0, b in r1, c in r2
	; Result minimal value stored in r4
	
	; For this example, a = 12 = 0xC , b = 15 = 0xF , c = 10 = 0xA
	

		LDR	r1, =a 	
		LDR r0, [r1]   ; r0 = a
		LDR r2, =b
		LDR r1, [r2]   ; r1 = b
		LDR r3, =c
		LDR r2, [r3]   ; r2 = c
		LDR r3, =0	   ; r3 = minimum value from a, b, c	
		
		CMP r0, r1    ; Compare a to b
		BGE then_b    ; go to then_b if a >= b
		BLT then_a    ; go to then_a if a <  b
		
then_b	CMP r1, r2 	  ; Compare b to c
		BGE then_c    ; go to then_c   if b >= c
		BLT then_b_f  ; go to then_b_f if b <  c
		
then_a	CMP r0, r2    ; Compare a to c
		BGE then_c    ; go to then_c   if a >= c
		BLT then_a_f  ; go to then_a_f if a <  c
		
			
			
then_c 		MOV r3, r2      ; r3 = c because c is the min
		B	endif
then_b_f	MOV r3, r1		; r3 = b because b is the min
		B	endif
then_a_f	MOV r3, r0      ; r3 = a because a is the min
		B	endif
	
endif

		
stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
a	DCD	12
b	DCD 15
c	DCD 10
	
	END
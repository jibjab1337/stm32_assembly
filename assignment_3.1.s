	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 3 code
    ; Assignment 3.1
	
	; x = x * y + z - x;
	; x * y = FF * AB = AA55
	; AA55 + CD = AB22
	; AB22 - FF = AA23
	
	; Hint: Use MLA, to make the code efficient.
	LDR r0, =x;
	LDR r1, [r0];
	LDR r0, =y;
	LDR r2, [r0];
	LDR r0, =z;
	LDR r3, [r0];	
	
	MLA r0, r1, r2, r3 ; r0 = r3 + (r1*r2)
	SUBS r3, r0, r1 ; r3 = r0 - r21

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
	
x	DCD 0x000000FF 
y	DCD 0x000000AB
z	DCD 0x000000CD	
	
	END
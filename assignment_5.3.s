	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	; AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 5 code
    ; Assignment 5.3
	
	; Write a program that calculates the result of x raised to power of y
    ; x and y are two signed integers

	LDR r0, =x;
	LDR r1, [r0]; r1 = x = 4
	LDR r0, =y;
	LDR r2, [r0]; r2 = y = 6
	LDR r0, =c
	LDR r3, [r0]; r3 = c = counter starting at 0
	LDR r0, =init
	LDR r4, [r0]; r3 = init = initial value starting at 1
	LDR r5, =1
	LDR r6, =0
	
	CMP r2, #0
	BLT	abs_y	; if y is a negative value, branch to abs_y where we will turn it positive
	ADD r6, r6, r2; else, r6 will be y
	B	loop    ; then branch to the loop section
	
abs_y	RSB	r6, r2, #0 ; r6 = 0 - y --> if y is negative, this will turn it positive
		B	loop

loop	MUL r4, r4, r1 ; r4 = r4 * x  --------> r4 = 1 * x = x --> This is where we will store the result of x^y

		ADD r3, r3, #1 ; r3 = counter will be incremented by 1 and will start at 1
		CMP r3, r6	   ; compares counter to abs(y)
		BGE next	   ; if counter >= y, we branch to next
		B	loop       ; else, we continue the loop

next	CMP r2, #0  ; check if y is negative because a negative exponent means taking inverse of x^y
		BLT negt	; Branch to negt section if y < 0
		B	endif   ; else, go to endif
			
negt	UDIV r4, r5, r4 ; r4 = 1 / r4 --> take inverse of our power result because negative exponent
		B	endif

endif

stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
x	DCD 0x00000004
y	DCD 0x00000006
c	DCD 0x00000000
init DCD 0x00000001	
	END
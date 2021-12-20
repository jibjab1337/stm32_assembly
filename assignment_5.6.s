	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY ;;;;;;;;;;;;;;;;;;;;change back if not working with strings
	;AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 5 code
    ; Assignment 5.6
	
	; Translate the following C program into an assembly program. Your assembly program must consist of two nested loops..

	; int a[4][3] = {
	;	{11, 12, 13}, // first row
	;	{21, 22, 23}, // second row
	;	{31, 32, 33}, // third row
	;	{41, 42, 43} // fourth row
	; };
	;
	; void main(void) {
	;	int i, j;
	;	for( i = 0; i < 4; i++ )
	;		for( j = 0; j < 3; j++ )
	;			a[i][j] = 2*[i][j]
	;	return;
	; }
	
	; What the loop above is doing is this
	; At i = 0 --> the j for-loop inside i = 0 will start at j = 0
	; 	At j = 0, the value at i = 0, j = 0 or (0,0) will be multiplied by 2 --> this is a[i][j] = 2*[i][j]
	; 	then j = 0 will be incremented by 1 (because of j++)
	; 	then because j = 1 is still < 3, it will do another 2*(i,j) operation at (0,1) and increment j again by 1
	; 	It will do this until j = 3 because by then it will hit the j < 3 limit of the j for-loop
	; 	All the j operations above are done while i = 0. So the above example did operations on (0,0), (0,1), (0,2)
	; Then it returns back to the i for-loop. i is incremented by 1 (i++) and the j for-loop does operations again like before
	; for (1,0) (1,1), (1,2)
	; Through this method, you will move sequentially through every value in the 4x3 matrix and do 2*[value at (i,j)]
	
	
	
	; NOTE - THIS PROGRAM'S NESTED LOOPS WORKS AS DEFINED BY THE C CODE, THE PROBLEM I HAVE IS STORING THE NEW VALUE BACK INTO THE ARRAYS
	
	
		LDR r0, =row_1
        LDR r1, [r0]	; r1 = row 1
        LDR r0, =row_2
        LDR r2, [r0]	; r2 = row 2
        LDR r0, =row_3
        LDR r3, [r0]	; r3 = row 3
        LDR r0, =row_4
        LDR r4, [r0]	; r4 = row 4

        LDR r5, =0 		; i counter
        LDR r6, =0 		; j counter
		LDR r0, =2		; r0 = 2
		
iloop   CMP r5, #4 			; i < 4
        ADD r5, r5, #1 		; i++
		SUB r6, r6, r6		; j = j - j = 0 Makes sure that when we go back to this iloop, j is reset to 0
        BLT	jloop			; If i counter < 4, branch to jloop
        B	endif			; Else, branch to endif
		
jloop   CMP r6, #3 			; j < 3
        ADD r6, r6, #1 		; j++
        BLT time2			; If j counter < 3, branch to time2 
        B	iloop			; Else, branch back to iloop

time2	CMP r5, #1			; check if i = 1
		BEQ	i_op1			; if i counter = 1, branch to i_op1
		CMP r5, #2			; check if i = 2
		BEQ	i_op2			; if i counter = 2, branch to i_op2
		CMP r5, #3			; check if i = 3
		BEQ	i_op3			; if i counter = 3, branch to i_op3	
		CMP r5, #4			; check if i = 4
		BEQ	i_op4			; if i counter = 4, branch to i_op4	
		;B	iloop			; Else, branch back to jloop

i_op1 	LDR r7, [r1], #4	; If i counter = 1, Load 1 element of the array row 1 & increase address pointer by 4 bytes
		MUL r7, r7, r0		; r7 = 2*row 1 --> Multiple element by 2	
		B	jloop

i_op2   LDR r8, [r2], #4	; If i counter = 2, Load 1 element of the array row 2 & increase address pointer by 4 bytes
		MUL r8, r8, r0      ; r8 = 2*row 2 --> Multiple element by 2
		B	jloop
		
i_op3   LDR r9, [r3], #4	; If i counter = 3, Load 1 element of the array row 3 & increase address pointer by 4 bytes
		MUL r9, r9, r0		; r9 = 2*row 3 --> Multiple element by 2
		B	jloop
		
i_op4   LDR r10, [r4], #4	; If i counter = 4, Load 1 element of the array row 4 & increase address pointer by 4 bytes
		MUL r10, r10, r0	; r10 = 2*row 4 --> Multiple element by 2
		B	jloop

endif		
	
stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
row_1    DCD        11, 12, 13
row_2    DCD        21, 22, 23
row_3    DCD        31, 32, 33
row_4    DCD        41, 42, 43	

	END
	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	; AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 5 code
    ; Assignment 5.2
	
	; Write a program that finds Least Common Multiple (MCM) of two integers
	; Example: LCM of 4 and 6 is 12
	; 				4 * 3 = 12 and 6 * 2 = 12
	
	; Hint: Use modulus operation
	;    do
    ;
    ;    if (max % x == 0 && max % y == 0)
    ;    
    ;        cout << "LCM = " << max;
    ;        break;
    ;    
    ;    else
    ;        ++max;
    ; while (true);
	
	;x > 20 && x < 25

	; r0, =x
	; CMP r0, #20	; compare x and 20
	; BGT then	; go to then if x > 20
	; B else		; go to else if this condition fails

	;then CMP r0, #25	; compare x and 25 if x is also > 20
	;     BLT endif	        ; go to endif if x < 25
	;     B else		; go to else if this condition fails

	;else blah blah

	;endif

	LDR r0, =x;
	LDR r1, [r0]; r1 = x = 4
	LDR r0, =y;
	LDR r2, [r0]; r2 = y = 6
	LDR r0, =max;
	LDR r3, [r0]; r3 = max --> where we will store the max of x, y
	LDR r0, =rem
	LDR r4, [r0]; r4 = rem --> where we will store the remainder

	CMP r1, r2
	BGT max_x	; if x > y --> go to max_x 
	BLT max_y	; if x < y --> go to max_y

	; max_1 and max_2 just set up the max of the two
max_x ADD r3, r3, r1
	  B	nextx
max_y ADD r3, r3, r2
	  B nextx
	
nextx	SDIV r0, r3, r1    ; r0 =  max / x  
		MLS r4, r1, r0, r3 ; remainder = x - ( [max/x] * max ) --> we need to get 0
		CMP r4, #0         ; Compare remainder to 0 --> need to check if max % x is 0
		BEQ nexty          ; if max % x = 0 --> we go to nexty to do same operation
		BNE maxp           ; Branch to maxp if rem =/ 0 --> we increment the max because this condition failed
		
nexty	SDIV r0, r3, r2    ; r0 =  max / y  
		MLS r4, r2, r0, r3 ; remainder = y - ( [max/y] * max ) --> we need to get 0
		CMP r4, #0         ; Compare remainder to 0 --> modulus operation
		BEQ lcm            ; If max % y = 0 --> we've satisfied the conditions of nextx, nexty and can call this the LCM of x and y --> branch to lcm
		BNE maxp           ; If this condition fails, go to maxp

maxp ADD r3, r3, #1 ; increment max by 1
	 B nextx        ; Branch back to nextx and redo the loop

	 
lcm ADD r4, r4, r3    ; if we reached this point, r4 is our LCM
	B endif         ; Branch to endit to end the loop

endif
		
stop	B	stop			; Dead loop. Embedded program never exits.
;


; Note: I don't know why LDR doesn't load the correct values to the registers I used for the max and lcm
;		therefore, I had to improvise by using ADD to add the correct value I wanted to max and lcm with
;		both of those set to 0. Otherwise, the program works as intended

;
	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
x	DCD 0x00000004
y	DCD 0x00000006
max	DCD 0
rem DCD 0
	
	END
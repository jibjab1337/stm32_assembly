	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	; AREA    main, CODE, READONLY ;;;;;;;;;;;;;;;;;;;;change back if not working with strings
	AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Lab 5 code
    ; Assignment 5.5
	
	; Write an assembly program that removes all vowel letters (a, e, i , o, u, A, E, I, O, U) from a string.

	; Strings are loaded as ASCII characters
	; Each character is a byte in size
	; Each character needs to be loaded one at a time with a loop
	
	; ASCII values --> Uppercase: 65 to 90; Lowercase: 97 to 122
	;				   Lowercase letter - Uppercase equivalent = 32
	;					       a - A = 97 - 75 = 32
	; Hint:
	;
	; clear the bit when you find a vowel
	;
	; A = 65   E = 69  I = 73  0 = 79   U = 85	
	; a = 97   e = 101 i = 105 o = 111  u = 117

strcpy	LDR	r1, =myStr		; Retrieve address of the source string
		LDR	r0, =dstStr		; Retrieve address of the destination string
		
loop	LDRB r2, [r1], #1	; Load a byte & increase src address pointer  ; This is post-indexing --> r2 = r1 then r1 = r1 + 1

		; Check for "A, E, I, O, U"
		CMP r2, #65         ; We compare the character byte of r1 (myStr) to 65 because "A" is the first vowel in the ASCII table
		BEQ delet			; If character is = 65, we branch to the check loop
		CMP r2, #69         ; Check for "E"
		BEQ delet			; Go to delet if r2 = "E"
		CMP r2, #73         ; Check for "I"
		BEQ delet			; Go to delet if r2 = "I"
		CMP r2, #79         ; Check for "O"
		BEQ delet			; Go to delet if r2 = "O"
		CMP r2, #85         ; Check for "U"
		BEQ delet			; Go to delet if r2 = "U"		
		
		; check for "a, e, i, o, u"
		CMP r2, #97         ; Check for "a"
		BEQ delet			; Go to delet if r2 = "a"
		CMP r2, #101        ; Check for "e"
		BEQ delet			; Go to delet if r2 = "e"
		CMP r2, #105        ; Check for "i"
		BEQ delet			; Go to delet if r2 = "i"
		CMP r2, #111        ; Check for "o"
		BEQ delet			; Go to delet if r2 = "o"
		CMP r2, #117        ; Check for "u"
		BEQ delet			; Go to delet if r2 = "u"		
				
		B	else            ; If you reach this point, the character is clearly not a vowel so now it can go to else section
							; where it can be stored 
		
delet	SUB r2, r2, r2      ; r2 = r2 - r2 = 0 ---> This essentially deletes the value by turning it null
		ADD r2, r2, #95     ; r2 = 0 + 95 = 95 ---> 95 is the value for "_" and will be the placeholder for a "deleted" vowel  ----> THIS IS HOW I WILL "DELETE" THE VOWELS ----------------------
		B	else			; After we "delete" the vowel, we store that null by branching to else
							
else	STRB r2, [r0], #1	; Store a byte & increase dst address pointer ; This is post-indexing --> r2 = r0 then r0 = r0 + 1
		CMP	r2, #0			; Check for the null terminator				  ; This checks if r2 = 0. Strings end in 0 in assembly
		BNE	loop			; Copy the next byte if string is not ended	  ; If r2 does not equal 0, it goes back to start of label "loop"
		B	endif
			
endif	

stop	B	stop			; Dead loop. Embedded program never exits.

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
myStr	DCB	"An apple a day",0	; Strings are null terminated by ending with 0
dstStr	DCB	"                 ",0					; dststr has more space than srcstr

	END
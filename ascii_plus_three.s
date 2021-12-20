	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	; AREA    main, CODE, READONLY
	AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
	; Strings are loaded as ASCII characters
	; Each character is a byte in size
	; Each character needs to be loaded one at a time with a loop
	
	; ASCII values --> Uppercase: 65 to 90; Lowercase: 97 to 122
	;				   Lowercase letter - Uppercase equivalent = 32
	;					       a - A = 97 - 75 = 32
	
	; Write a program that takes a string and increases the value of the ASCII by 3 but ONLY the letters, no other characters
	; i.e "A" --> A, B, C, [D] --> "D" and so on

strcpy	LDR	r1, =myStr		; Retrieve address of the source string
		LDR	r0, =dstStr		; Retrieve address of the destination string

loop	LDRB r2, [r1], #1	; Load a byte & increase src address pointer  ; This is post-indexing --> r2 = r1 then r1 = r1 + 1
		
							; Check for values before A
		CMP r2, #65         ; We compare the character byte of r1 (myStr) to 65 because "A" is the first ASCII letter
		BGE check1			; If character is >= 65, we branch to the check1 loop
		B	else			; else, the character is less than 65 which means it's not a letter and will be stored to dstStr
			
							; include another check for 91 to 96 --> these are ASCII values in between the lowercase and uppercase letters in the ASCII table
check1	CMP r2, #91         ; We compare the character byte of r1 (myStr) to 91
		BGE check2			; If character is >= 91, we branch to the check2 loop to check for those non-letter ASCII values
		B 	convert			; else, the character is < 91 which means it must be within the range of 65 - 90 or an uppercase letter
		
check2	CMP r2, #96			; We compare character to 96 or the last ASCII value before the first uppercase letter "A"
		BLE else			; if r2 <= 96, we found a character between 91 to 96 so we will branch to else and store the character to dstStr
		B	upper			; else, that means r2 > 96 so we proceed to check for uppercase letters in the upper section				


upper	CMP r2, #122        ; We compare the character byte of r1 (myStr) to 122 because "z" is the last lowercase value 
							; If we reached upper, that must mean that we have a character in the range greater than 96 
		BLE convert			; If character is <= 122, we branch to the check loop
							; Our character must be within the range of 97 to 122 or a lowercase value
		B	else			; Else, our value is over 122 so we send it to else to store to dstStr
							
else	STRB r2, [r0], #1	; Store a byte & increase dst address pointer 	  ; This is post-indexing --> r2 = r0 then r0 = r0 + 1
		CMP	r2, #0			; Check for the null terminator				  	  ; This checks if r2 = 0. Strings end in 0 in assembly
		BNE	loop			; Go to the next byte if string is not ended	  ; If r2 does not equal 0, it goes back to start of label "loop"
		B	endif

convert LDR r3, =3       
		ADD r2, r2, r3 		; r2 = r2 + 3 = We are increasing the ASCII value of the letter character by 3
		STRB r2, [r0], #1   ; Stores the converted character byte of r2 to destination string r0 then increases address pointer of r0 by 1
		CMP r2, #0          ; Compare r2 to 0 for null operator check
		BNE loop 			; go back to loop if r2 /= 0 --> character has been converted and stored 
		B	endif			; If r2 byte is 0, we've reached the end of the string and can stop
endif		
		
stop	B	stop			; Dead loop. Embedded program never exits.    ; This stops the loop 

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
myStr	DCB	"Grazie Mille!",0			    ; Strings are null terminated by ending with 0
dstStr	DCB	"                       ",0		; dststr has more space than srcstr

	END
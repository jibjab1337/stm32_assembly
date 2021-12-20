	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	; AREA    main, CODE, READONLY
	AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 5 code
    ; Assignment 5.1
	
	; Write an Assembly program that converts all characters of a string to upper case
	
	; Strings are loaded as ASCII characters
	; Each character is a byte in size
	; Each character needs to be loaded one at a time with a loop
	
	; ASCII values --> Uppercase: 65 to 90; Lowercase: 97 to 122
	;				   Lowercase letter - Uppercase equivalent = 32
	;					       a - A = 97 - 75 = 32

strcpy	LDR	r1, =myStr		; Retrieve address of the source string
		LDR	r0, =dstStr		; Retrieve address of the destination string
		
loop	LDRB r2, [r1], #1	; Load a byte & increase src address pointer  ; This is post-indexing --> r2 = r1 then r1 = r1 + 1

		CMP r2, #97         ; We compare the character byte of r1 (myStr) to 97 because "a" is the first lowercase value
		BGE check			; If character is >= 97, we branch to the check loop
		B	else
		
check	CMP r2, #122
		BLE convert			; If character is <= 122, we branch to the convert loop --> we do this to make sure character is an
							; ASCII lowercase value from 97 to 122
						
							; If the character is greater than 122 or less than 97, it just stores that character in the destination
							; That way, we are sure that only letters are being converted and no other symbols
							
else	STRB r2, [r0], #1	; Store a byte & increase dst address pointer ; This is post-indexing --> r2 = r0 then r0 = r0 + 1
		CMP	r2, #0			; Check for the null terminator				  ; This checks if r2 = 0. Strings end in 0 in assembly
		BNE	loop			; Copy the next byte if string is not ended	  ; If r2 does not equal 0, it goes back to start of label "loop"
		B	endif

convert LDR r3, =32       
		SUB r2, r2, r3 		; r2 = r2 - 32 = Uppercase equivalent
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
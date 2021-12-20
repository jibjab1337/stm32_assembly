	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	; AREA    main, CODE, READONLY
	AREA string_copy, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 4 code
    ; Assignment 4.1
	
	; Strings are loaded as ASCII characters
	; Each character is a byte in size
	; Each character needs to be loaded one at a time with a loop

strcpy	LDR	r1, =srcStr		; Retrieve address of the source string
		LDR	r0, =dstStr		; Retrieve address of the destination string
loop	LDRB r2, [r1], #1	; Load a byte & increase src address pointer  ; This is post-indexing --> r2 = r1 then r1 = r1 + 1
		STRB r2, [r0], #1	; Store a byte & increase dst address pointer ; This is post-indexing --> r2 = r0 then r0 = r0 + 1
		CMP	r2, #0			; Check for the null terminator				  ; This checks if r2 = 0. Strings end in 0 in assembly
		BNE	loop			; Copy the next byte if string is not ended	  ; If r2 does not equal 0, it goes back to start of label "loop" --> Z = 0
stop	B	stop			; Dead loop. Embedded program never exits.    ; This stops the loop 

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
srcStr	DCB	"The source string.",0			; Strings are null terminated by ending with 0
dstStr	DCB	"The destination string.",0		; dststr has more space than srcstr

	END
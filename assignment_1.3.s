	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
    ; For code
	LDR r1, =x 
	LDR r2, [r1] 
	LDR r3, =y 
	LDR r4, [r3]
	LDR r5, =k 
	LDR r6, [r5] 
	SUBS r6, r2, r4
	STR r7, [r6];
 
; when using SUBS for x = y, the Z and C flags have a value of 1 entered
; which means that there is a zero present after performing SUBS.
; when Z = 1, that means that there's a zero present
; when C = 1, that means there's no carry over from the SUBS operation
;	this makes sense because x - y = 0 when x = y and thus there's no
;	leftover remainder to carry over


; when using SUBS for x < y, the N flag has a value of 1 entered 
; which means that there is a negative number present after SUBS.
  
stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
x	DCD 5 ; x = 4
y	DCD 5 ; y = 4
k	DCD 2 ; k is just 2	
	
	END
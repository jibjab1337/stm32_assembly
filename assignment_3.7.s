	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	; Lab 3 code
    ; Assignment 3.7
	
	; r0 = 0xFFFFFFFF
	; r1 = 0x00000001
	; r3 = 0x00000000
	
	; Initially, NZCV flags are zero
	; What is the result of the following operations?
	; Set all the flags to zero BEFORE each operation!
	; use MSR or MRS to reset flags and store flag value in a register
	
	; MRS: move from a special register to general register
	; MRS r0, apsr			; Read ASPR
	; MRS r0, xpsr			; Read APSR, IPSR and EPSR

	; MS: move from a general register to special register
	; MSR apsr_nscvqg, r0	; Change N, Z, C, V, Q, GE flags
	
	LDR r10, =a
	LDR r0, [r10]
	
	LDR r10, =b
	LDR r1, [r10]
	
	LDR r10, =c
	LDR r2, [r10]	
	MSR apsr_nzcvqg, r2 ;set the flags to 0
		
	ADD r3, r0, r2  ;store the flag values in r4
	MRS r4, xpsr
	MSR apsr_nzcvqg, r2
	
	SUBS r3, r0, r0 ;store the flag values in r5
	MRS r5, xpsr
	MSR apsr_nzcvqg, r2
	
	ADDS r3, r0, r2 ;store the flag values in r6
	MRS r6, xpsr
	MSR apsr_nzcvqg, r2
	
	LSL r3, r0, #1  ;store the flag values in r7
	MRS r7, xpsr
	MSR apsr_nzcvqg, r2
	
	LSRS r3, r1, #1 ;store the flag values in r8
	MRS r8, xpsr
	MSR apsr_nzcvqg, r2
	
	ANDS r3, r0, r2 ;store the flag values in r9
	MRS r9, xpsr
	MSR apsr_nzcvqg, r2	
	

stop 	B 		stop     		; dead loop & program hangs here

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
		
a	DCD	0xFFFFFFFF
b	DCD 0x00000001
c	DCD 0
	
	END
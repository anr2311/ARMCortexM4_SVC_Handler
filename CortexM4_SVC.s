		AREA RESET, CODE, READONLY
in      DCD 0x20000100,0x8000005D, 0,0,0,0,0,0,0,0,0,SVC_handler+1,0,0,0,0,0,0,0,0,0,0,0
		ENTRY
        
MAIN 	LDR R1,=0X20000200
		MSR PSP,R1 
	
		MOV R0,#3
		MSR CONTROL,R0
		
		LDR R7,=SRC
		LDR R1,[R7],#4
		LDR R2,[R7]
		LDR R8,=DST
		SVC 0x022 ; Making a SVC call

STOP    B STOP


SVC_handler push {lr}
			
			; Logic to retrieve the embedded SVC number in SVC instruction
			MRS R0, PSP
			LDR R0, [R0, #24]
			LDRB R0, [R0, #-2]
			CMP R0, #0x022 ; Compare if embedded SVC number is matching
			BEQ ADDITION ; If equal perform a particular task for that SVC
			pop {pc} ; If not equal do nothing and return back

ADDITION	ADD R8, R1, R2
			BX LR

SRC     DCD 0X30 ,0X20
        AREA RES ,DATA, READWRITE
DST     DCD 0,0
        END
		
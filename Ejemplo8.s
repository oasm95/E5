;-------------------Define el uso de instrucciones THUMB-----------
			THUMB
;------------------Define area para datos de 4 bytes---------------
			AREA 	DATA, ALIGN=4 
;------------------Declarar Variables -------------------------
RESUL		SPACE	4
;------Define área de codigo, con capacidad de ser importado C---------
			AREA	|.text|, CODE, READONLY, ALIGN=2
;--------------------Declara la instrucción Start como Global-----------			
			EXPORT	Start
;-----------------------------Codigo------------------------------------
Start	 	

		VMOV.F32 S0, #3

EXP		MOV R12, #1
		VMOV.F32 S30, #1
		VMOV.F32 S29, #1
EXP2		MOV R0, R12			
exponente	VMOV.F32 S1, #1
eloop		VMUL.F32 S1 ,S0	
		SUB R0, #1
		CMP R0, #0
		BEQ facta
		B eloop
			
			
facta		VMOV.F32 S3, S30     ; n a pasar factorial
		VMOV.F32 S4, #1		;llevara el resultado
		VMOV.F32 S5, #1		;constante para comparar y restar
			
FLOOP		VCMP.F32 S3, S5	
		VMRS APSR_nzcv, FPSCR
		BEQ FIN			
		VMUL.F32 S4, S3		
		VSUB.F32 S3, S5 
		B FLOOP
			
FIN			
		VDIV.F32 S31, S1,S4
		VADD.F32 S29, S31
		VADD.F32 S30, S5
		ADD R12, #1
		CMP R12, #8
		BEQ LOOP
		B EXP2


LOOP
		B LOOP
		ALIGN      
		END 

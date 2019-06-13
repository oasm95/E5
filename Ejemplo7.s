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
Start	 	LDR R0, = RESUL
			VLDR.F32 S0, =3.14159265
			VSTR.F32 S0, [R0]
			LDR R1, [R0]
			VLDR.F32 S1, [R0]
			
			VMOV.F32 S1, #3
			VMUL.F32 S1,S1,S1
			VMUL.F32 S2, S1, S0
			
			
			VSTR.F32 S2, [R0]
			VMOV.F32 S5, #5
			VMOV.F32 S2, #5
			VCMP.F32 S2,S5
			VMRS APSR_nzcv, FPSCR			
			BEQ LOOP
			B Start
LOOP
			B LOOP
			ALIGN      
			END 

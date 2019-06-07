			THUMB
			AREA 	DATA, ALIGN=4 
resultado	SPACE	4              
			AREA	|.text|, CODE, READONLY, ALIGN=2
			EXPORT	Start

Start		MOV R0, #1
			MOV R1 , R0
			MOV R4, #0
			CMP R4, #0
			BEQ fin2
			
Factorial	MUL R1,R0
			ADD R0, #1
			CMP R0 , #3; FACTORIAL DE N+1, 
			BHS fin
			B 	Factorial

fin2		MOV R1, #1
fin			LDR R3, =resultado
			STR R1, [R3]
			B Start
			
			ALIGN      
			END 
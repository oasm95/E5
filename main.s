			THUMB
			AREA 	DATA, ALIGN=4 
cont		SPACE	4              
			AREA	|.text|, CODE, READONLY, ALIGN=2
			EXPORT	Start

Start		MOV R1, #0x1F
			MOV R2, #0X1A00
			MOV R3, R1
			
			LDR R0 ,=cont
			LDR R4 , [R0]
			
			ORR R1, R2 ; R1 = R1 = 0X1A1F
			
			STR R1, [R0]
			
			LDR R4,[R0]

			
			ALIGN      
			END 
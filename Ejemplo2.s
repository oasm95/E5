			THUMB
			AREA 	DATA, ALIGN=4 
cont		SPACE	4              
			AREA	|.text|, CODE, READONLY, ALIGN=2
			EXPORT	Start

			
Start		MOV R1, #1
cuenta		ADD R1, #1
			MUL R1, #10
			CMP R1, #10
			BEQ fin
			B cuenta

fin			LDR R0, =cont
			STR R1, [R0]
			B Start

			
			ALIGN      
			END 

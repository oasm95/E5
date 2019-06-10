;-------------------Define el uso de instrucciones THUMB-----------
			THUMB
;------------------Define area para datos de 4 bytes---------------
			AREA 	DATA, ALIGN=4 
;------------------Declarar Variables -------------------------
cont			SPACE	4
;------Define área de codigo, con capacidad de ser importado C---------
			AREA	|.text|, CODE, READONLY, ALIGN=2
;--------------------Declara la instrucción Start como Global-----------			
			EXPORT	Start
;-----------------------------Codigo------------------------------------
Start			MOV R1, #0x1F; 		R1 = 0x1F
			MOV R2, #0X1A00; 	R2 = 0x1A00
			MOV R3, R1;		R3 = R1
			
			LDR R0 ,=cont		; R0 = &cont, Guarda la direccion en donde se encuentra la variable cont en R0
			LDR R4 , [R0]		; R4 = *R0,  Carga el valor de la variable cont en R4 
			
			ORR R1, R2 		; R1 = R1 OR R2 = 0X1A1F
			
			STR R1, [R0]		; *R0 = R1, Guarda el valor de R1 en la direccion de R0
			
			LDR R4,[R0]		; R4 = *R0,  Carga el valor de la variable cont en R4 

			
			ALIGN      
			END 

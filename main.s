; Implementacion de la funcion factorial, guarda el resultado de factorial en una variable

;-------------------Define el uso de instrucciones THUMB-----------
		THUMB
;-----------Define area para datos de 4 bytes---------------
		AREA 	DATA, ALIGN=4 
;-----------Declarar Variables -------------------------
resultado	SPACE	4
;----------Define área de codigo, con capacidad de ser importado C---------
		AREA	|.text|, CODE, READONLY, ALIGN=2
;----------Declara la instrucción Start como Global-----------			
		EXPORT	Start
;----------------------Codigo------------------------------------


Start   

Int_PF		LDR R1, =0X400FE608
			LDR R0 , [R1]
			ORR R0, #0X20
			STR R0, [R1]
			NOP
			NOP
			NOP
;---------DESACTIVAR FUNCIONES ANALOGICAS AMSEL			
			LDR R1, =0X40025000; DIRECCION BASE PUERTO F
			LDR R0, [R1,#0X528]
			BIC R0, #0XFF
			STR R0, [R1,#0X528]
;--------ASIGNAR ENTRADAS Y SALIDAS, DIR---
			LDR R0, [R1, #0X400]
			ORR R0, #0X0E; PIN 2,3,4 COMO SALIDAS
			STR R0, [R1,#0X400]
;-----ASIGNAR FUNCION ALTERNATIVA,PCTL (GPI0 = 0)
			MOV R0, #0
			STR R0, [R1, #0X52C]
;-----DESABILITAR FUNCION ALTERNATIVA, AFSEL
			LDR R0, [R1, #0X420]
			BIC R0, #0XFF
			STR R0, [R1, #0X420]
;-------HABILITAR FUNCIONES DIGITALES, DEN
			LDR R0, [R1, #0X51C]
			ORR R0, #0X1E
			STR R0, [R1, #0X51C]
;-------HABILITAR RESISTENCIA PULL UP, PUR
			LDR R0, [R1, #0X510]
			ORR R0, #0X10
			STR R0, [R1, #0X510]

;-------PRENDER LEDS---------
LOOP

LEER		
			LDR R0, [R1, #0X3FC]
			AND R0 , #0X10
			CMP R0 , #0X00
			BEQ CONT			
			B LEER
			
CONT		LDR R4, =0X82355
			MOV R3, #0
CNT			ADD R3, #1
			CMP R3, R4
			BEQ LEER2
			B CNT
			
LEER2		
			LDR R0, [R1, #0X3FC]
			AND R0 , #0X10
			CMP R0 , #0X10
			BEQ CAMBIO			
			B LEER2

CAMBIO		LDR R0, [R1, #0X3FC]
			EOR R0, #0X0E
			STR R0, [R1, #0X3FC]
			
			B LEER

		ALIGN      
		END 
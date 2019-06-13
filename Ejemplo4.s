; Inicializacion de puerto F, Habilitar pines PF 1, 2 y 3 como salidas y encender los tres pines.
; Para encender una luz blanca
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
		LDR R1, =0X40025000	;DIRECCION BASE PUERTO F
		LDR R0, [R1,#0X528]	;OFFSET REGISTRO AMSEL
		BIC R0, #0XFF		;ASIGNA CEROS AL BYTE MENOS SIGNIFICATIVO
		STR R0, [R1,#0X528]
;--------ASIGNAR ENTRADAS Y SALIDAS, DIR---
		LDR R0, [R1, #0X400]	
		ORR R0, #0X0E		; PIN 2,3,4 COMO SALIDAS
		STR R0, [R1,#0X400]
;-----ASIGNAR FUNCION ALTERNATIVA,PCTL (GPI0 = 0)
		MOV R0, #0		; 0 EN ESTE REGISTRO REPRESENTA GPIO
		STR R0, [R1, #0X52C]
;-----DESABILITAR FUNCION ALTERNATIVA, AFSEL
		LDR R0, [R1, #0X420]
		BIC R0, #0XFF		;ASIGNA CEROS AL BYTE MENOS SIGNIFICATIVO
		STR R0, [R1, #0X420]
;-------HABILITAR FUNCIONES DIGITALES, DEN
		LDR R0, [R1, #0X51C]
		ORR R0, #0X0E		;HABILITA LOS PINES 1,2,3 (0000 1110 = 0X0E)
		STR R0, [R1, #0X51C]

;-------PRENDER LEDS---------
LOOP
		LDR R0, [R1, #0X3FC]	;OFFSET AL REGISTRO DE DATA DE TODOS LOS PINES DE UN PUERTO
		ORR R0, #0X0E		;ENCIENDE LOS PINES 1,2,3 (0000 1110 = 0X0E)
		STR R0, [R1, #0X3FC]	;GUARDA EL VALOR EN EL REGISTRO DE DATA Y ENCIENDE LOS PINES
		B LOOP
		ALIGN      
		END 

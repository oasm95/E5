GPIO_PORTF_BASE EQU 0X40025000
GPIO_PORTD_BASE EQU 0X40007000
GPIO_PORTB_BASE EQU 0X40005000
;-------------------Define el uso de instrucciones THUMB-----------
		THUMB

;----------Define área de codigo, con capacidad de ser importado C---------
		AREA	|.text|, CODE, READONLY, ALIGN=2
;----------Declara la instrucción Start como Global-----------			
		EXPORT	Int_PF
;----------------------Codigo------------------------------------

  

Int_PF		LDR R1, =0X400FE608
			LDR R0 , [R1]
			ORR R0, #0X04
			STR R0, [R1]
			NOP
			NOP
			NOP
;---------DESACTIVAR FUNCIONES ANALOGICAS AMSEL			
			LDR R1, =GPIO_PORTB_BASE; DIRECCION BASE PUERTO F
			LDR R0, [R1,#0X528]
			BIC R0, #0XFF
			STR R0, [R1,#0X528]
;--------ASIGNAR ENTRADAS Y SALIDAS, DIR---
			LDR R0, [R1, #0X400]
			ORR R0, #0X3F; PIN 2,3,4 COMO SALIDAS
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
			ORR R0, #0X3F
			STR R0, [R1, #0X51C]
;-------HABILITAR RESISTENCIA PULL UP, PUR
			BX LR

		ALIGN      
		END 

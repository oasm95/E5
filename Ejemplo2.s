; Un contador que cuenta hasta 10 y guarda el valor del contador en una variable


;-------------------Define el uso de instrucciones THUMB-----------
		THUMB
;-----------Define area para datos de 4 bytes---------------
		AREA 	DATA, ALIGN=4 
;-----------Declarar Variables -------------------------
cont		SPACE	4
;----------Define área de codigo, con capacidad de ser importado C---------
		AREA	|.text|, CODE, READONLY, ALIGN=2
;----------Declara la instrucción Start como Global-----------			
		EXPORT	Start
;----------------------Codigo------------------------------------

Start		MOV R1, #1	;R1 = 1
cuenta		ADD R1, #1	;R1 = R1+1
		CMP R1, #10	; compara el R1 y 10 y actualiza las banderas 
		BEQ fin		; si son iguales(EQ) R1 Y el valor comparado, salta hacia "fin", sino ejecuta la siguiente instruccion
		B cuenta	; salta a cuenta

fin		LDR R0, =cont	;R0 = *cont, guarda la direccion del espacio de memoria asignado a la variable cont
		STR R1, [R0]    ;cont = R1, asigna el valor de R1 a la localidad de memoria que apunta R0 
		B Start		; regresa Start

			
		ALIGN      
		END
	

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

;R1 = resultado de factorial
;R0 = contador
;R4 = el valor a calcular factorial N+1, si deseo calcular de 4 se debe de sumar 1, 4+1, colocar 5

Start		MOV R0, #1	;R0 = 1
		MOV R1 , R0	;R1 = R0
		MOV R4, #5	;R4 = 5	
		CMP R4, #0	;realiza una comparacion entre R4 y 0
		BEQ fin2	; Si son iguales salta hacia fin2 
			
Factorial	MUL R1,R0	;R1 = R1*R0, multiplica de factorial con el contador
		ADD R0, #1	;R0 = R0 +1
		CMP R0 , R4;  	; Si el contador es igual al valor deseado de factorial
		BEQ fin		; el programa salta hacia fin
		B Factorial	;sino realiza otra iteracion

fin2		MOV R1, #1	; si se desea calcular el factorial de 0 automaticamente se le asigna al resultado un valor de 1, 0!=1
fin		LDR R3, =resultado ; R3 = &resultado, guarda la direccion del espacio de memoria asignado a la variable resultado en R3
		STR R1, [R3]	;asigna el valor de R1 a la localidad de memoria que apunta R3
		B Start
			
		ALIGN      
		END 

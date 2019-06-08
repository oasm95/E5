; Implementacion de la funcion factorial, guarda el resultado de factorial en una variable
; Esta version utiliza el sufijo S en la instruccion SUB
; Se implementan condicionales dependiendo de banderas
; Se optimiza respecto a el ejemplo 3, y calcula el factorial de valor exacto especificado

;-------------------Define el uso de instrucciones THUMB-----------
	  THUMB
;-----------Define area para datos de 4 bytes---------------
	  AREA 	DATA, ALIGN=4 
;-----------Declarar Variables -------------------------
resultado SPACE	4
;----------Define área de codigo, con capacidad de ser importado C---------
	  AREA	|.text|, CODE, READONLY, ALIGN=2
;----------Declara la instrucción Start como Global-----------			
	  EXPORT	Start
;----------------------Codigo------------------------------------

;R1 = resultado de factorial
;R4 = el valor a calcular factorial,

Start	  MOV R1, #1	    ;R1 = 1
          MOV R4, #5	    ;R4 = 5	
          CMP R4, #0	    ;realiza una comparacion entre R4 y 0
          BEQ fin2	      ;Si son iguales salta hacia fin2 
			
Factorial MUL R1,R4	      ;R1 = R1*R4
          SUBS R4, #1	    ;R4 = R4 - 1, el sufijo S en SUB, actualiza las banderas del registro SPR
          BEQ fin	    ;Como CMP Rn, Rd = SUB Rn, Rd, al obtener un cero de resultado la condicion EQ correspondiente a Z = 1, realiza el salto
          B Factorial	    ;sino realiza otra iteracion

fin2	  MOV R1, #1	    ;si se desea calcular el factorial de 0 automaticamente se le asigna al resultado un valor de 1, 0!=1
fin       LDR R3, =resultado ; R3 = *resultado, guarda la direccion del espacio de memoria asignado a la variable resultado en R3
          STR R1, [R3]	  ;asigna el valor de R1 a la localidad de memoria que apunta R3
          B Start

          ALIGN      
          END 

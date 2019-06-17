;Implementacion de funcion exponencial mediante subrutinas
;-------------------Define el uso de instrucciones THUMB-----------
			THUMB
;------------------Define area para datos de 4 bytes---------------
			AREA 	DATA, ALIGN=4 
;------------------Declarar Variables -------------------------
RESUL		SPACE	4
;------Define área de codigo, con capacidad de ser importado C---------
			AREA	|.text|, CODE, READONLY, ALIGN=2
;--------------------Declara la instrucción Start como Global-----------			
			EXPORT	Start
;-----------------------------Codigo------------------------------------
Start	 	
LOOP
	  VMOV.F32 S0, #3		; ASIGNA EL VALOR DE 3 A ENTRADA DE SUBRUTINA MATH_Exponential 
	  BL MATH_Exponential	; CALCULA EL VALOR DE e^3, llamando a la subrutina MATH_Exponential
	  LDR R0, =RESUL
	  VSTR.F32 S0, [R0]	; GUARDA EL RESULTADO EN LA VARIABLE RESUL, 20.0855
	  B LOOP

;-------------------------------		
;-Funcion exponente, S1 = S0^R0-
;-Entrada:	S0,R0	       -
;-S0 BASE		       -	
;-R0 EXPONENTE		       -
;-SALIDA :	S1	       -
;-S1 RESULTADO		       -
;-------------------------------
MATH_Exp  VMOV.F32 S1, #1
Exp_LOOP  VMUL.F32 S1 ,S0	
	  SUBS R0, #1
	  BNE Exp_LOOP			
	  BX LR
;--------------------------------			
;-Funcion factorial, S0 = R0!   -
;-Entrada: R0			-
;-R0 Numero a calcular factorial-
;-Salida:  S0			-
;-S0 Resultado			-
;-Modifica: S1,S2		-
;--------------------------------
MATH_Fac  VMOV.F32 S1, #1		;contador
	  VMOV.F32 S0, #1		;llevara el resultado
	  VMOV.F32 S2, #1		;constante para sumar			
Fac_LOOP	
	  VMUL.F32 S0, S1
	  VADD.F32 S1, S2
	  SUBS R0, #1
	  BNE Fac_LOOP
	  BX LR
;--------------------------------
;-Funcion Exponencial, S0 = e^S0-
;-Entrada: S0			-
;-S0 Exponente			-
;-Salida: S0			-
;-S0 Resultado			-
;-Modifica: S4, S2 		-
;--------------------------------
MATH_Exponential
;La funcion exponcial esta dada por:
; e^x = 1 + Sumatoria_hasta_Infinito(X^n/n!), inicializando n=1
;en este caso solo se haran 16 iteraciones
          PUSH {R4,LR}; COMO UTILIZA OTRAS SUBRUTINAS EN SU EJECUCION Y ALTERA EL REGISTRO R4, 
                      ;SE DEBEN DE AGREGAR A LA PILA, PARA MANTENER EL ORDEN DE EJECUCION Y NO ALTERAR EL FUNCIONAMIENTO
                      ;DEL PROGRAMA (AAPCS)
          MOV R4, #15; Contador de Iteracion, n
          VMOV.F32 S2, #1; SUMATORIA
          VMOV.F32 S4, S0; GUARDA EL VALOR DE BASE, X
Exponential_LOOP
          VMOV.F32 S0, S4; ASIGNA EL VALOR DE ENTRADA PARA SUBRUTINA MATH_EXP, S0 Y R0 (X y n)
          MOV R0, R4
          BL MATH_Exp		; RESULTADO EN S1
          VPUSH {S1,S2};  COMO LA SUBRUTINA MATH_FAC MODIFICA LOS REGISTROS S1 Y S2,(RESULTADO DE EXP Y VALOR DE SUMATORIA)
                       ;  GUARDA ESTOS REGISTROS EN LA PILA
          MOV R0, R4		; ASIGNA VALOR DE ENTRADA PARA SUBRUTINA FACTORIAL, R0, (n)
          BL MATH_Fac
          VPOP {S1,S2}	; RESTAURA EL VALOR DE S1 Y S2(RESULTADO DE EXP Y VALOR DE SUMATORIA), DESDE LA PILA
          VDIV.F32 S1,S0  ; S1 = X^n/n!
          VADD.F32 S2,S1	; S2 = S2 + X^n/n!
          SUBS R4, #1
          BNE Exponential_LOOP			
          VMOV.F32 S0,S2
          POP {R4,PC}

          ALIGN      
          END 

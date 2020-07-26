#autor: Jorge Tillería 
#en conjunto con Alejandro Maciel

.data
uno: .double 1
x: .double -2.5132
n: .word 3
grado: .asciiz "[PROGRAMA]: ¿Grado del Polinomio?\n"
usuario: .asciiz "[USUARIO]:         "
enter: .asciiz "\n"
interr: .asciiz "?\n"
coef: .asciiz "[PROGRAMA]: ¿Coeficiente de x^"
punto: .asciiz "\n[PROGRAMA]: ¿Punto a evaluar?\n"
programend: .asciiz "[PROGRAMA]: FIN"
imprefinal: .asciiz "[PROGRAMA]: p("
parentesis: .asciiz ")="
vector: .byte 0

.text


#imprimir grado del polinomio
li $v0, 4 
la $a0, grado
syscall

#entrada del grado
la $a0, usuario
syscall
li $v0, 5
syscall
move $s1, $v0


#carga de coeficientes
li $t0, -1 #contador
for1:
	#impresion de mensaje de la computadora
	addi $t0, $t0,1 # t0++
	li $v0, 4
	la $a0, coef
	syscall
	li $v0, 1
	sub $t1, $s1, $t0 #t1 = $s1 - $t0
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, interr
	syscall
	
	#entrada del valor
	la $a0, usuario
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
	sb $t2, vector($t0)

	bne $t0, $s1, for1 #branch not equal	
#end for

#evaluacion de los puntos
while:
	li $v0, 4
	la $a0, punto
	syscall
	la $a0, usuario #imprime usuario
	syscall
	#entrada de número a evaluar
	li $v0, 5
	syscall
	move $a0, $v0
	beq $a0, -999, end #branch equal
	
	li $t0, -1 #contador
	li $t3, 0 #acumulador del resultado final
	for2:
		addi $t0, $t0, 1
		sub $a1, $s1,$t0
		#potencia
		jal potencia # potencia($a0, $a1)  (x, exponente)
		lb $t1, vector($t0)
		mul $t2, $t1, $v0 #coeficiente*(potencia de la entrada)
		add $t3, $t3, $t2

		bne $t0, $s1, for2
	move $t4, $a0
	li $v0, 4
	la $a0, imprefinal
	syscall
	
	move $a0, $t4
	li $v0, 1
	syscall
	
	li $v0,4
	la $a0,parentesis
	syscall
	
	li $v0, 1
	la $a0, ($t3)
	syscall
	
	j while

	
end:
#fin
li $v0, 4
la $a0, programend
syscall
li $v0, 10
syscall



#funcion potencia entera, realiza la potencia n de una base 
#input a0, a1
#output v0
potencia:
	beq $a1, $0, excepcion
	#guardamos los valores de los registros temporales en sp
	addi $sp, $sp, -8
	sb $t1, 4($sp)
	sb $t0, ($sp)
	#asignamos como contador y acumulador a t0 y t1 respectivamente
	li $t0, 0
	li $t1, 1
	#multiplicacion sucesiva
	whilepotencia:
		mul $t1, $t1, $a0
		addi $t0, $t0, 1
		bne $t0, $a1, whilepotencia
	move $v0, $t1 #guardo mi resultado en v0
	#se devuelven los valores originales a t0, t1 y sp
	lb $t0, ($sp)
	lb $t1, 4($sp)
	addi $sp, $sp, 8
	
	jr $ra
	excepcion: #QUERIDO GAGLIA: se agregó esa excepcion para cuando el indice de entrada sea 0 porque no cumplia la salida del while y quedaba en un loop 
		li $v0, 1
		jr $ra
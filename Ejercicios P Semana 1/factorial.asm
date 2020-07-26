.data
n : .word 8
c1: .asciiz "!="
c2 :.asciiz "\n"

.text
    li  $v0, 1      #servicio para imprimir entero
    lw $a0, n		#se carga el entero n a imprimir
    syscall			#se imprime n
    jal factorial	#se llama a la funcion factorial (el registro $a0 ya contiene el valor)
    move $t1, $v0	#se guarda el valor del factorial en $t1
    
    li $v0, 4 		#servicio para imprimir cadenas
    la $a0, c1		#se imprime "!="
    syscall
	
	li  $v0, 1      #servicio para imprimir entero
    move $a0, $t1	#se carga el factorial de n
    syscall			#se imprime el n!

	li $v0, 4 		#servicio para imprimir cadenas
    la $a0, c2		#se imprime un salto de linea
    syscall
    
    li  $v0, 10     #servicio para terminar
    syscall  		#fin de programa

## factorial recursivo (para numeros peque�os)
## int factorial(int n)
## { if (n==0) return 1;
## return n*fact(n-1);
##}
# Entrada a0 => n
# Salida  v0 => n!

factorial:
addi $sp, $sp, -8 # se reserva lugar en el stack
sw $s0, 0($sp)	  # se guarda el valor del registro $s0
sw $ra, 4($sp)	  # se guarda el valor del registro $ra

move $s0, $a0	  # se guarda el valor de n en una variable para poder hacer n*factorial(n-1)
bne  $s0, $zero, noigual # se verifica si se llega al caso base n==0

addi $v0, $zero, 1	#caso base
j fin				#termina funcion

noigual:
addi $a0, $a0, -1	# se disminuye en 1 el parametro para factorial 
jal factorial		# factorial(n-1)
mult $s0, $v0		# n*factorial(n-1)
mflo $v0			# se guarda n*factorial(n-1) en $v0 (return value)


fin:
lw $s0, 0($sp)	  # se restaura el valor del registro $s0
lw $ra, 4($sp)	  # se restaura el valor del registro $ra
addi $sp, $sp, 8  # se libera el espacio del stack
jr $ra			  # se salta a la linea siguiente de donde fue llamado el procedure	

#Escriba la función char *quitar(char *s1, char *s2), que eliminar de la cadena s1 todos los
#caracteres que se encuentran en s2. Retorna la dirección de inicio de s1.

.data
cadena1: .asciiz "hola hhhollla"  #oa oa/0
cadena2: .asciiz "hllx"

.text
main:
	la $a0, cadena1 #puntero que apunta al primer valor de cadena1
	la $a1, cadena2 #puntero que apunta al primer valor de cadena2
	
	jal quitar
	
	#imprimir el resultado
	li $v0, 4
	la $a0, cadena1
	syscall
	
	#end
	li $v0, 10
	syscall
	
quitar:
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	
	li $t0, 0
	li $t1, 0
	while:
		la $s0, cadena1($t0)
		la $s1, cadena2($t1)
	volver:
		lb $t2, ($s0)
		lb $t3, ($s1)	
		beq $t2, $t3, cambiar #modificar el ra para que vuelva 1 antes
		
		addi $t0, $t0, 1
		lb $t2, cadena1($t0)
		bnez $t2, while
		
		addi $t1, $t1, 1
		lb $t3, cadena1($t1)
		bnez $t3, if
		
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
		
		if:
			li $t0, 0
			b while
			
# cadena1($t0) es el valor actual de la cadena 1
# cadena2($t1) es el valor actual de la cadena 2
					
cambiar:  
	addi $t2, $t0, 0 #nuevos contadores
	while2:
		la $t3, cadena1($t2)
		lb $t4, cadena1+1($t2)
		sb $t4, ($t3)
		addi $t2, $t2, 1
		bnez $t4, while2
		
	b volver
#https://www.geeksforgeeks.org/program-for-nth-fibonacci-number/

.data
imprimir1: .asciiz "Incorrect input."
uno: .word 1
numero: .word 9




.text
main:
	lw $t0, numero
	move $a0, $t0
	jal fibonacci
	
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall



#input: int(n) $a0
#output: $v0
fibonacci:
	#guardar las s a utilizar en sp
	add $sp, $sp, -4
	sw $ra, ($sp)
	
	#incorrect input
	slt $t1, $a0, $0 #si el numero es menor a cero t1 = 1
	bne $t1, $0, incorr# si t1 != 0 se va a incorrecto
	
	beq $a0, $0, termina0
	
	lw $t2, uno
	beq $a0, $t2, termina1
	
	sub $a0, $a0, 1
	jal fibonacci
	move $t3, $v0
	sub $a0, $a0, 1
	
	jal fibonacci
	move $t4, $v0
	
	add $v0, $t3, $t4
	
	lw $ra, ($sp)
	add $sp, $sp, 4
	
	jr $ra
	
	termina0:
		li $v0, 0
		lw $ra, ($sp)
		add $sp, $sp, 4
		jr $ra
	termina1:
		li $v0, 1
		lw $ra, ($sp)
		add $sp, $sp, 4
		jr $ra
	
	incorr:
		li $v0, 4
		la $a0, imprimir1
		syscall
		li $v0, 10
		syscall
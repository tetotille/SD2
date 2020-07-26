#Autores: Jorge Tillería, Alejandro Maciel y Julio Avalos
.data
	a : .word 255
	bb : .word 16
	numero: .asciiz "0"
	letra: .asciiz "a"
	restos: .space 100
.text
main:
	lw $a0, a
	lw $a1, bb
	jal itoa
	move $a0, $v0
	li $v0, 4
	syscall
	li $v0, 10#fin de programa
	syscall
	

#input : $a0, $a1    int(v), base(b)	
#output : $v0       char(numero en base b)
itoa:
	#guardar todos los registros auxiliares
	addi $sp, $sp, -16
	sw $t0, ($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	
	###################################
	li $t0, 100
	# División sucesiva
	while:
		divu $a0, $a1 #resto en hi, cociente en lo
		mfhi $t1 #resto
		mflo $t2 #cociente
		
		blt $t1, 10, menor
		#mayor
		subu $t3, $t1, 10
		lb $t4, letra
		add $t3, $t4, $t3
		j minifin
		
		menor:
		lw $t4, numero
		add $t3, $t4, $t1 #se guarda en t3, ascii de 0 + el resto de la division
		
		minifin:
		sb $t3, restos($t0)
		addi $t0,$t0,-1
		
		move $a0, $t2 
		bnez $t2, while
	addi $t0,$t0,1
	la $v0, restos($t0)
	#recuperar todos los registros auxiliares
	lw $t0, ($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	lw $t4, 16($sp)
	addi $sp, $sp, 16
	
	jr $ra
	
	
		
	
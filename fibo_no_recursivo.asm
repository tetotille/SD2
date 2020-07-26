#fibonacci no recursivo
#1,1,2,3,5,8,13,

.data
entrada: .asciiz "Inserte el valor: "


.text

main:
	li $v0, 4
	la $a0, entrada
	syscall
	
	li $v0, 5
	syscall
	move $a0, $v0
	
	jal fibo
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10 #termina el programa
	syscall 
	
fibo:
	li $t0, 0
	li $t1, 1
	li $t2, 0
	
	slti $t4, $a0, 2
	bne $t4, $0, if
	
	while:
		slt $t4, $t2, $a0
		beq $t4, $0, end
		
		addi $t2, $t2, 1
		add $t3, $t0, $t1
		move $t0, $t1
		move $t1, $t3	
		b while
	end:
		move $v0, $t1
		jr $ra

	if:
		li $v0, 1
		jr $ra


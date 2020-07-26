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
	li $t0, 0 # fibo(n-1)
	li $t1, 1 # fibo(n)
	li $t2, 0 # contador
	
	slti $t4, $a0, 2 # si n < 2, t4 = 1
	bne $t4, $0, if # si t4 = 1 (si n < 2)
	# si n >= 2
	while:
		slt $t4, $t2, $a0 # t4 = 1 si contador < n
		beq $t4, $0, end # si contador = n, end
		
		addi $t2, $t2, 1 # contador = contador + 1
		add $t3, $t0, $t1 # t3 = t0+t1
		move $t0, $t1
		move $t1, $t3	
		b while
	end:
		move $v0, $t1 # t1 = fibo(n)
		jr $ra

	if:
		li $v0, 1
		jr $ra

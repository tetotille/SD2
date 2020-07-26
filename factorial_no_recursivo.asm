#factorial
.data
entrada: .asciiz "Ingrese el valor del factorial\n"

.text

main:
#entrada de valor por teclado
li $v0, 4
la $a0, entrada
syscall
li $v0, 5
syscall
move $s0, $v0

#llamar a funcion factorial
move $a0, $s0
jal factorial
move $a0, $v0
li $v0, 1
syscall

#fin
li $v0, 10
syscall


factorial:
add $sp, $sp, -4
sw $s0, ($sp)
li $s0, 1 #acumulador = 1
li $t0, 0
for:
	addi $t0, $t0, 1
	mul $s0, $s0, $t0
	bne $t0, $a0, for
	
move $v0, $s0
lw $s0, ($sp)
add $sp, $sp, 4
jr $ra









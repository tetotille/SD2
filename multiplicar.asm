#multiplicar dos numeros de 32 bits usando sumas
.data
a: .word 303
bb: .word 100
cero: .double 0

.text
main:
	lw $s1, a
	lw $s0, bb
	jal multiplicar
	
	mtc1 $v0, $f12
	mtc1 $v1, $f13
	li $v0, 3
	syscall
	
	li $v0, 10
	syscall
	
	
multiplicar:
	mtc1 $s1, $f0
	cvt.d.w $f2, $f0
	li $t0, 0 #t0 = 0
	ldc1 $f4, cero
	for:
		addi $t0, $t0, 1
		add.d $f4, $f4, $f2
		bne $t0, $s0, for
	mfc1 $v0, $f4
	mfc1 $v1, $f5
	jr $ra
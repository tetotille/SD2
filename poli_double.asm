.data
c1: .asciiz "[PROGRAMA]: ¿Grado del Polinomio?\n"
c2: .asciiz "[USUARIO]:         "
c3: .asciiz "[PROGRAMA]: ¿Coeficiente de ^"
c4: .asciiz "?\n"
c5: .asciiz "[PROGRAMA]: ¿Punto a evaluar?\n"
c6: .asciiz "[PROGRAMA]: p("
c7: .asciiz ")="

fin: .double -999
uno: .double 1
cero: .double 0
vector: .double 0 #tienen 8 posiciones de memoria

.text
li $v0, 4
la $a0, c1
syscall
la $a0, c2
syscall

li $v0, 5
syscall
move $s0, $v0#s0 grado del polinomio

li $t0, 0
li $t2, 0 #contador de vector
while:
	li $v0, 4
	la $a0, c3
	syscall
	
	sub $t1, $s0, $t0 # contador descendente
	li $v0, 1
	addi $a0, $t1, 0
	syscall
	
	li $v0, 4
	la $a0, c4
	syscall
	
	la $a0, c2
	syscall
	
	li $v0, 7
	syscall
	
	sdc1 $f0, vector($t2) #guarda f0 en el vector
	addi $t2, $t2, 8
	addi $t0, $t0, 1
	
	slt $t3, $s0, $t0 # si a0 < t0, t3 = 1 llego a su fin
	beqz $t3, while
	
while2:
	li $v0, 4
	la $a0, c5
	syscall
	la $a0, c2
	syscall
	
	li $v0, 7
	syscall
	
	ldc1 $f2, fin
	c.eq.d $f2, $f0
	bc1t end
	
	ldc1 $f10, cero
	add.d $f2, $f0, $f10 #copia de nuestra entrada
	
	li $t0, 0
	li $t1, 0 #contador del vector
	ldc1 $f6, cero
	for:	
		mfc1 $a0, $f0
		mfc1 $a1, $f1
		
		sub $a2, $s0, $t0
		jal potencia #resultado doble en v0 v1
		
		mtc1 $v0, $f0
		mtc1 $v1, $f1
		
		ldc1 $f4, vector($t1) #coeficientes
		
		mul.d $f0, $f0, $f4 #resultado de la potencia * coeficiente correspondiente
		add.d $f6, $f6, $f0 #acumulador

		addi $t0, $t0, 1
		addi $t1, $t1, 8
		
		slt $t3, $s0, $t0 # si a0 < t0, t3 = 1 llego a su fin
		beqz $t3, for
	
	li $v0, 4
	la $a0, c6
	syscall
	
	li $v0, 3
	mov.d $f12, $f2
	syscall
	
	li $v0, 4
	la $a0, c7
	syscall
	
	li $v0, 3
	mov.d $f12, $f6
	syscall
	
	b while2
end:
li $v0, 10
syscall
		
#funcion potencia entera, realiza la potencia n de una base 
# x con complejidad O(n)
#inputs: $a0, a1 => base x (double)
#	     $a2 => potencia entera n (int)
#outputs:$v0, $v1 => resultado x^n (double)


potencia:
addi $sp, $sp, -24 # se reserva lugar en el stack
sw $ra, 0($sp)	  # se guarda el valor del registro $s0
swc1 $f0, 4($sp)	  # se guarda el valor del registro $f0
swc1 $f1, 8($sp)	  # se guarda el valor del registro $f1
swc1 $f12, 12($sp)	  # se guarda el valor del registro $f2
swc1 $f13, 16($sp)	  # se guarda el valor del registro $f2
sw $t0, 20($sp)

mtc1 $a0, $f0
mtc1 $a1, $f1

add $t0, $zero, $a2

ldc1 $f12, uno

for2:
beqz $t0, fin2
mul.d $f12, $f12, $f0
subi $t0, $t0, 1
b for2

fin2:
mfc1.d $v0, $f12

lw $ra, 0($sp)	  # se guarda el valor del registro $s0
lwc1 $f0, 4($sp)	  # se guarda el valor del registro $f0
lwc1 $f1, 8($sp)	  # se guarda el valor del registro $f1
lwc1 $f12, 12($sp)	  # se guarda el valor del registro $f2
lwc1 $f13, 16($sp)	  # se guarda el valor del registro $f2
lw $t0, 20($sp)
addi $sp, $sp, 24 # se libera lugar en el stack
jr $ra			  # se salta a la linea siguiente de donde fue llamado el procedure	

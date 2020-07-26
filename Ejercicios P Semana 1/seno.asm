.data
x:     .double 0.1
delta: .double 0.00000001
c1: .asciiz "sen("
c2: .asciiz ")="
c3: .asciiz "\n"

dosPI: .double 6.283185307179586476925286766559
PI: .double 3.1415926535897932384626433832795
PId2: .double 1.5707963267948966192313216916398

uno: .double 1
.text
	li $v0, 4 		#servicio para imprimir cadenas
    la $a0, c1		#se imprime "sen("
    syscall
    
    ldc1 $f12, x
    li $v0, 3 		#servicio para imprimir double
    syscall
    
    
    li $v0, 4 		#servicio para imprimir cadenas
    la $a0, c2		#se imprime ")="
    syscall
    
    mfc1.d $a0, $f12 #se pasa el valor de x a los registros $a
    ld $a2, delta
    jal seno	#se llama a la funcion seno
    mtc1.d  $v0, $f12
    li $v0, 3 		#servicio para imprimir double
    syscall
    
    li $v0, 4 		#servicio para imprimir cadenas
    la $a0, c3		#se imprime "\n"
    syscall
    li  $v0, 10     #servicio para terminar
    syscall  		#fin de programa
    
#funcion seno segun la aproximacion de euler
#inputs: $a0, a1 => argumento x (double)
#	     $a2, a3 => error (double)
#outputs:$v0, $v1 => resultado sin(x) (double)
seno:
addi $sp, $sp, -48 # se reserva lugar en el stack
sw $ra, 0($sp)	  # se guarda el valor del registro $s0
swc1 $f0, 4($sp)	  # se guarda el valor del registro $f0
swc1 $f1, 8($sp)	  # se guarda el valor del registro $f1
swc1 $f2, 12($sp)	  # se guarda el valor del registro $f2
swc1 $f3, 16($sp)	  # se guarda el valor del registro $f3
swc1 $f4, 20($sp)	  # se guarda el valor del registro $f4
swc1 $f5, 24($sp)	  # se guarda el valor del registro $f5
swc1 $f6, 28($sp)	  # se guarda el valor del registro $f6
swc1 $f7, 32($sp)	  # se guarda el valor del registro $f7
swc1 $f8, 36($sp)	  # se guarda el valor del registro $f8
swc1 $f9, 40($sp)	  # se guarda el valor del registro $f9
sw $s0, 44($sp)

mtc1 $zero, $f0 #salida
mtc1 $zero, $f1

addi $s0, $zero, 0 #k=0

mtc1.d $a0, $f2 #x
mtc1.d $a2, $f4 #delta
mtc1.d $a0, $f6 #terminonuevo

add $s0, $zero, 0 #contador

whileMenor:
c.le.d $f6, $f4 
bc1t end_while
sll $t1, $s0, 1 
addi $t1, $t1, 1 #2k+1

mfc1.d $a0, $f2
move $a2, $t1
jal potencia
mtc1.d $v0, $f6

sll $t1, $s0, 1 
addi $t1, $t1, 1 #2k+1
move $a0, $t1		
jal factorial	#se llama a la funcion factorial (el registro $a0 ya contiene el valor)
mtc1 $v0, $f8

cvt.d.w  $f8,$f8
div.d $f6, $f6, $f8

addi $t0, $0, 2
div $s0, $t0
mfhi $t1
beqz $t1, positivo
sub.d $f0, $f0, $f6
j end_if
positivo:
add.d $f0, $f0, $f6
end_if:

addi $s0, $s0, 1 #contador
b whileMenor

end_while:

mfc1 $v0, $f0
mfc1 $v1, $f1


lw $ra, 0($sp)	  # se guarda el valor del registro $s0
lwc1 $f0, 4($sp)	  # se guarda el valor del registro $f0
lwc1 $f1, 8($sp)	  # se guarda el valor del registro $f1
lwc1 $f2, 12($sp)	  # se guarda el valor del registro $f2
lwc1 $f3, 16($sp)	  # se guarda el valor del registro $f3
lwc1 $f4, 20($sp)	  # se guarda el valor del registro $f4
lwc1 $f5, 24($sp)	  # se guarda el valor del registro $f5
lwc1 $f6, 28($sp)	  # se guarda el valor del registro $f4
lwc1 $f7, 32($sp)	  # se guarda el valor del registro $f5
lwc1 $f8, 36($sp)	  # se guarda el valor del registro $f4
lwc1 $f9, 40($sp)	  # se guarda el valor del registro $f5
lw $s0, 44($sp)
addi $sp, $sp, 48 # se reserva lugar en el stack
jr $ra

potencia:
addi $sp, $sp, -20 # se reserva lugar en el stack
sw $ra, 0($sp)	  # se guarda el valor del registro $s0
swc1 $f0, 4($sp)	  # se guarda el valor del registro $f0
swc1 $f1, 8($sp)	  # se guarda el valor del registro $f1
swc1 $f12, 12($sp)	  # se guarda el valor del registro $f2
swc1 $f13, 16($sp)	  # se guarda el valor del registro $f2

mtc1 $a0, $f0
mtc1 $a1, $f1
add $t0, $zero, $a2

ldc1 $f12, uno

for:
beqz $t0, fin
mul.d $f12, $f12, $f0
subi $t0, $t0, 1
b for

fin:
mfc1.d $v0, $f12

lw $ra, 0($sp)	  # se guarda el valor del registro $s0
lwc1 $f0, 4($sp)	  # se guarda el valor del registro $f0
lwc1 $f1, 8($sp)	  # se guarda el valor del registro $f1
lwc1 $f12, 12($sp)	  # se guarda el valor del registro $f2
lwc1 $f13, 16($sp)	  # se guarda el valor del registro $f2
addi $sp, $sp, 20 # se reserva lugar en el stack
jr $ra			  # se salta a la linea siguiente de donde fue llamado el procedure	


factorial:
addi $sp, $sp, -8 # se reserva lugar en el stack
sw $s0, 0($sp)	  # se guarda el valor del registro $s0
sw $ra, 4($sp)	  # se guarda el valor del registro $ra

move $s0, $a0	  # se guarda el valor de n en una variable para poder hacer n*factorial(n-1)
bne  $s0, $zero, noigual # se verifica si se llega al caso base n==0

addi $v0, $zero, 1	#caso base
j fin_fact			#termina funcion

noigual:
addi $a0, $a0, -1	# se disminuye en 1 el parametro para factorial 
jal factorial		# factorial(n-1)
mult $s0, $v0		# n*factorial(n-1)
mflo $v0			# se guarda n*factorial(n-1) en $v0 (return value)


fin_fact:
lw $s0, 0($sp)	  # se restaura el valor del registro $s0
lw $ra, 4($sp)	  # se restaura el valor del registro $ra
addi $sp, $sp, 8  # se libera el espacio del stack
jr $ra			  # se salta a la linea siguiente de donde fue llamado el procedure	


reducir:
addi $sp, $sp, -60 # se reserva lugar en el stack
sw $ra, 0($sp)	  # se guarda el valor del registro $s0
swc1 $f0, 4($sp)	  # se guarda el valor del registro $f0
swc1 $f1, 8($sp)	  # se guarda el valor del registro $f1
swc1 $f2, 12($sp)	  # se guarda el valor del registro $f2
swc1 $f3, 16($sp)	  # se guarda el valor del registro $f3
swc1 $f4, 20($sp)	  # se guarda el valor del registro $f4
swc1 $f5, 24($sp)	  # se guarda el valor del registro $f5
swc1 $f6, 28($sp)	  # se guarda el valor del registro $f6
swc1 $f7, 32($sp)	  # se guarda el valor del registro $f7
swc1 $f8, 36($sp)	  # se guarda el valor del registro $f8
swc1 $f9, 40($sp)	  # se guarda el valor del registro $f9
swc1 $f10, 44($sp)	  # se guarda el valor del registro $f10
swc1 $f11, 48($sp)	  # se guarda el valor del registro $f11
swc1 $f12, 52($sp)	  # se guarda el valor del registro $f12
swc1 $f13, 56($sp)	  # se guarda el valor del registro $f13


mtc1 $a0, $f0
mtc1 $a1, $f1
ldc1 $f2, dosPI #2pi
ldc1 $f4, PI #pi
ldc1 $f6, PId2 #pi/2

mtc1 $zero, $f8
mtc1 $zero, $f9 # $f8 <= 0;

sub.d $f10, $f8, $f4 #-pi


whileMayor:
c.le.d $f0, $f4
bc1t WhileMenor
sub.d $f0, $f0, $f2
b whileMayor
WhileMenor:
c.lt.d $f0, $f10
bc1f unavuelta
add.d $f0, $f0, $f2
b WhileMenor

unavuelta:
c.le.d $f0, $f6
bc1t menor90
sub.d $f0, $f4, $f0
menor90:
sub.d $f12, $f8, $f6 #-pi/2
c.lt.d $f0, $f12
bc1f mayormenos90
sub.d $f0, $f10, $f0
mayormenos90:
add.d $f12, $f0, $f8 #se mueve el arco reducido al primer cuadrante para imprimir

mfc1 $v0, $f12
mfc1 $v1, $f13


lw $ra, 0($sp)	  # se guarda el valor del registro $s0
lwc1 $f0, 4($sp)	  # se guarda el valor del registro $f0
lwc1 $f1, 8($sp)	  # se guarda el valor del registro $f1
lwc1 $f2, 12($sp)	  # se guarda el valor del registro $f2
lwc1 $f3, 16($sp)	  # se guarda el valor del registro $f3
lwc1 $f4, 20($sp)	  # se guarda el valor del registro $f4
lwc1 $f5, 24($sp)	  # se guarda el valor del registro $f5
lwc1 $f6, 28($sp)	  # se guarda el valor del registro $f6
lwc1 $f7, 32($sp)	  # se guarda el valor del registro $f7
lwc1 $f8, 36($sp)	  # se guarda el valor del registro $f8
lwc1 $f9, 40($sp)	  # se guarda el valor del registro $f9
lwc1 $f10, 44($sp)	  # se guarda el valor del registro $f10
lwc1 $f11, 48($sp)	  # se guarda el valor del registro $f11
lwc1 $f12, 52($sp)	  # se guarda el valor del registro $f12
lwc1 $f13, 56($sp)	  # se guarda el valor del registro $f13
addi $sp, $sp, 60 # se libera lugar en el stack
jr $ra

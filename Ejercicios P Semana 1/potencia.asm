.data
uno: .double 1
x: .double -2.5132
n: .word 3
.text

ld $a0, x
lw $a2, n
jal potencia

mtc1.d $v0, $f12
addi $v0, $0, 3
syscall

addi $v0, $0, 10
syscall

#funcion potencia entera, realiza la potencia n de una base 
# x con complejidad O(n)
#inputs: $a0, a1 => base x (double)
#	     $a2 => potencia entera n (int)
#outputs:$v0, $v1 => resultado x^n (double)


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
addi $sp, $sp, 20 # se libera lugar en el stack
jr $ra			  # se salta a la linea siguiente de donde fue llamado el procedure	

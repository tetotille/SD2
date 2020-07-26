.data
x: .double -2
dosPI: .double 6.283185307179586476925286766559
PI: .double 3.1415926535897932384626433832795
PId2: .double 1.5707963267948966192313216916398
.text

ld $a0, x
jal reducir

mtc1.d $v0, $f12
addi $v0, $0, 3
syscall

addi $v0, $0, 10
syscall


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
sub.d $f0, $f0, $f2 #restar 2pi si x>pi
b whileMayor
WhileMenor:
c.lt.d $f0, $f10
bc1f unavuelta
add.d $f0, $f0, $f2 #sumar 2pi si x<-pi
b WhileMenor

unavuelta:
c.le.d $f0, $f6 #pi/2
bc1t menor90
sub.d $f0, $f4, $f0 #reduce del 2do al 1er cuadrante
menor90:
sub.d $f12, $f8, $f6 #-pi/2
c.lt.d $f0, $f12
bc1f mayormenos90
sub.d $f0, $f10, $f0 #reduce del 3er al 4to cuadrante
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

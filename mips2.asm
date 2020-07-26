#Funcion: Suma
#Ejercicio: Verificar overflow en adicion de numeros sin signo

#Autor: Jorge Luis Tillería
#Fecha: 22/3/2020
.data
text1: .asciiz "Overflow error."
mas: .asciiz " + "
igual: .asciiz " = "
.text

main:
addi $a0, $0, -1 #primer numero 
addi $a1, $0, 10 #segundo numero

addi $t2, $a0, 0
jal overflow
addu $t0,$a0, $a1
jal imprimir_resultado
error: #Si encuentra un error de overflow, muestra un mensaje en pantalla y salta la suma
li $v0, 10
syscall


overflow: #funcion que verifica si hay error de overflow
addu $t0, $a0, $a1
sltu $t1, $a0, $t0
beq $0, $t1, imprimir

sltu $t1, $a1, $t0
beq $0, $t1, imprimir
jr $ra

imprimir: #imprime Overflow error.
addi $t3, $a0, 0

li $v0, 4
la $a0, text1
syscall

addi $a0, $t3, 0
jal error

imprimir_resultado:
li $v0, 1
la $a0, ($t2)
syscall

li $v0, 4
la $a0, mas
syscall

li $v0, 1
la $a0, ($a1)
syscall

li $v0, 4
la $a0, igual
syscall

li $v0, 1
la $a0, ($t0)
syscall

jr $ra
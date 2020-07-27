.data
    vector: .ascii 9 9 1 9 9 1
    length: .word 6
    space: .asciiz "  "
    message1: .asciiz "Vector ingresado:\n"
    message2: .asciiz "\n\nVector ordenado:\n"

.text
main:
    li $v0, 4
    la $a0, message1
    syscall # imprime "Vector ingresado:"
    
    lw $s0, length # se guarda el tamaño del vector en s0
    
    jal imprimir # imprime el vector sin ordenar
    
    li $v0, 4
    la $a0, message2
    syscall # imprime "\nVector ordenado:"
    
    jal ordenar # ordena el vector
    
    la $a0, vector # lee el vector ordenado desde la RAM
    jal imprimir # imprime el vector ordenado
    
    li $v0, 10
    syscall
    
imprimir:
    li $t0, 0 # índice i
    whilePrint:
        beq $t0, $s0, whilePrintEnd # si i=length
    
        sll $t1, $t0, 2
        lw $a0, vector($t1)
        li $v0, 1
        syscall # se imprime vector[i]
        
        la $a0, space
        li $v0, 4
        syscall # imprime el espacio
        
        addi $t0, $t0, 1
        b whilePrint
        
    whilePrintEnd:    
        jr $ra
    
ordenar:
    subi $t5, $s0, 1
    li $t0, 0 # índice i
    while1:
        beq $t0, $t5, endWhile1
        li $t1, 0 # índice j
        while2:
            beq $t1, $t5, endWhile2 # if j = length-1
            sll $t6, $t1, 2
            addi $t1, $t1, 1 # j++
            lw $t2, vector($t6) # u = vector[j]
            lw $t3, vector+4($t6) # v = vector[j+1]
            blt $t2, $t3, while2  # si vector[j] <= vector[j+1]
            sw $t3, vector($t6) # u = vector[j]
            sw $t2, vector+4($t6) # v = vector[j+1]
            b while2
        endWhile2:
            addi $t0, $t0, 1 # i++
        b while1
        
    endWhile1:
        jr $ra
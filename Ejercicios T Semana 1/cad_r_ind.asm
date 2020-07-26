#Autores: Jorge Tillería y Alejandro Maciel

.data
	cadena1 : .asciiz "hola que tal tal hola"
	cadena2 : .asciiz "tal"
	#el resultado debe ser 13
	#se empieza a contar desde cero
.text
		
	main:
		la $s0, cadena1
		la $s1, cadena2
		li $t0, 0 # indice i
		li $t9, 0
		while:
			li $t1, 0
			add $t2, $s0, $t0#cheat para acceder a cada lugar de memoria
			lb $t6, 0($t2)	 #cheat
			add $t3, $s1, $t1#cheat para acceder a cada lugar de memoria
			lb $t7, 0($t3)	 #cheat
			
			#t6 y t7 son las letras actuales de cada cadena
			#t2 y t3 son sus direcciones
			if:
				bne $t6, $t7, endif
				addi $t5, $t0, 0
				jal comparar
			endif:
			addi $t0, $t0, 1
			
			bne $t6, $0, while#si es cero c++ el indice j
			
		#end while
		j imprimir

		
				
	comparar:
		la $s2, cadena1+0($t5) #subcadena con primer valor como valor actual
		la $s3, cadena2+0($t1)
		lb $t4, ($s2)
		lb $t8, ($s3)
		addi $t1, $t1, 1
		addi $t5, $t5, 1
		beq $t8, $0, ifc
		beq $t4,$t8, comparar
		jr $ra
		ifc:
			addi $t9, $t0, 0
		jr $ra
								
	imprimir:
		li $v0, 1
		la $a0, 0($t9)
		syscall
		li $v0, 10
		syscall
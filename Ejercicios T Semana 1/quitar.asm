#Autores: Jorge Tillería y Alejandro Maciel

.data
	cadena1 : .asciiz "hola hhola"
	cadena2 : .asciiz "ha"
.text
		
	main:
		la $s0, cadena1
		la $s1, cadena2
		li $t0, 0 # indice i
		li $t1, 0 # indice j

		while:
			add $t2, $s0, $t0#cheat para acceder a cada lugar de memoria
			lb $t6, 0($t2)	 #cheat
			add $t3, $s1, $t1#cheat para acceder a cada lugar de memoria
			lb $t7, 0($t3)	 #cheat
			
			#t6 y t7 son las letras actuales de cada cadena
			#t2 y t3 son sus direcciones
			if:
				bne $t6, $t7, endif
				addi $t5, $t0, 0
				jal cambiar
			endif:
			addi $t0, $t0, 1
			
			bne $t6, $0, while#si es cero c++ el indice j
			
			#se verifica que el ultimo valor de la segunda cadena no sea cero
			addi $t1, $t1, 1
			li $t0, 0 # i = 0
			bne $t7, $0, while
		#end while
		j imprimir

		
				
	cambiar:
		la $s2, cadena1+0($t5) #subcadena con primer valor como valor actual
		lb $t4, 1($s2) #valor siguiente
		sb $t4, 0($s2)
		
		addi $t5, $t5, 1
		bne $t4, $0, cambiar
		
		jr $ra						
	imprimir:
		li $v0, 4
		la $a0, 0($s0)
		syscall
		li $v0, 10
		syscall

.data
a: .double 3.0
bb: .double 5.0
opcion: .byte 1
.text

ldc1 $f4, a
ldc1 $f6, bb
la $t1, case3
jr $t1

case1:
	add.d $f2,$f4,$f6
	j end	
case2:
	sub.d $f2,$f4,$f6
	j end
case3:
	mul.d $f2,$f4,$f6
	j end
case4:
	div.d $f2,$f4,$f6
	j end
end:
	li $v0, 3
	mov.d $f12, $f2
	syscall
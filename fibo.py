#1,1,2,3,5,8,13,21,34,55,89
a0 = int(input()) #entrada de la funcion
t0 = 0 # anterior
t1 = 1 # actual
t2 = 0
if a0 < 2:
    print("1")
else:
    while t2 < a0:
        t2 = t2 + 1
        t3 = t0 + t1
        t0 = t1
        t1 = t3

    print(t1)

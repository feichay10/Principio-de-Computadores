#Práctica 6 de Principio de Computadores
#Alumno: Cheuk Kelly Ng Pante
#Correo: alu0101364544@ull.edu.es

maxlen = 200 #Magic Number.
	.data
cadena: 	.asciiz "Practica 5 de Principios de Computadores."
cadena2:	.asciiz "roma tibi subito m otibus ibit amor"
cadena3:	.asciiz "dabale arroz a la zorra el abad"
cadena4:	.asciiz "sometamos o matemos"
cadtiene:	.asciiz " tiene "
cadcarac:	.asciiz " caracteres.\n"
cadespal:	.asciiz "Es palíndroma.\n\n"
cadnoespal:	.asciiz "No es palíndroma.\n\n"
cad1:       .asciiz "<1> Introducir cadena por teclado.\n<2> Utilizar una cadena predefinida.\n<3> Salir del programa.\n"
cad2:       .asciiz "\nPor favor, introduzca bien la opción.\n"
cad3:       .asciiz "¿Cuantos caracteres tiene su cadena?: "
cad4:       .asciiz "\nIntroduzca su cadena:\n "
endl:       .asciiz "\n"
cadAux:     .space maxlen
cadAux1:    .space maxlen
	.text
    
strlen:
# numero de caracteres que tiene una cadena sin considerar el '\0'
# la cadena tiene que estar terminada en '\0'
# $a0 tiene la direccion de la cadena
# $v0 devuelve el numero de caracteres
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN strlen SIN CAMBIAR LOS ARGUMENTOS
    #PREPARO REGISTROS.
	sw 	 $ra,  0($sp)         #Almaceno en la pila la dir a la que volver.
    lw   $a0,  4($sp)         #Cargo en $a0 la dir de la cadena.
    li   $v0,  0
    #Recorro la cadena hasta que el último caracter sea $zero ('\0'). 
    bucle:
        lb   $t0,  0($a0)
        addi $a0,  1
        addi $v0,  1
        bne  $t0,  $zero, bucle
        addi $v0, -1
    move $t1, $v0
    li   $v0,  4
    la   $a0, cadtiene
    syscall
    li   $v0, 1
    move $a0, $t1
    syscall
    li   $v0, 4
    la   $a0, cadcarac
    syscall
    
    sw $t1, 8($sp)
    lw $ra, 0($sp)
	jr $ra                    #Salto a la dir del main.

reverse_i:
# funcion que da la vuelta a una cadena
# $a0 cadena a la que hay que dar la vuelta
# $a1 numero de caracteres que tiene la cadena
# $v0 1 Si es palíndroma 0 si no lo es
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN reverse_i SIN CAMBIAR LOS ARGUMENTOS
###################
#Código de Ejemplo:
#for (int i = 0; i < n/2; i++)
#   invertir($a0[i], $s0[n-i-1])
    #PREPARO REGISTROS.
    sw   $ra, 0($sp)          #Almaceno en la pila la dir a la que volver.
    lw   $a1, 8($sp)          #Cargo en $a1 el número de caracteres.
    lw   $a0, 4($sp)          #Cargo en $a0 la dir de la cadena.
    li   $t1, 1               #Iterador
    move $s0, $a0
    add  $s1, $a0, $a1        #Calculo la posición final de la cadena.
    addi $s1, -1
    li $v0, 1
    li $t5, 1
    bucle1:
        lb   $t2,  0($s0)     #Cargo el caracter izq de la cadena.
        lb   $t3,  0($s1)     #Cargo el caracter der de la cadena.
        addi $s0,  1
        addi $s1, -1
        #####IMPRIMO#####
        move $t4, $v0
        li   $v0, 11
        move $a0, $t3
        syscall
        move $v0, $t4
        #################
        addi $t1, 1
        bne  $t2, $t3,   reviNo      #Si son diferentes, $v0 = 0
        ble  $t1, $a1,   bucle1      #Si no ha recorrido el bucle, lo continua realizando.
        beq  $v0, $zero, reviEndF    #Imprime con $v0 = 0
        beq  $v0, $t5,   reviEndT    #Imprime con $v0 = 1
    reviNo:
        li $v0, 0
        j bucle1
    reviEndT:
        lw $t0,  0($sp)       #Cargo en un registro la dir del main.
        sw $t0, 16($sp)       #Almaceno en la pila la dir del main.
        jal strlen            #Salto a strlen (Calculo de num. de caracteres.)
        sw $v0, 12($sp)       #Almaceno en la pila el valor de $v0 (1)
        li $v0,  4             
        la $a0, cadespal      #Imprimo que esta cadena es palindroma.
        syscall
        lw $ra, 16($sp)
        jr $ra                #Salto a la dir del main.
    reviEndF:
        lw $t0,  0($sp)       #Cargo en un registro la dir del main.
        sw $t0, 16($sp)       #Almaceno en la pila la dir del main.
        jal strlen            #Salto a strlen (Calculo de num. de caracteres.)
        sw $v0, 12($sp)       #Almaceno en la pila el valor de $v0 (1)
        li $v0,  4
        la $a0, cadnoespal    #Imprimo que esta cadena es palindroma.
        syscall
        lw $ra, 16($sp)
        jr $ra                #Salto a la dir del main.
reverse_r:
# funcion que da la vuelta a una cadena
# $a0 cadena a la que hay que dar la vuelta
# $a1 numero de caracternes que tiene la cadena
# $v0 1 Si es palíndroma 0 si no lo es
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN reverse_r SIN CAMBIAR LOS ARGUMENTOS
    #PREPARO REGISTROS.
    sw   $ra, 0($sp)          #Almaceno en la pila la dir a la que volver.
    lw   $a1, 8($sp)          #Cargo en $a1 el número de caracteres.
    lw   $a0, 4($sp)          #Cargo en $a0 la dir de la cadena.
    la   $s1, cadAux1
    li   $t1, 1               #Iterador
    move $s0, $a0
    add  $s1, $s1, $a1        #Calculo la posición final de la cadena.
    addi $s1, -1
    li $v0, 1
    li $t5, 1
    bucle2:
        lb   $t2,  0($s0)     #Cargo el caracter izq de la cadena.
        sb   $t2,  0($s1)     #Cargo el caracter der de la cadena.
        #####IMPRIMO#####
        move $t4, $a0
        move $t5, $v0
        li   $v0, 11
        move $a0, $t2
        syscall
        move $v0, $t5
        move $a0, $t4
        #################
        addi $s0,  1
        addi $s1, -1
        addi $t1, 1
        ble  $t1, $a1,   bucle2      #Si no ha recorrido el bucle, lo continua realizando.
    li   $t1, 1
    la   $s1, cadAux1
    move $s0, $a0
    lw   $a1, 8($sp)          #Cargo en $a1 el número de caracteres.
    bucle3:
        lb   $t2, 0($s0)     #Cargo el caracter izq de la cadena.
        lb   $t3, 0($s1)     #Cargo el caracter der de la cadena.
        #####IMPRIMO#####
        move $t4, $v0
        li   $v0, 11
        move $a0, $t3
        syscall
        move $v0, $t4
        #################
        addi $s0, 1
        addi $s1, 1 
        addi $t1, 1
        bne  $t2, $t3,   revrNo      #Si son diferentes, $v0 = 0
        ble  $t1, $a1,   bucle3      #Si no ha recorrido el bucle, lo continua realizando.
        beq  $v0, $zero, revrEndF    #Imprime con $v0 = 0
        beq  $v0, $t5,   revrEndT    #Imprime con $v0 = 1
    revrNo:
        li $v0, 0
        j bucle3
    revrEndT:
        lw $t0,  0($sp)       #Cargo en un registro la dir del main.
        sw $t0, 16($sp)       #Almaceno en la pila la dir del main.
        jal strlen            #Salto a strlen (Calculo de num. de caracteres.)
        sw $v0, 12($sp)       #Almaceno en la pila el valor de $v0 (1)
        li $v0,  4             
        la $a0, cadespal      #Imprimo que esta cadena es palindroma.
        syscall
        lw $ra, 16($sp)
        jr $ra                #Salto a la dir del main.
    revrEndF:
        lw $t0,  0($sp)       #Cargo en un registro la dir del main.
        sw $t0, 16($sp)       #Almaceno en la pila la dir del main.
        jal strlen            #Salto a strlen (Calculo de num. de caracteres.)
        sw $v0, 12($sp)       #Almaceno en la pila el valor de $v0 (1)
        li $v0,  4
        la $a0, cadnoespal    #Imprimo que esta cadena es palindroma.
        syscall
        lw $ra, 16($sp)
        jr $ra                #Salto a la dir del main.
main:
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN main QUE REPRODUZCA LA SALIDA COMO EL GUIÓN
# INVOCANDO A LA FUNCIÓN strlen DESPUÉS DE CADA MODIFICACIÓN DE LAS CADENAS
    #Push, reservo espacio para un marco de pila.
    addi $sp, -20
    la   $t0, cadena2
    #Almaceno en la pila la dir de la cadena predifinida.
    sw   $t0, 4($sp)
menu:
    #Preparo los registros.
    li $t1, 1
    li $t2, 2
    li $t3, 3
    
    #Imprimo el menu
    li $v0, 4
    la $a0, cad1
    syscall
    
    #Recibo la opción del menu.
    li   $v0, 5
    syscall
    move $t0, $v0
    
    #Salto a la opción seleccionada.
    beq $t1, $t0, cadTecl
    beq $t2, $t0, main2
    beq $t3, $t0, salida
    
    #En caso de error, repito el menu.
    li $v0, 4
    la $a0, cad2
    syscall
    j menu
    
cadTecl:
    #Pregunto el número de caracteres.
    li $v0, 4
    la $a0, cad3
    syscall
    
    #Recibo el número de caracteres.
    li   $v0, 5
    syscall
    move $t0, $v0
    addi $t0, 1               #Le aumento 1 al número de caracteres ya que va a tomar el enter como un caracter de la cadena.
    
    #Informo de que escriba la cadena.
    li $v0, 4
    la $a0, cad4
    syscall
    
    #Recogo la cadena con el número de caracteres específicos.
    li $v0, 8
    la $a0, cadAux
    move $a1, $t0
    syscall
    sw $a0, 4($sp)            #Almaceno en la pila la cadena.
    
main2:
    #Imprimo la cadena seleccionada.
    li   $v0, 4
    lw   $a0, 4($sp)
    syscall
    
    jal strlen
    jal reverse_i
    jal reverse_r
    
    #Pop, borro el espacio del marco de pila reservado.
    addi $sp, 20
    j main
salida:
    li $v0, 10
	syscall
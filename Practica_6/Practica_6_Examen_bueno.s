#Práctica 6 de Principio de Computadores
#Alumno: Cheuk Kelly Ng Pante
#Correo: alu0101364544@ull.edu.es

#Crea un programa en MIPS con las siguientes características:
#Contiene las funciones:
#       -SumaString: 
#           ·Recibe la direccion de comienzo de una cadena de tipo asciiz
#           ·Devuelve la suma de los valores ASCII de cada uno de los caracteres de la cadena
#       -ComparaString:
#           ·Lee dos cadenas de consola
#           ·Haciendo uso de la funcion anterior devuelve 1 si la suma de los valores ASCII de la primera es mayor 
#   que el de la segunda 0 y en caso contrario.
#
#El main llama ComparaString hasta que devulva 0. 

maxlen = 200 
	.data
cadAux1:    .space maxlen
cadAux2:    .space maxlen
titulo: 	        .asciiz "Practica 6 de Principios de Computadores.\n"
cuantoscarac:       .asciiz "¿Cuantos caracteres tiene su cadena?: "
introducir:           .asciiz "\nIntroduzca su cadena:\n "
endl:               .asciiz "\n"
	.text
    
SumaString:
    #Almaceno en la pila la dir a la que volver.
    sw $ra,4($sp)
    
    #Recibe la dirección de comienzo de una cadena de tipo asciiz.
    lw $t0,8($sp)   # Saco de la pila la cadena introducida
    li $t1,1        # $t1 es el iterador para llevar la cuenta de caracteres de la caden
    li $t2,0        # $t2 es un 0 para sumar los caracteres
    bucle1:
        lb  $t3,0($t0)  # Va sacando los caracteres de la cadena y los va sumando
        addi $t0,1
        add $t2,$t2,$t3
        addi $t1,1
        ble  $t1,$s2,bucle1 # Repite el bucle mientras el numero de caracteres recorridos menor que el numero total de caracteres
    li $v0,4
    la $a0,endl
    syscall

    li	$v0,1  #1, Función imprimir entero por consola.
    move $a0,$t2 #$a0, Dirección del entero a imprimir.
    syscall
    #Salto a la continuación de "ComparaString".
    lw $ra,4($sp)   #Cargo la direccion de la pila a volver
	jr $ra          #return a la continuacion de ComparaString

ComparaString:
    #Almaceno en la pila la dir a la que volver.
    sw $ra,0($sp)
    
    #Lee dos cadenas de consola.
    #Cadena1
        #Pregunto el número de caracteres.
        li $v0,4 
        la $a0,cuantoscarac
        syscall
        
        #Recibo el número de caracteres.
        li   $v0,5
        syscall
        move $t0,$v0
        addi $t0,1               #Le aumento 1 al número de caracteres ya que va a tomar el enter como un caracter de la cadena.
        move $s2,$t0            #En $s2 esta guardado el numero de caracteres introducido
        
        #Informo de que escriba la cadena.
        li $v0,4
        la $a0,introducir
        syscall
        
        #Recogo la cadena con el número de caracteres específicos.
        li $v0,8				#read_string
        la $a0,cadAux1			#load adress de cadAux1  
        move $a1,$t0
        syscall
        sw $a0,8($sp)            #Almaceno en la pila la cadena.
        
#Salto a la función "SumaString".
        jal SumaString

        move $s3,$s2 #Cadena 2 vuelve a usar $s2
    
    #Cadena2
        #Pregunto el número de caracteres.
        li $v0,4
        la $a0,cuantoscarac
        syscall
        
        #Recibo el número de caracteres.
        li $v0,5
        syscall
        move $t0,$v0
        addi $t0,1               #Le aumento 1 al número de caracteres ya que va a tomar el enter como un caracter de la cadena.
        move $s2,$t0
        
        #Informo de que escriba la cadena.
        li $v0,4
        la $a0,introducir
        syscall
        
        #Recogo la cadena con el número de caracteres específicos.
        li $v0,8
        la $a0,cadAux1
        move $a1,$t0
        syscall
        sw $a0,8($sp)            #Almaceno en la pila la cadena.
        

    #Salto a la función "SumaString".
    jal SumaString

    #Salto a la continuación de "main".
    lw $ra,0($sp)
	jr $ra

main:
#std::cout << "Practica 6 de principio de Computadores";
    li $v0,4
    la $a0,titulo
    syscall
    #Push, reservo espacio para un marco de pila.
    addi $sp,-20
    li $s0,1
    #El main llama a ComparaString hasta que devuelva 0.
    bucle0:
        jal ComparaString
        beq $t0,$zero,bucle0
    
salida:
    li $v0,10
	syscall
   

#Magic Numbers.
size = 4	# tamano de cada elemento
maxdim = 256

.data #Directiva que indica la zona de datos.
  cad1: .asciiz "Practica 4. Trabajando con Matrices\n\n"
  cad2: .asciiz "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna, <3> introducir matriz: "
  cad3: .asciiz "Seleccione fila [1, "
  cad4: .asciiz "Seleccione columna [1, "
  cad6: .asciiz "]: "
  cad7: .asciiz "¿De cuantas filas?: "
  cad8: .asciiz "¿De cuantas columnas?: "
  cad9: .asciiz "Introduce el valor "
  cad10:.asciiz " de la matriz: "
  cad11:.asciiz "Introduce una matriz de menor tamaño.\n\n"
  space:.asciiz " "
  endl: .asciiz "\n"
  matrix:	 .word	11, 12, 13
		  	   .word	21, 22, 23
		  	   .word  31, 32, 33
		  	   .word	41, 42, 43
  nrows:   .word 4
  ncols:   .word 3
  matrix2: .space maxdim
  
.text #Directiva que indica la zona de codigo.
  main:
    li $v0, 4	 #La funcion 4 imprime por consola la cadena cad1.
    la $a0, cad1
    syscall

    #Preparo los registros.
    la  $s0, matrix 		#Guardo en $s0 la direccion base de la matriz.
    li  $s2, size 		#contiene el tamano de cada elemento.
    la  $s3, nrows 		#Contiene la direccion del tamano de las filas.
    lw  $s3, 0($s3)
    la  $s4, ncols 		#Contiene la direccion del tamano de las columnas.
    lw  $s4, 0($s4)
   
    mul $s5, $s3, $s4 	#Contiene el valor de m*n
    li  $s7  maxdim
    div $s6, $s7, $s2
    
    
  mostrarMatriz:
    #Pongo a cero para preparar los registros temporales
    li $t0, 0 #guarda el indice.
    li $t3, 0 #para incremento
    
  bucleMatriz0:
    li $t4, 0    #$t4 = 0 (registro auxiliar para mostrar la matriz estructurada)

  bucleMatriz1:
    #Contengo el desplazamiento relativo y la direccion del elemento que quiero mostrar en el registro $t1
    mul  $t1, $t0, $s2
    addu $t1, $t1, $s0 
      
    #Cargo el elemento que quiero mostrar en el registro $t2 y lo muestro por pantalla
    lw   $t2, 0($t1)
    li   $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, space
    syscall
      
    #Realizo los incrementos necesarios para continuar el bucle y y luego salir
    addi $t0, $t0, 1
    add  $t3, $t3, 1
    add  $t4, $t4, 1
    bne  $t4, $s4, bucleMatriz1

    li $v0, 4
    la $a0, endl
    syscall
    bne $t3, $s5, bucleMatriz0

  menu:
    li $v0, 4
    la $a0, endl
    syscall

    #Comienza el menu.
    li $v0, 4	#La funcion 4 imprime por consola la cadena cad2.
    la $a0,cad2
    syscall

    #Preparo los registros para las operaciones del menu.
    li $t0,0
    li $t1,1
    li $t2,2
    li $t4,3
    
    li   $v0,5	#La funcion 5 lee un entero por consola.
    syscall
    move $t3, $v0

    li $v0, 4
    la $a0, endl
    syscall

		#Comparaciones para saltar a las distintas partes del programa.
    beq $t3, $t0, salida
    beq $t3, $t1, invertirFila
    beq $t3, $t2, invertirColumna
    beq $t3, $t4, introducirMatriz
    j menu


  invertirFila:
    li $v0, 4	#La funcion 4 imprime una cadena por consola.
    la $a0, cad3
    syscall

    li   $v0, 1  #La funcion 1 imprime un entero por consola.
    move $a0, $s3
    syscall

    li $v0, 4	#La funcion 4 imprime una cadena por consola.
    la $a0, cad6
    syscall

    li   $v0, 5	#La funcion 5 lee un entero por consola.
    syscall
    move $t0, $v0
    
    bgt $t0, $s3, invertirFila
    blt $t0, 1, invertirFila
    
    #Posicion final.
    mul   $t1, $t0, $s4
    mul   $t1, $t1, $s2
    addu  $t1, $t1, $s0
    
    #Posicion inicial.
    addi  $t4, $t0, -1
    mul   $t4, $t4, $s4
    mul   $t4, $t4, $s2
    addu  $t4, $t4, $s0
    
    #Preparo los registros.
    li   $t0, 2
    div  $t0, $s4, $t0 #Numero de repeticiones. $s4 ncols
    li   $t5, 0

#for
  invertirFila0:
    beq $t5, $t0, mostrarMatriz
    sub $t1, $t1, $s2
    lw  $t2, 0($t1) 
    lw  $t3, 0($t4)
    
    sw  $t3, 0($t1)
    sw  $t2, 0($t4)
    add $t4, $t4, $s2
    addi $t0, $t0, -1
    j invertirFila0

  invertirColumna:
    li $v0, 4	#La funcion 4 imprime una cadena por consola.
    la $a0, cad4
    syscall

    li   $v0, 1  #La funcion 1 imprime un entero por consola.
    move $a0, $s4
    syscall

#std::cin >> f;
    li $v0, 4	#La funcion 4 imprime una cadena por consola.
    la $a0, cad6
    syscall

    li   $v0, 5	#La funcion 5 lee un entero por consola.
    syscall
    move $t0, $v0
    
    bgt $t0, $s4, invertirColumna
    blt $t0, 1, invertirColumna
    
    addi  $t0, $t0, -1
    #Posicion final.
    addi  $t1, $s3, -1
    mul   $t1, $t1, $s4
    add   $t1, $t1, $t0
    mul   $t1, $t1, $s2
    addu  $t1, $t1, $s0
    
    #Posicion inicial.
    mul   $t4, $t0, $s2
    addu  $t4, $t4, $s0
    
    #Preparo los registros.
    li   $t0, 2
    div  $t0, $s3, $t0 #Numero de repeticiones.
    li   $t5, 0
    mul  $t6, $s2, $s4


  invertirColumna0:
    beq $t5, $t0, mostrarMatriz
    lw  $t2, 0($t1) 
    lw  $t3, 0($t4)
    
    sw  $t3, 0($t1)
    sw  $t2, 0($t4)
    
    sub $t1, $t1, $t6
    add $t4, $t4, $t6
    
    addi $t0, $t0, -1
    j invertirColumna0
    

  introducirMatriz:
    #Fila
    li $v0, 4	#La funcion 4 imprime una cadena por consola.
    la $a0, cad7
    syscall
    li   $v0, 5	#La funcion 5 lee un entero por consola.
    syscall
    move $s3, $v0
    
    #Columna
    li $v0, 4	#La funcion 4 imprime una cadena por consola.
    la $a0, cad8
    syscall
    li   $v0, 5	#La funcion 5 lee un entero por consola.
    syscall
    move $s4, $v0
    
    mul  $s5, $s3, $s4 #m*n
    
    blt $s5, $s6 introducirMatriz0
    
    li $v0, 4	#La funcion 4 imprime una cadena por consola.
    la $a0, cad11
    syscall
    j introducirMatriz
    
  introducirMatriz0:
    
    la $s0, matrix2
    li $t0, 1 #Para incremento
    
  introducirMatrizLoad:
    li $v0, 4	#La funcion 4 imprime una cadena por consola.
    la $a0, cad9
    syscall
    
    li   $v0, 1  #La funcion 1 imprime un entero por consola.
    move $a0, $t0
    syscall
    
    li $v0, 4	#La funcion 4 imprime una cadena por consola.
    la $a0, cad10
    syscall
  
    li   $v0, 5	#La funcion 5 lee un entero por consola.
    syscall
    sw   $v0, 0($s0)
    addi $s0, 4
    addi $t0, 1
    
    li $v0, 4
    la $a0, endl
    syscall
    
    ble  $t0, $s5, introducirMatrizLoad
    la $s0, matrix2
    j mostrarMatriz
    
	salida:
		li $v0, 10 #Salida del sistema.
		syscall

    
    
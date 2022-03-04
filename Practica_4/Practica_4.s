#Práctica 4 de Principio de Computadores
#Objetivo: Dada una matriz definida en memoria, invertir el orden de los elementos de una fila o una columna que el usuario pueda meter por el teclado.
#Alumno: Cheuk Kelly Ng Pante
#Correo: alu0101364544@ull.edu.es

#Pasar el siguiente codigo de C++ a MIPS

##include <iostream>
#int main(void) {
#	const int nrows = 4, ncols = 3;
#	int matrix[nrows][ncols] = {{11,12,13},{21,22,23},{31,32,33},{41,42,43}};
#
#	std::cout << "Practica 4. Trabajando con Matrices\n";
#	int selection;
#	do {
#		int i,j;
#		for (i = 0; i < nrows ; i++) {
#			for (j = 0; j < ncols ; j++)
#				std::cout << matrix[i][j] << " ";
#			std::cout << std::endl;
#		}
#		
#		do {
#			std::cout << "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna: ";
#			std::cin >> selection;
#		} while (selection < 0 || selection > 2);
#		
#		if (selection != 0) {
#			if (selection == 1) {
#				int f,aux;
#				do {
#					std::cout << "Seleccione fila [" << 1 << "," << nrows << "]: ";
#					std::cin >> f;
#				} while (f < 1 || f > nrows);
#				f--;
#				for (j = 0; j <= (ncols-1) / 2; j++) {
#					aux = matrix[f][j];
#					matrix[f][j] = matrix[f][ncols-1-j];
#					matrix[f][ncols-1-j] = aux;
#				}				
#			} else {  // selection es 2
#				int c,aux;
#				do {
#					std::cout << "Seleccione columna [" << 1 << "," << ncols << "]: ";
#					std::cin >> c;
#				} while ( c < 1 || c > ncols);
#				c--;
#				for (i = 0; i <= (nrows-1) / 2; i++) {
#					aux = matrix[i][c];
#					matrix[i][c] = matrix[nrows-1-i][c];
#					matrix[nrows-1-i][c] = aux;
#				}	
#			}
#		}		
#	} while (selection != 0);
#	return(0);
#}


size = 4 # bytes que ocupa cada elemento
    .data	
titulo: 	.asciiz	"Practica 4. Trabajando con Matrices\n"
opcion:     .asciiz "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna: "
fila:       .asciiz "Seleccione fila [1, "
columna:    .asciiz "Seleccione columna [1, "
corchete:   .asciiz "]: "
esp:        .asciiz " "
endl:       .asciiz "\n"

#int matrix[nrows][ncols] = {{11,12,13},{21,22,23},{31,32,33},{41,42,43}};
matrix: .word 11, 12, 13
        .word 21, 22, 23
        .word 31, 32, 33
        .word 41, 42, 43

#const int nrows = 4, ncols = 3;
nrows:   .word 4
ncols:   .word 3

	.text		
main:

#std::cout << "Practica 4. Trabajando con Matrices\n";
    li $v0,4
    la $a0,titulo
    syscall

# Mostrar la matriz:
#	do {
#		for (int i = 0; i < nrows ; i++) {
#			for (int j = 0; j < ncols ; j++)
#				std::cout << matrix[i][j] << " ";
#			std::cout << std::endl;
#		}

#Comienzo del bucle principal del programa
doMatriz:   

#Registros
    lw $s0,nrows 	   #Guardo en $s0 el tamaño de las filas.
    lw $s1,ncols 	   #Guardo en $s1 el tamaño de columnas.
    la $s2,matrix      #Guardo en $s2 la direccion base de la matriz.
    li $s3,size        #Guardo en $s3 el tamaño del elemento

    li $t2,0    

#for (int i = 0; i < nrows ; i++)
    for1:
        li $t3,0

#for (int j = 0; j < ncols ; j++)
        for2:
        # (i*ncols+j)size + base
            mul $t4,$t2,$s1
            add $t4,$t4,$t3
            mul $t4,$t4,$s3
            add $t4,$t4,$s2
            
            lw $t5,0($t4)
            li $v0,1
            move $a0,$t5
            syscall
            
            li $v0,4
            la $a0,esp
            syscall

            addi $t3,1
            blt $t3,$s1,for2
        
#std::cout << std::endl;
        la $a0,endl
        li $v0,4
        syscall

        addi $t2,1
        blt $t2,$s0,for1

#Salto de linea
    li $v0,4
    la $a0,endl
    syscall

#do {
#		std::cout << "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna: ";
#		std::cin >> selection;
#	} while (selection < 0 || selection > 2);

#Comienzo del bucle do-while
DoOpcion:
#std::cout << "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna: ";
    la $a0,opcion
    li $v0,4
    syscall

#Registros para las opciones
    li $t0,0
    li $t1,1
    li $t2,2

#std::cin >> selection;
    li $v0,5
	syscall
	move $s4,$v0 # Guardo en $s4 el valor selection

#while (selection < 0 || selection > 2); 

    beq $s4,$t0,Salir               # $s4 = 0 Termina el programa
    beq $s4,$t1,doInvertirFila      # $s4 = 1 Invierte las filas
    beq $s4,$t2,doInvertirColumna   # $s4 = 2 Invierte las columnas
    j DoOpcion

#Salto de linea
    li $v0,4
    la $a0,endl
    syscall

#if (selection == 1) {
#	int f,aux;
#   do {
#       std::cout << "Seleccione fila [" << 1 << "," << nrows << "]: ";
#	    std::cin >> f;
#   } while (f < 1 || f > nrows);
#   f--;
#   for (j = 0; j <= (ncols-1) / 2; j++) {
#	    aux = matrix[f][j];
#	    matrix[f][j] = matrix[f][ncols-1-j];
#	    matrix[f][ncols-1-j] = aux;
#   }				

#if (selection == 1)
#   do {
#       std::cout << "Seleccione fila [" << 1 << "," << nrows << "]: ";
#	    std::cin >> f;
#   } while (f < 1 || f > nrows);
doInvertirFila:
#std::cout << "Seleccione fila [" << 1 << "," << nrows << "]: ";
    la $a0,fila
    li $v0,4
    syscall

#" << nrows << "
    li $v0,1
    move $a0,$s0
    syscall

#"]: "
    li $v0,4
    la $a0,corchete
    syscall

#std::cin >> f;
    li $v0,5
    syscall
    move $t4,$v0

#while (f < 1 || f > nrows);
    blt $t4,1,doInvertirFila
    bgt $t4,$s0,doInvertirFila

#f--;
#for (j = 0; j <= (ncols-1) / 2; j++) {
#	    aux = matrix[f][j];
#	    matrix[f][j] = matrix[f][ncols-1-j];
#	    matrix[f][ncols-1-j] = aux;
#}			

#f--;
    addi $t5,$t4,-1

    li $t0,2
    div $t0,$s1,$t0 
    li $t6,0  

#for (j = 0; j <= (ncols-1) / 2; j++)
ForInvFila:
    beq $t6,$t0,doMatriz

#Calculamos para acceder a la posicion final   
    mul $t1,$t4,$s1
    mul $t1,$t1,$s3
    addu $t1,$t1,$s2

#Calculamos para acceder a la posicion inicial
    mul $t5,$t5,$s1
    mul $t5,$t5,$s3
    addu $t5,$t5,$s2

    sub $t1,$t1,$s3

#cargas la posicion final
    lw $t2,0($t1) 

#cargas la posicion inicial
    lw $t3,0($t5)

    sw $t3,0($t1)

    sw $t2,0($t5)

    add $t5,$t5,$s3
    addi $t0,$t0,-1
    j ForInvFila

#else {  // selection es 2
#		int c,aux;
#		do {
#		    std::cout << "Seleccione columna [" << 1 << "," << ncols << "]: ";
#			std::cin >> c;
#			} while ( c < 1 || c > ncols);
#			c--;
#			for (i = 0; i <= (nrows-1) / 2; i++) {
#				aux = matrix[i][c];
#				matrix[i][c] = matrix[nrows-1-i][c];
#				matrix[nrows-1-i][c] = aux;

#else {  // selection es 2
#		do {
#		    std::cout << "Seleccione columna [" << 1 << "," << ncols << "]: ";
#			std::cin >> c;
#			} while ( c < 1 || c > ncols);
doInvertirColumna:
#std::cout << "Seleccione columna [" << 1 << "," << ncols << "]: ";
    la $a0,columna
    li $v0,4
    syscall

#" << ncols << "
    li $v0,1
    move $a0,$s1
    syscall

#"]: "
    li $v0,4
    la $a0,corchete
    syscall

#std::cin >> c;
    li $v0,5
    syscall
    move $t1,$v0

#while (c < 1 || c > ncols);
    blt $t1,1,doInvertirColumna
    bgt $t1,$s1,doInvertirColumna

#c--;
#for (i = 0; i <= (nrows-1) / 2; i++) {
#	 aux = matrix[i][c];
#	 matrix[i][c] = matrix[nrows-1-i][c];
#	 matrix[nrows-1-i][c] = aux;
#}	

#c--;
    addi  $t1,$t1,-1

    li $t1,2
    div $t1,$s0,$t1
    li $t3,0
    mul $t4,$s3,$s1

#for (i = 0; i <= (nrows-1) / 2; i++) 
ForInvCol:
    beq $t3,$t1,doMatriz

    addi $t0,$s0,-1
    mul $t0,$t0,$s1
    add $t0,$t0,$t1
    mul $t0,$t0,$s3
    addu $t0,$t0,$s2

    mul $t2,$t1,$s3
    addu $t2,$t2,$s2
    
    lw $t5,0($t0)
    lw $t6,0($t2)

    sw $t6,0($t0)
    sw $t5,0($t2)

    sub $t0,$t0,$t4
    add $t2,$t2,$t4

    addi $t1,$t1,-1
    j ForInvCol

    j doMatriz
Salir:
    li $v0,10 
	syscall
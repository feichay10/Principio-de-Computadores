# Practica 2. Principio de computadoras
# OBJETIVO: introduce el codigo necesario para reproducir el comportamiento del programa
# C++ que se adjunta como comentarios
# Alumno: Cheuk Kelly Ng Pante
# Correo: alu0101364544@ull.edu.es

#Pasar el siguiente codigo de C++ a MIPS

##include <iostream>
#
#int main()
#{
#    std::cout << "Encuentra el número de veces que aparece una cifra en un entero." << std::endl;
#
#    int cifra;
#    do {
#        std::cout << "Introduzca la cifra a buscar (numero de 0 a 9): ";
#        std::cin >> cifra;
#    } while ((cifra < 0) || (cifra > 9));
#
#    int numero;
#    do {
#        std::cout << "Introduzca un entero positivo donde se realizará la búsqueda: ";
#        std::cin >> numero;
#    } while (numero < 0);
#
#    std::cout << "Buscando " << cifra << " en " << numero << " ... " << std::endl;
#    int encontrado = 0;
#    do {
#        int resto = numero % 10;
#        if (resto == cifra) encontrado++;
#        numero = numero / 10;
#    } while (numero != 0);
#
#    std::cout << "La cifra buscada se encontró en " << encontrado <<" ocasiones." << std::endl;
#    return 0;
#}

	.data		# directiva que indica la zona de datos
titulo: 		.asciiz	"Encuentra el numero de veces que aparece una cifra en un entero.\n"
msgcifra:		.asciiz	"Introduzca la cifra a buscar (numero de 0 a 9): "
msgnumero:		.asciiz	"Introduzca un entero positivo donde se realizara la busqueda: "
msgbusqueda1:	.asciiz	"Buscando cifra "
msgbusqueda2:	.asciiz	" en el numero "
msgresultado1:	.asciiz	" ...\nLa cifra buscada se encontro en "
msgresultado2:	.asciiz	" ocasiones\n"

#cifra => $s0
#numero => $s1
#encontrado => $s2

	.text		# directiva que indica la zona de código
main:
	# IMPRIME EL TITULO POR CONSOLA
	#    std::cout << "Encuentra el número de veces que aparece una cifra en un entero." << std::endl;
	la	$a0,titulo
	li	$v0,4
	syscall

	# INTRODUCE AQUI EL CODIGO EQUIVALENTE A:
	#    do {
	#        std::cout << "Introduzca la cifra a buscar (numero de 0 a 9): ";
	#        std::cin >> cifra;
	#    } while ((cifra < 0) || (cifra > 9));
	# NOTA: utiliza $s0 para almacenar la cifra

	#Comienzo del bucle do-while
doCifra:
	#cout << "Introduzca la cifra a buscar (numero de 0 a 9): ";	
	la $a0,msgcifra
	li $v0,4
	syscall

	#cin >> cifra;
	li $v0,5
	syscall
	move $s0,$v0	# Guardo en $s0 la cifra introducida
	 
	#cifra < 0
	blt	$s0,$zero,doCifra 

	#cifra > 9
	bgt	$s0,9,doCifra 

	#INTRODUCE AQUI EL CODIGO EQUIVALENTE A:
	#    do {
	#        std::cout << "Introduzca un entero positivo donde se realizará la búsqueda: ";
	#        std::cin >> numero;
	#    } while (numero < 0);
	# NOTA: utiliza $s1 para almacenar el numero donde buscar la cifra

	#Comienzo del bucle do-while
doNumero:
	#cout << "Introduzca un entero positivo donde se realizará la búsqueda: ";
	la $a0,msgnumero
	li $v0,4 
	syscall

	#cin >> numero;
	li $v0,5
	syscall
	move $s1,$v0	# Guardo en $s1 el entero donde se va a realizar la busqueda

	#numero < 0
	blt	$s1,$zero,doNumero


	#IMPRIME MENSAJE DE BUSQUEDA POR CONSOLA, suponiendo que en $s0 esta la cifra a buscar
	# y en $s1 el numero en el que buscar la cifra
	la	$a0,msgbusqueda1
	li	$v0,4
	syscall

	move	$a0,$s0
	li	$v0,1
	syscall

	la	$a0,msgbusqueda2
	li	$v0,4
	syscall

	move	$a0,$s1
	li	$v0,1
	syscall

	# INTRODUCE AQUI EL CODIGO EQUIVALENTE A:
	#    int encontrado = 0;
	#    do {
	#        int resto = numero % 10;
	#        if (resto == cifra) encontrado++;
	#        numero = numero / 10;
	#    } while (numero != 0);
	# NOTA: utiliza $s2 para almacenar el contador encontrado

	#int encontrado = 0;
	li $s2,0	# inicializamos $s2 = 0

	#Comienzo del bucle do-while
doEncontrado:
	#int resto = numero % 10;
	li $t1,10
	div $s1,$t1
	mfhi $t0
	# mflo

	#if (resto == cifra) encontrado++;
	bne $t0,$s0,if
	add $s2,1
if:
	# numero = numero / 10;
	div $s1,$t1
	mflo $s1
	# while (numero != 0);
	bne $s1,0,doEncontrado

	#IMPRIME EL RESULTADO POR CONSOLA, suponiendo que en $s2 tenemos el contador de encontrados
	la	$a0,msgresultado1
	li	$v0,4
	syscall

	move	$a0,$s2
	li	$v0,1
	syscall

	la	$a0,msgresultado2
	li	$v0,4
	syscall

	# las siguientes dos instrucciones finalizan el programa
	li $v0,10
	syscall
 

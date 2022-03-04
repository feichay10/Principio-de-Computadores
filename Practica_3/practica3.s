#Práctica 3 de Principio de Computadores
#Objetivo: Evaluación de un polinomio en un rango de enteros
#Alumno: Cheuk Kelly Ng Pante
#Correo: alu0101364544@ull.edu.es

#Pasar el siguiente codigo de C++ a MIPS

##include <iostream>
#int main(void) {
#	float a,b,c,d;
#	std::cout << "Evaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]" << std::endl;
#	std::cout << "Introduzca los valores de a,b,c y d (separados por retorno de carro): " << std::endl;
#	std::cin >> a;
#	std::cin >> b;
#	std::cin >> c;
#	std::cin >> d;
#	int r,s;
#	do {
#		std::cout << "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro): " << std::endl;
#		std::cin >> r;
#		std::cin >> s;
#       std::cout << std::endl;
#	} while (r > s);
#	float f;
#	int x;
#	for ( x = r ; x <= s ; x++) {
#		f = a*x*x*x + b*x*x + c*x + d;
#		std::cout << "f(" << x << ") = " << f << std::endl;
#	}
#}
    .data
titulo:     .asciiz "Evaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]\n"
valores:    .asciiz "Introduzca los valores de a,b,c y d (separados por retorno de carro): \n"
introducir: .asciiz "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro): \n"
func1:      .asciiz "f("
func2:      .asciiz ") = "
endl:       .asciiz "\n"
    .text
main:
    # $s0 para guardar r 
    # $s1 para guardar s
    # $s2 para guardar x
    # $f20 para guardar `a´ como numero flotante
    # $f21 para guardar `b´ como numero flotante
    # $f22 para guardar `c´ como numero flotante
    # $f23 para guardar `d´ como numero flotante

#std::cout << "Evaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]" << std::endl;
#std::cout << "Introduzca los valores de a,b,c y d (separados por retorno de carro): " << std::endl;
    li $v0,4
    la $a0,titulo
    syscall
    li $v0, 4
    la $a0,valores
    syscall

#Guarda los valores de a,b,c,d
#std::cin >> a;
    li $v0,6
	syscall
    mov.s $f20,$f0
#std::cin >> b;
    li $v0,6
	syscall
    mov.s $f21,$f0
#std::cin >> c;
    li $v0,6
	syscall
    mov.s $f22,$f0
#std::cin >> d;
    li $v0,6
	syscall
    mov.s $f23,$f0
    
#	do {
#		std::cout << "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):" << std::endl;
#		std::cin >> r;
#		std::cin >> s;
#	} while (r > s);

#Comienzo del bucle do-while
doTitulo:
#cout << "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):" << std::endl;
    li $v0,4
    la $a0,introducir
    syscall

#cin >> r;
	li $v0,5
	syscall
	move $s0,$v0

#cin >> s;
	li $v0, 5
	syscall
	move $s1,$v0

#r > s (fin del bucle)
    bgt	$s0,$s1,doTitulo


#	for ( x = r ; x <= s ; x++) {
#		f = a*x*x*x + b*x*x + c*x + d;
#           std::cout << "f(" << x << ") = " << f << std::endl;

move $s2,$s0    # x = r => inicializamos la x 
for:
    bgt $s2,$s1,finfor
    
#f = a*x*x*x + b*x*x + c*x + d;   
#a*x*x*x
    mult $s2,$s2
    mflo $t0

    mult $t0,$s2
    mflo $t1

    mtc1 $t1,$f4
    cvt.s.w $f5,$f4

    mul.s $f6,$f20,$f5  # en $f6 guardo el resultado de a*x*x*x

#b*x*x
    mult $s2,$s2
    mflo $t2

    mtc1 $t2,$f4
    cvt.s.w $f5,$f4

    mul.s $f7,$f21,$f5  # en $f7 guardo el resultado de b*x*x

#c*x 
    move $t3,$s2 
    mtc1 $t3,$f4
    cvt.s.w $f5,$f4

    mul.s $f8,$f22,$f5  # en $f8 guardo el resultado de c*x

    add.s $f9,$f6,$f7
    add.s $f9,$f9,$f8
    add.s $f9,$f9,$f23  # en $f9 guardo el resultado de a*x*x*x + b*x*x + c*x + d


#std::cout << "f(" << x << ") = " << f << std::endl;  
#"f("
    li $v0,4 
    la $a0,func1
    syscall

    li $v0,1
    move $a0,$s2
    syscall

#") = "
    li $v0,4
    la $a0,func2
    syscall

    li $v0,2
    mov.s $f12,$f9
    syscall

    li $v0,4
    la $a0,endl
    syscall


    addi $s2,$s2,1
    j for #salta al bucle for

finfor:

#fin del programa
    li $v0,10
	syscall
#include <iostream>

int main()
{
    std::cout << "Encuentra el número de veces que aparece una cifra en un entero." << std::endl;

    int cifra;
    do
    {
        std::cout << "Introduzca la cifra a buscar (numero de 0 a 9): ";
        std::cin >> cifra;
    } while ((cifra < 0) || (cifra > 9));

    int numero;
    do
    {
        std::cout << "Introduzca un entero positivo donde se realizará la búsqueda: ";
        std::cin >> numero;
    } while (numero < 0); // 77754  7

    std::cout << "Buscando " << cifra << " en " << numero << " ... " << std::endl;
    int encontrado = 0;
    do
    {
        int resto = numero % 10;
        if (resto == cifra)
            encontrado++;
        numero = numero / 10;
    } while (numero != 0);

    std::cout << "La cifra buscada se encontró en " << encontrado << " ocasiones." << std::endl;
    return 0;
}

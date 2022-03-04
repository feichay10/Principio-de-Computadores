#include <iostream>
int main(void)
{
	float a, b, c, d;
	std::cout << "Evaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]" << std::endl;
	std::cout << "Introduzca los valores de a,b,c y d (separados por retorno de carro): " << std::endl;
	std::cin >> a;
	std::cin >> b;
	std::cin >> c;
	std::cin >> d;
	int r, s;
	do
	{
		std::cout << "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):" << std::endl;
		std::cin >> r;
		std::cin >> s;
		std::cout << std::endl;
	} while (r > s);
	float f;
	int x;
	for (x = r; x <= s; x++)
	{
		f = a * x * x * x + b * x * x + c * x + d;
		std::cout << "f(" << x << ") = " << f << std::endl;
	}
}
#include <iostream>
int main(void)
{
	const int nrows = 4, ncols = 3;
	int matrix[nrows][ncols] = {{11, 12, 13}, {21, 22, 23}, {31, 32, 33}, {41, 42, 43}};

	std::cout << "Practica 4. Trabajando con Matrices\n";
	int selection;
	do
	{
		int i, j;
		for (i = 0; i < nrows; i++)
		{
			for (j = 0; j < ncols; j++)
				std::cout << matrix[i][j] << " ";
			std::cout << std::endl;
		}

		do
		{
			std::cout << "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna: ";
			std::cin >> selection;
		} while (selection < 0 || selection > 2);

		if (selection != 0)
		{
			if (selection == 1)
			{
				int f, aux;
				do
				{
					std::cout << "Seleccione fila [" << 1 << "," << nrows << "]: ";
					std::cin >> f;
				} while (f < 1 || f > nrows);
				f--;
				for (j = 0; j <= (ncols - 1) / 2; j++)
				{
					aux = matrix[f][j];
					matrix[f][j] = matrix[f][ncols - 1 - j];
					matrix[f][ncols - 1 - j] = aux; //move
				}
			}
			else
			{ // selection es 2
				int c, aux;
				do
				{
					std::cout << "Seleccione columna [" << 1 << "," << ncols << "]: ";
					std::cin >> c;
				} while (c < 1 || c > ncols);
				c--;
				for (i = 0; i <= (nrows - 1) / 2; i++)
				{
					aux = matrix[i][c];
					matrix[i][c] = matrix[nrows - 1 - i][c];
					matrix[nrows - 1 - i][c] = aux;
				}
			}
		}
	} while (selection != 0);
	return (0);
}
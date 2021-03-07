using System;

namespace CSharpBasics.Utilities
{
	public class ArrayHelper
	{
		/// <summary>
		/// Вычисляет сумму неотрицательных элементов в одномерном массиве
		/// </summary>
		/// <param name="numbers">Одномерный массив чисел</param>
		/// <returns>Сумма неотрицательных элементов массива</returns>
		/// <exception cref="ArgumentNullException"> Выбрасывается, если <see cref="numbers"/> равен null</exception>
		public float CalcSumOfPositiveElements(int [] numbers)
		{
			int sum = 0;
			if (numbers != null)
			{
				if (numbers.Length < 1)
				{
					return 0;
				}
				else
				{
					for (int i = 0; i < numbers.Length; i++)
					{
						if (numbers [i] >= 0)
						{
							sum += numbers [i];
						}
					}
					return sum;
				}
			}
			else
			{
				throw new ArgumentNullException("numbers", "массив numbers не может быть равен null" );
			}

		}

		/// <summary>
		/// Заменяет все отрицательные элементы в трёхмерном массиве на нули
		/// </summary>
		/// <param name="numbers">Массив целых чисел</param>
		/// <exception cref="ArgumentNullException"> Выбрасывается, если <see cref="numbers"/> равен null</exception>
		public void ReplaceNegativeElementsBy0(int [,,] numbers)  //Code Smells #14
		{
			if (numbers != null)
			{
				Calculations(numbers);
			}
			else
				throw new ArgumentNullException("numbers" , "массив numbers не может быть равен null " );
		}
		public void Calculations(int [,,] numbers)//Code Smells #3
        {
			for (int i = 0; i < numbers.GetLength(0); i++)
			{
				for (int j = 0; j < numbers.GetLength(1); j++)
				{
					for (int k = 0; k < numbers.GetLength(2); k++)
					{
						ReplaceCell(ref numbers [i, j, k]);

						Console.WriteLine($"ячейки : i== {i} , j == {j} , k == {k} ", i, j, k);
						Console.WriteLine("значение ячейки= " + numbers [i, j, k]);
					}
				}
			}
		}
		public void ReplaceCell (ref int cell)
		{ 
			if(cell < 0)
            {
				cell = 0;
				Console.WriteLine("число было заменено");
			}
		}

		/// <summary>
		/// Вычисляет сумму элементов двумерного массива <see cref="numbers"/>,
		/// которые находятся на чётных позициях ([1,1], [2,4] и т.д.)
		/// </summary>
		/// <param name="numbers">Двумерный массив целых чисел</param>
		/// <returns>Сумма элементов на четных позициях</returns>
		/// <exception cref="ArgumentNullException"> Выбрасывается, если <see cref="numbers"/> равен null</exception>
		public float CalcSumOfElementsOnEvenPositions(int[,] numbers)//Code Smells #13
		{
			int sumpositions = 0;
			int localsum = 0;
			if (numbers != null)
			{
				for (int i = 0; i < numbers.GetLength(0); i++)
				{
					for (int j = 0; j < numbers.GetLength(1); j++)
					{
						Console.WriteLine($"ячейки : i== {i} , j == {j} ", i, j);
						Console.WriteLine("значение ячейки= " + numbers [i, j]);
						sumpositions = i + j;

						Console.WriteLine("сумма позиций = " + sumpositions);
						if (sumpositions % 2 == 0)
                        {
							localsum += numbers [i, j];

                        }
					}
				}
			}
			else
            {
				throw new ArgumentNullException("numbers","массив numbers не может быть равен null ");
			}
			return localsum;
		}

		/// <summary>
		/// Фильтрует массив <see cref="numbers"/> таким образом, чтобы на выходе остались только числа, содержащие цифру <see cref="filter"/>
		/// </summary>
		/// <param name="numbers">Массив целых чисел</param>
		/// <param name="filter">Цифра для фильтрации массива <see cref="numbers"/></param>
		/// <returns></returns>
		public int [] FilterArrayByDigit(int [] numbers, byte filter)
		{
			int [] resultarray = null;
			string arraystring;
			string filterstring = filter.ToString();


			if (CheckFilterAndNumbers(ref filter, ref numbers))
			{
				resultarray = new int [0];
				//проход по базовому массиву
				for (int i = 0; i < numbers.Length; i++)
				{
					Console.WriteLine("значение ячейки= " + numbers [i]);
					// преобразование ячейки в строку
					arraystring = numbers [i].ToString();
					// алгоритм- смотрим строка содержит нужно число из раздела фильтр
					if (arraystring.Contains(filterstring))
					{
						Console.WriteLine("true");

						Array.Resize(ref resultarray, resultarray.Length + 1);
						Console.WriteLine("resultarray length = " + resultarray.Length);
						FillResultArray(ref resultarray,ref numbers, i);
					}
				}
				return resultarray;
			}
			else
				return resultarray;
				
		}
		public Boolean CheckFilterAndNumbers(ref byte filter, ref int [] numbers)
        {
			if (filter < 10 && filter >= 0)
			{
				if (numbers != null)
				{
					return true;
				}
				else
					return false;
			}
            else
            {
				throw new ArgumentOutOfRangeException("filter","число filter не может быть больше 10");
			}
				
			
        }
		public void FillResultArray(ref int [] _resultarray,ref int [] _numbers , int k)
        {
			for (int j = 0; j < _resultarray.Length; j++)
			{

				if (_resultarray [j] == 0)
				{
					_resultarray [j] = _numbers [k];
					break;
				}
			}
		}

	}
}
using System;

namespace CSharpBasics.Utilities
{
	public class ShapeCalculator
	{
		/// <summary>
		/// Возвращает площадь прямоугольника со сторонами <see cref="a"/> и <see cref="b"/>
		/// </summary>
		/// <param name="a">Длина стороны a прямоугольника</param>
		/// <param name="b">Длина стороны b прямоугольника</param>
		/// <returns>Площадь прямоугольника</returns>
		/// <exception cref="ArgumentOutOfRangeException"></exception>
		public float CalcRectangleArea(int a, int b)
		{

			if (a <= 0 || b <= 0)
			{ throw new ArgumentOutOfRangeException("a,b" , "значение параметра должно быть больше нуля"); } 
			else
			{
				return a * b;
			}


		}
	}
}
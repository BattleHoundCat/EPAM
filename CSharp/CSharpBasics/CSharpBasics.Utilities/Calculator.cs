using System;

namespace CSharpBasics.Utilities
{
	public class Calculator
	{
		/// <summary>
		/// Вычисляет сумму всех натуральных чисел меньше <see cref="number"/>, кратных любому из <see cref="divisors"/>
		/// </summary>
		/// <param name="number">Натуральное число</param>
		/// <param name="divisors">Числа, которым должны быть кратны слагаемые искомой суммы</param>
		/// <returns>Вычисленная сумма</returns>
		/// <exception cref="ArgumentOutOfRangeException">
		/// Выбрасывается в случае, если <see cref="number"/> или любое из чисел в <see cref="divisors"/> не является натуральным,
		/// а также если массив <see cref="divisors"/> пустой
		/// </exception>
		public float CalcSumOfDivisors(int number, params int[] divisors)
		{
			int result = 0;

			if (number > 0  && divisors.Length>0 &&  DivisorCheck( divisors) && number % 1 == 0)
			{
				result = RunCycle(result,number,ref divisors);
					return result;
			}
			else
				throw new ArgumentOutOfRangeException("number", "number должен быть больше нуля");


		}
		public Boolean DivisorCheck(int[] divisors)
        {
			int result = 0;	
            for (int i = 0; i < divisors.Length; i++)
            {
				if (divisors [i] > 0)
				{
					if (divisors [i] % 1 == 0)
						result++;
				}
				else
					throw new ArgumentOutOfRangeException("divisors[i]","число массива divisors должно быть больше нуля");

			}
			if (result > 0)
			{
				return true;
			}
			else
				return false;
		}
		public int RunCycle(int _result,int _number , ref int [] divisors)
        {
			for (int j = 0; j < divisors.Length; j++)
			{
				for (int i = 1; i < _number; i++)
				{
					if (i % divisors [j] == 0)
						_result += i;
				}
			}
			return _result;
        }


		/// <summary>
		/// Возвращает ближайшее наибольшее целое, состоящее из цифр исходного числа <see cref="number"/>
		/// </summary>
		/// <param name="number">Исходное число</param>
		/// <returns>Ближайшее наибольшее целое</returns>

		#region Main method
		public long FindNextBiggerNumber(int number)
		{
			if (number < 0 )
			{
				throw new ArgumentOutOfRangeException("number","число number должно быть больше нуля" );
			}

			if (number <= 11)
			{
				throw new ArgumentOutOfRangeException("number", "значение number должно быть больше 11 " );
			}

			return FindNext(number);
		}
		#endregion

		//Other methods
		static int FindNext(int number)
		{
			int [] buff = new int [number.ToString().Length];
			for (int i = buff.Length - 1; i > -1; i--)
			{
				buff [i] = number % 10;
				number /= 10;
			}

			int index = FindIndex(buff);

			if (index == -1)
			{
				return -1;
			}

			int temp;

			if (index < buff.Length - 1)
			{
				temp = buff [index];
				buff [index] = buff [index + 1];
				buff [index + 1] = temp;
				Array.Sort(buff, index + 1, buff.Length - index - 1);
			}

			int result = 0;
			for (int i = 0; i < buff.Length; i++)
			{
				result += (int)(buff [i] * Math.Pow(10, buff.Length - 1 - i));
			}

			return result;
		}

		static int FindIndex(int [] temp)
		{
			for (int i = temp.Length - 1; i > 0; i--)
			{
				if (temp [i] > temp [i - 1])
				{
					return (i - 1);
				}
			}
			throw new ArgumentOutOfRangeException("temp","значение должно не выбиваться за границы");
		}
		
	}
}
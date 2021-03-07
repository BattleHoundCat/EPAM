using System.Linq;

namespace Calculation.Implementation
{
	public class BaseCalculator
	{
		protected int SafeSum(params int[] numbers)
		{
			var sum = 0;

			checked
			{
				foreach (var i in numbers)
				{
					sum += i;
				}
			}

			return sum;
		}

		protected int SafeSub(int a, int b)
		{
			checked
			{
				return a - b;
			}
		}

		protected int SafeMultiply(params int[] numbers)
		{
			var result = numbers[0];

			checked
			{
				foreach (var i in numbers.Skip(1))
				{
					result *= i;
				}
			}

			return result;
		}
	}
}
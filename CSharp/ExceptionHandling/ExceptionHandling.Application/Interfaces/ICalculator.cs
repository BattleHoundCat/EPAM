namespace Calculation.Interfaces
{
	public interface ICalculator
	{
		int Sum(params int[] numbers);
		int Sub(int a, int b);
		int Multiply(params int[] numbers);
		int Div(int a, int b);
	}
}
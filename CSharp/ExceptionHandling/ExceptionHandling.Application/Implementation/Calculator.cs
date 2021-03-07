using System.Linq;
using System;
using Calculation.Interfaces;
using NLog;
//using ILogger = Calculation.Interfaces.ILogger;

namespace Calculation.Implementation
{
	public class Calculator : BaseCalculator, ICalculator
	{
		private readonly Interfaces.ILogger _logger;
		//private static Logger Nlogger = LogManager.GetCurrentClassLogger();
		public Calculator(Interfaces.ILogger logger)
		{
			_logger = logger;
		}	
		public int Sum(params int[] numbers)
		{

			int resultsum;
			string resultmessage = "";
			try
			{
				foreach (var el in numbers)
				{
					resultmessage += el.ToString();
					resultmessage += " ";
				}
				_logger.Trace($"Begin Sum with {resultmessage}");
				resultsum = SafeSum(numbers);
			}
			catch (OverflowException ex)
			{
				_logger.Error(ex);
				_logger.Trace("Result Sum with errors");
				throw;
			}
			resultmessage = "";
			foreach (var el in numbers)
			{
				resultmessage += el.ToString();
				resultmessage += " ";
			}
			_logger.Info($"Result Sum with {resultmessage} get {resultsum}" );
			_logger.Trace("Result Sum");
			return resultsum;
		}	
		public int Sub(int a, int b)
		{
			if (a <= int.MinValue || b <= int.MinValue)
			{
				throw new System.OverflowException("значение а или b выходят за границы допустимого");
			}

			return SafeSub(a, b);
		}

		public int Multiply(params int[] numbers)
		{
			if (!numbers.Any())
				return 0;
			int result ;
			try
			{
				result = SafeMultiply(numbers);
			}
			catch (Exception e)
			{
				Console.WriteLine("CHECKED and CAUGHT:  " + e.ToString());
				Console.WriteLine("Safemultiply больше, чем нужно", e.InnerException);
				throw new InvalidOperationException("more context here", e);
			}
			return result;
		}

		public int Div(int a, int b)
		{
            try
            {
				if (a == 0 || a == int.MaxValue || b == 0 || b == int.MaxValue)
				{
					throw new InvalidOperationException("original invalid exception");
				}
			}
            catch (InvalidOperationException )
            {
				throw new InvalidOperationException("new invalid exception");
            }
			return a / b;
		}	

	}
}
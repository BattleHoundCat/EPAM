using System;
using Timer.Interfaces;

namespace Timer.Factories
{
	public class CountDownNotifierFactory
	{
		public ICountDownNotifier CreateNotifierForTimer(Timer timer)
		{
			if (timer == null)
			{
				throw new ArgumentNullException("Timer равен null");
			}
            else
            {
				return new Implementation.CountDownNotifier(timer); 
			}
				
		}
	}
}

using System;

namespace Timer.Factories
{
	public class TimerFactory
	{
		public Timer CreateTimer(string name, int ticks)
		{
			if (name == "" || name == null || (ticks <= 0) )
            {
				throw new System.ArgumentException("сработал Argument Exception");
			}
            else
            {
				return new Timer(name, ticks);
			}
		}
	}
}
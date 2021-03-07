using System;
using Timer.Interfaces;

namespace Timer.Implementation
{
	public class CountDownNotifier : ICountDownNotifier
	{
		public Timer Atimer { get; set; }
		public void Init(Action<string, int> startDelegate, Action<string> stopDelegate, Action<string, int> tickDelegate)
		{
			Console.WriteLine("срабатывание метода Init CountDownNotifier");
			if (startDelegate != null && stopDelegate != null && tickDelegate !=null)
            {
				Atimer.Started += (sender, eventargs) => startDelegate(eventargs.NameTimer, eventargs.NumTicks);
				Atimer.Stopped += (dender, eventargs) => stopDelegate(eventargs.NameTimer);
				Atimer.Ticked += (sender, eventargs) => tickDelegate(eventargs.NameTimer, eventargs.NumTicks);
			}
		}
		public void Run()
		{
			Console.WriteLine("срабатывание метода Run CountDownNotifier");
			Atimer.Work();
		}	
		public CountDownNotifier(Timer timer)
		{
			Atimer = timer;
		}
	}
}
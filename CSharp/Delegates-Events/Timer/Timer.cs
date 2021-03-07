using System;
using System.Threading;
namespace Timer
{
	public class Timer
	{
		public Thread thr;


		//public delegate void TimerEventHandler(string message);//изначальный делегат
		public delegate void TimerEventHandler( Object sender, EventArgs.MyEventArgs e);
		public event TimerEventHandler Started;
		public event TimerEventHandler Stopped;
		public event TimerEventHandler Ticked;

		public string Name { get; set; }
		public int Ticks { get; set; }
		public void Start()
        {
			

		}
		public void Stop()
        {
					
		}
		public void Tick()
		{
				
		}
		public void Work()
        {
			//метод Start
			Console.WriteLine("Сработал метод Start в Таймере");
			thr = new Thread(new ThreadStart(this.Tick));
			thr.Start();
			Started?.Invoke(this, new EventArgs.MyEventArgs(this.Name, Ticks));

			//метод Tick
			for (int i = Ticks; i > 1; i--)
			{
				Console.WriteLine("Итерация Tick: {0}", i);
				// Thread.Sleep(500);
				Ticked?.Invoke(this, new EventArgs.MyEventArgs(this.Name, (i - 1)));
			}

			//метод Stop
			Console.WriteLine("Сработал метод Stop в Таймере");
			//thr.Interrupt();
			Stopped?.Invoke(this, new EventArgs.MyEventArgs(this.Name, Ticks));
		}
		public Timer(string name, int ticks)
        {
			Name = name;
			Ticks = ticks;
        }
	}

}
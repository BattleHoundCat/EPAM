using System;

namespace Timer.Interfaces
{
	public interface ICountDownNotifier
	{
		void Init(Action<string, int> startDelegate, Action<string> stopDelegate, Action<string, int> tickDelegate);
		
		void Run();

	}
}

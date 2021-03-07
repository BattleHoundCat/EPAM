using System;
using NLog;

namespace Calculation.Interfaces
{
	public interface ILogger : ILoggerBase, ISuppress
	{
		void Error(Exception ex);
		void Info(string message);
		void Trace(string message);
	}
}
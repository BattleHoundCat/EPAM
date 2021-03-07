using System;
using System.Threading.Tasks;

namespace HrDepartment.Infrastructure.Interfaces
{
	public interface ILogger
	{
		Task LogTrace(string message);
		Task LogInfo(string message);
		Task LogWarning(string message);
		Task LogError(string message, Exception exception);
	}
}

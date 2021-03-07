using System;
using HrDepartment.Infrastructure.Enums;

namespace HrDepartment.Infrastructure.Dto
{
	public class LogRecordDto
	{
		public LogLevel LogLevel { get; set; }
		public DateTime DateTime { get; set; }
		public string Message { get; set; }
		public Exception Exception { get; set; }
	}
}

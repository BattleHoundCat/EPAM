using System;
using System.Threading.Tasks;
using Azure.Messaging.ServiceBus;
using HrDepartment.Infrastructure.Dto;
using HrDepartment.Infrastructure.Enums;
using HrDepartment.Infrastructure.Interfaces;
using HrDepartment.Utils.Extensions;

namespace HrDepartment.Infrastructure.Implementation
{
	public class AzureServiceBusLogger : ILogger
	{
		const string LogsQueueName = "HrDepartmentLogs";

		private readonly IAppConfiguration _appConfiguration;

		public AzureServiceBusLogger(IAppConfiguration appConfiguration)
		{
			_appConfiguration = appConfiguration;
		}

		public async Task LogTrace(string message)
		{
			await SendLog(() => CreateLogRecord(LogLevel.Trace, message));
		}

		public async Task LogInfo(string message)
		{
			await SendLog(() => CreateLogRecord(LogLevel.Info, message));
		}

		public async Task LogWarning(string message)
		{
			await SendLog(() => CreateLogRecord(LogLevel.Warning, message));
		}

		public async Task LogError(string message, Exception exception)
		{
			await SendLog(() => CreateLogRecord(LogLevel.Trace, message, exception));
		}

		private LogRecordDto CreateLogRecord(LogLevel logLevel, string message, Exception exception = null)
		{
			return new LogRecordDto
			{
				DateTime = DateTime.UtcNow,
				LogLevel = logLevel,
				Message = message,
				Exception = exception
			};
		}

		private async Task SendLog(Func<LogRecordDto> createLogRecord)
		{
			await using (var serviceBusClient = new ServiceBusClient(_appConfiguration.AzureServiceBusConnectionString))
			{
				await using(var sender = serviceBusClient.CreateSender(LogsQueueName))
				{
					var logRecord = createLogRecord();
					var serviceBusMessage = new ServiceBusMessage(logRecord.ToJson());
					await sender.SendMessageAsync(serviceBusMessage);
				}
			}
		}
	}
}

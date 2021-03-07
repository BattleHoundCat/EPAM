using System.Collections.Generic;
using System.Threading.Tasks;
using Azure.Messaging.ServiceBus;
using HrDepartment.Infrastructure.Dto;
using HrDepartment.Infrastructure.Interfaces;
using HrDepartment.Utils.Extensions;

namespace HrDepartment.Infrastructure.Implementation
{
	public class AzureServiceBusEmailSender : IEmailSender
	{
		private const string EmailsQueueName = "Emails";

		private readonly IAppConfiguration _appConfiguration;

		public AzureServiceBusEmailSender(IAppConfiguration appConfiguration)
		{
			_appConfiguration = appConfiguration;
		}

		public async Task SendEmailAsync(string @from, IEnumerable<string> to, string subject, string body)
		{
			await using (var serviceBusClient = new ServiceBusClient(_appConfiguration.AzureServiceBusConnectionString))
			{
				await using(var sender = serviceBusClient.CreateSender(EmailsQueueName))
				{
					var emailMessage = CreateEmailMessage(from, to, subject, body);
					await sender.SendMessageAsync(new ServiceBusMessage(emailMessage.ToJson()));
				}
			}
		}

		private EmailMessageDto CreateEmailMessage(string from, IEnumerable<string> to, string subject, string body)
		{
			return new EmailMessageDto
			{
				From = from,
				To = to,
				Subject = subject,
				Body = body
			};
		}
	}
}

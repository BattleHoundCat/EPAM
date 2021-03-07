using HrDepartment.Infrastructure.Interfaces;

namespace HrDepartment.Infrastructure.Implementation
{
	public class ConstAppConfiguration : IAppConfiguration
	{
		public string AzureServiceBusConnectionString => "Fake connection string";
	}
}

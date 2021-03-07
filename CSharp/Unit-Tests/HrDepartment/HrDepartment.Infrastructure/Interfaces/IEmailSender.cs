using System.Collections.Generic;
using System.Threading.Tasks;

namespace HrDepartment.Infrastructure.Interfaces
{
	public interface IEmailSender
	{
		Task SendEmailAsync(string from, IEnumerable<string> to, string subject, string body);
	}
}

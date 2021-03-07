using System.Collections.Generic;

namespace HrDepartment.Infrastructure.Dto
{
	public class EmailMessageDto
	{
		public string From { get; set; }
		public IEnumerable<string> To { get; set; }
		public string Subject { get; set; }
		public string Body { get; set; }
	}
}

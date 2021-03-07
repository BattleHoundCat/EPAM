using System;
using System.Threading.Tasks;

namespace HrDepartment.Application.Interfaces
{
	public interface ISanctionService
	{
		Task<bool> IsInSanctionsListAsync(string lastName, string firstName, string middleName, DateTime birthDate);
	}
}

using System.Collections.Generic;
using System.Threading.Tasks;
using HrDepartment.Application.Dto;
using HrDepartment.Domain.Entities;
using HrDepartment.Domain.Enums;

namespace HrDepartment.Application.Interfaces
{
	public interface IJobSeekerService
	{
		Task<JobSeeker> AddAsync(BackgroundInformationDto backgroundInformation);
		Task MoveToPersonnelReserveAsync(int jobSeekerId);
		Task<IList<JobSeeker>> GetAllAsync();
		Task<IList<JobSeeker>> GetAllInStatusesAsync(IEnumerable<JobSeekerStatus> statuses);
		Task<int> RateJobSeekerAsync(int jobSeekerId);
	}
}

using System.Threading.Tasks;
using HrDepartment.Domain.Entities;

namespace HrDepartment.Application.Interfaces
{
	public interface INotificationService
	{
		Task NotifyRockStarFoundAsync(JobSeeker jobSeeker);
	}
}

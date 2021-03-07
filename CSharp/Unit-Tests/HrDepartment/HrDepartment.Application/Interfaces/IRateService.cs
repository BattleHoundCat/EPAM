using System.Threading.Tasks;
using HrDepartment.Domain.Entities;

namespace HrDepartment.Application.Interfaces
{
	public interface IRateService<T>
	{
		Task<int> CalculateJobSeekerRatingAsync(T jobSeeker);
	}
}

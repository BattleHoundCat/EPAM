using System;
using HrDepartment.Domain.Enums;

namespace HrDepartment.Domain.Entities
{
	/// <summary>
	/// Соискатель
	/// </summary>
	public class JobSeeker
	{
		public int Id { get; set; }
		public string LastName { get; set; }
		public string FirstName { get; set; }
		public string MiddleName { get; set; }
		public DateTime BirthDate { get; set; }
		public EducationLevel Education { get; set; }
		public JobSeekerStatus Status { get; set; }
		public double Experience { get; set; }
		public BadHabits BadHabits { get; set; }
	}
}

using System;

namespace HrDepartment.Domain.Entities
{
	/// <summary>
	/// Сотрудник
	/// </summary>
	public class Employee
	{
		public int Id { get; set; }
		public int JobSeekerId { get; set; }
		public string LastName { get; set; }
		public string FirstName { get; set; }
		public string MiddleName { get; set; }
		public DateTime BirthDate { get; set; }
	}
}

using System;

namespace HrDepartment.Domain.Enums
{
	[Flags]
	public enum BadHabits
	{
		None = 0,
		Smoking,
		Alcoholism,
		Drugs
	}
}

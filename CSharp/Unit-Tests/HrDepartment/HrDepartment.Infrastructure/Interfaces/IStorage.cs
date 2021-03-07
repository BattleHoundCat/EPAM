using System.Collections.Generic;
using System.Threading.Tasks;

namespace HrDepartment.Infrastructure.Interfaces
{
	public interface IStorage
	{
		Task<T> AddAsync<T>(T item) where T : class;
		Task<T> UpdateAsync<T>(T item) where T : class;
		Task DeleteAsync<T>(T item) where T : class;
		Task<TItem> GetByIdAsync<TItem, TKey>(TKey id) where TItem : class;
		Task<IList<T>> GetAllAsync<T>() where T : class;
	}
}

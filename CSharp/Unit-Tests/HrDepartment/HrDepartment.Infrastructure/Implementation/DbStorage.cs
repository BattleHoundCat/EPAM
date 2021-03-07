using System.Collections.Generic;
using System.Threading.Tasks;
using HrDepartment.Infrastructure.DataAccess;
using HrDepartment.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace HrDepartment.Infrastructure.Implementation
{
	public class DbStorage : IStorage
	{
		private readonly HrDepartmentDbContext _hrDepartmentDbContext;

		public DbStorage()
		{
			_hrDepartmentDbContext = new HrDepartmentDbContext();
		}

		public async Task<T> AddAsync<T>(T item) where T : class
		{
			_hrDepartmentDbContext.Set<T>().Add(item);
			await _hrDepartmentDbContext.SaveChangesAsync();
			return item;
		}

		public async Task<T> UpdateAsync<T>(T item)  where T : class
		{
			_hrDepartmentDbContext.Entry(item).State = EntityState.Modified;
			await _hrDepartmentDbContext.SaveChangesAsync();
			return item;
		}

		public async Task DeleteAsync<T>(T item) where T : class
		{
			_hrDepartmentDbContext.Entry(item).State = EntityState.Deleted;
			await _hrDepartmentDbContext.SaveChangesAsync();
		}

		public async Task<TItem> GetByIdAsync<TItem, TKey>(TKey id) where TItem : class
		{
			var item = await _hrDepartmentDbContext.Set<TItem>().FindAsync(id);
			return item;
		}

		public async Task<IList<T>> GetAllAsync<T>() where T : class
		{
			var items = await _hrDepartmentDbContext.Set<T>().ToListAsync();
			return items;
		}
	}
}

using System.Collections.Generic;

namespace Collections.Interfaces
{
	public interface IDynamicArray<T> : IEnumerable<T>
	{
		T this[int index] { get; }
		int Length { get; }
		int Capacity { get; }
		void Add(T item);
		void AddRange(IEnumerable<T> items);
		void Insert(T item, int index);
		bool Remove(T item);
	}
}
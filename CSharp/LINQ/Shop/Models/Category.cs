using System.Collections.Generic;

namespace Shop.Models
{
	/// <summary>
	/// Категория товаров
	/// </summary>
	public class Category
	{
		public int Id { get; set; }

		/// <summary>
		/// Название категории товаров
		/// </summary>
		public string Name { get; set; }

		/// <summary>
		/// Описание категории
		/// </summary>
		public string Description { get; set; }

		/// <summary>
		/// Товары данной категории
		/// </summary>
		public virtual IList<Product> Products { get; set; } = new List<Product>();
	}
}
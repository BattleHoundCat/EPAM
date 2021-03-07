namespace Shop.Models
{
	/// <summary>
	/// Товар
	/// </summary>
	public class Product
	{
		public int Id { get; set; }

		/// <summary>
		/// Название товара
		/// </summary>
		public string Name { get; set; }

		/// <summary>
		/// Производитель товара
		/// </summary>
		public string Vendor { get; set; }

		public int CategoryId { get; set; }

		/// <summary>
		/// Категория товара
		/// </summary>
		public Category Category { get; set; }

		/// <summary>
		/// Цена товара до применения скидок
		/// </summary>
		public decimal Price { get; set; }

		/// <summary>
		/// Количество товаров на складе
		/// </summary>
		public int UnitsInStock { get; set; }

		/// <summary>
		/// Скидка, действующая на товар в данный момент в %
		/// </summary>
		public int Discount { get; set; }
	}
}
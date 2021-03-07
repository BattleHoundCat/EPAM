using System.Collections.Generic;
using Shop.Models;

namespace Shop.Dto
{
	/// <summary>
	/// Класс, представляющий собой производителя и список его товаров, сгруппированный по категориям
	/// </summary>
	public class VendorProductsDto
	{
		/// <summary>
		/// Производитель
		/// </summary>
		public string Vendor { get; set; }

		/// <summary>
		/// Товары проивзодителя, сгруппированные по названию категории
		/// </summary>
		public IDictionary<string, List<Product>> CategoryProducts { get; set; }
	}
}
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Shop.Dto;
using Shop.Enums;
using Shop.Models;

namespace Shop
{
	public class ProductService
	{
		private readonly ShopContext _dbContext;

		private IList<Product> Products => _dbContext.Products.Include(p => p.Category).ToList();

		public ProductService(ShopContext dbContext)
		{
			_dbContext = dbContext;
		}

		/// <summary>
		/// Сортирует товары по цене и возвращает отсортированный список
		/// </summary>
		/// <param name="sortOrder">Порядок сортировки</param>
		public IEnumerable<Product> SortByPrice(SortOrder sortOrder)
		{
			if (sortOrder == SortOrder.Ascending)
            {
				var SortedList = from i in Products
								 orderby i.Price
								 select i;
				return SortedList;
			}
            else
            {
				var SortedList = from i in Products
								 orderby i.Price descending
								 select i;
				return SortedList;
			}		
			
		}

		/// <summary>
		/// Возвращает товары, название которых начинается на <see cref="name"/>
		/// </summary>
		/// <param name="name">Фильтр - строка, с которой начинается название товара</param>
		public IEnumerable<Product> FilterByNameStart(string name)
		{
			var filteredList = from pr in Products
							   where pr.Name.StartsWith(name)
							   select pr;
			return filteredList;
			
		}

		/// <summary>
		/// Группирует товары по производителю
		/// </summary>
		public IDictionary<string, List<Product>> GroupByVendor()
		{
			Dictionary<string, List<Product>> myDict = Products.GroupBy(o => o.Vendor).ToDictionary(g => g.Key, g => g.ToList());
			return myDict;

		}

		/// <summary>
		/// Возвращает список самых дорогих товаров (самые дорогие - товары с наибольшей ценой среди всех товаров)
		/// </summary>
		public IEnumerable<Product> GetTheMostExpensiveProducts()
		{

			var sorted = from pr in Products
						 orderby pr.Price descending
						 select pr;
			var mostexpensive = sorted.Take(2);
			return mostexpensive;
		}

		/// <summary>
		/// Возвращает список самых дешевых товаров (самые дешевые - товары с наименьшей ценой среди всех товаров)
		/// </summary>
		public IEnumerable<Product> GetTheCheapestProducts()
		{
			var sorted = from pr in Products
						 orderby pr.Price ascending
						 select pr;
			var cheapest = sorted.Take(2);
			return cheapest;
		}

		/// <summary>
		/// Возвращает среднюю цену среди всех товаров
		/// </summary>
		public decimal GetAverageProductPrice()
		{
			var averageprice = Products.Average( pr => pr.Price);
			return averageprice;
		}

		/// <summary>
		/// Возвращает среднюю цену товаров в указанной категории
		/// </summary>
		/// <param name="categoryId">Идентификатор категории</param>
		public decimal GetAverageProductPriceInCategory(int categoryId)
		{
			//Product pr = new Product();
			var filterbycategory = from pr in Products
								   where pr.CategoryId == categoryId
								   select pr;
			var AverageInCategory = filterbycategory.Average(p => p.Price);
			return AverageInCategory;
		}

		/// <summary>
		/// Возвращает список продуктов с актуальной ценой (после применения скидки)
		/// </summary>
		/// <returns></returns>
		public IDictionary<Product, decimal> GetProductsWithActualPrice()
		{
			var actualpriceList = from pr in Products
								  select new { pr.Category, ActualPrice = (pr.Price - pr.Discount) };

			Dictionary<Product, decimal> myDict = Products.ToDictionary(t => t, t => (t.Price - t.Discount));
			return myDict;
		}

		/// <summary>
		/// Возвращает список продуктов, сгруппированный по производителю, а внутри - по названию категории.
		/// Продукты внутри последней группы отсортированы в порядке убывания цены
		/// </summary>
		/// <returns></returns>
		public IList<VendorProductsDto> GetGroupedByVendorAndCategoryProducts()
		{
			VendorProductsDto vpd = new VendorProductsDto();


			List<VendorProductsDto> mylist = new List<VendorProductsDto>();

			var sortedproducts = from pr in Products
								 orderby pr.Price descending
								 select pr;
			
			var querynestedgroup = from pr in sortedproducts
								   group pr by pr.Vendor into newGroup1
								   from newGroup2 in
								   (from pr in newGroup1
									group pr by pr.Category.Name)
								   group newGroup2 by newGroup1.Key;

			
			foreach (var outerGroup in querynestedgroup)
			{
				Console.WriteLine($"Vendor string = {outerGroup.Key}");
				var myvpd = new VendorProductsDto();
				myvpd.Vendor = outerGroup.Key;
				
				foreach (var innerGroup in outerGroup)
				{
					Console.WriteLine($"Category name : {innerGroup.Key}");
					List<Product> listofproducts = new List<Product>();
					myvpd.CategoryProducts = new Dictionary<string, List<Product>>();
					foreach (var innerGroupElement in innerGroup)
					{
						Console.WriteLine($"\t\t{innerGroupElement.Name} {innerGroupElement.Id}");
						listofproducts.Add(innerGroupElement);

						Console.WriteLine(listofproducts.Count());
					}
					myvpd.CategoryProducts.Add(innerGroup.Key, listofproducts); // получаем Null-exception
					
					
					Console.WriteLine(myvpd.CategoryProducts.Count());
				}
				mylist.Add(myvpd);
			}

			return mylist;
		}

		/// <summary>
		/// Обновляет скидку на товары, которые остались на складе в количестве 1 шт,
		/// и возвращает список обновленных товаров
		/// </summary>
		/// <param name="newDiscount">Новый процент скидки</param>
		/// <returns></returns>
		public IEnumerable<Product> UpdateDiscountIfUnitsInStockEquals1AndGetUpdatedProducts(int newDiscount)
		{
			var query5 = from pr in Products
						 where pr.UnitsInStock < 2
						 orderby pr.Id
						 select pr;			
			foreach ( var item in query5)
            {
				item.Discount = newDiscount;
            }
			var query6 = query5.Take(5);
			return query6;
		}
	}
}

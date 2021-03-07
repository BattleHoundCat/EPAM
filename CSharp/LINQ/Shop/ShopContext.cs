using Microsoft.EntityFrameworkCore;
using Shop.Models;

namespace Shop
{
	public class ShopContext : DbContext
	{
		public ShopContext(DbContextOptions options) : base(options)
		{
		}

		public DbSet<Product> Products { get; set; }
		public DbSet<Category> Categories { get; set; }

		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			base.OnModelCreating(modelBuilder);

			modelBuilder
				.Entity<Product>()
				.ToTable("Products")
				.HasKey(p => p.Id);

			modelBuilder
				.Entity<Product>()
				.Property(p => p.Price)
				.HasConversion<double>();

			modelBuilder
				.Entity<Product>()
				.Property(p => p.Id)
				.ValueGeneratedOnAdd();

			modelBuilder
				.Entity<Product>()
				.HasOne<Category>()
				.WithMany(c => c.Products)
				.HasForeignKey(p => p.CategoryId);

			modelBuilder
				.Entity<Category>()
				.ToTable("Categories")
				.HasMany<Product>()
				.WithOne(p => p.Category)
				.HasForeignKey(p => p.CategoryId);

			modelBuilder
				.Entity<Category>()
				.HasKey(c => c.Id);
		}
	}
}
namespace Oop.Shapes
{
	public abstract class Shape
	{
		/// <summary>
		/// Площадь фигуры
		/// </summary>
		public abstract double Area { get; }

		/// <summary>
		/// Периметр
		/// </summary>
		public abstract double Perimeter { get; }

		/// <summary>
		/// Количество вершин
		/// </summary>
		public abstract int VertexCount { get; }

		public virtual bool IsEqual(Shape shape) => false;
	}
}

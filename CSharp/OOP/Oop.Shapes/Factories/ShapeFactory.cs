using System;

namespace Oop.Shapes.Factories
{
	public class ShapeFactory
	{
		public Shape CreateCircle(int radius)
		{
			if (radius < 1 )
            {
				throw new ArgumentOutOfRangeException("radius","значение не может быть меньше 1");

            }
			Console.WriteLine("круг создан");
			Console.WriteLine("Radius = " + radius);
			return new Circle(radius);
		}

		public Shape CreateTriangle(int a, int b, int c)
		{
			if (a <= 0 || b <= 0 || c <= 0)
		{
				throw new ArgumentOutOfRangeException("a", "значение не может быть равно нулю или меньше нуля");
				throw new ArgumentOutOfRangeException("b", "значение не может быть равно нулю или меньше нуля");
				throw new ArgumentOutOfRangeException("с", "значение не может быть равно нулю или меньше нуля");
			}
			if (CheckAside(a, b, c) && CheckBside(a, b, c) && CheckCside(a, b, c))
			{
				Console.WriteLine("CheckSide треугольника= true. Проверка на соотношение сторон прошла");
			}
			else
				throw new InvalidOperationException("условия соотношения сторон не выполнены");
			Console.WriteLine("треугольник создан");
			return new Triangle(a, b, c);
		}
		public bool CheckAside(int a, int b, int c)
        {
			if (a < b + c && a > b - c)
			{
				return true;
			}
			else
				return false;
        }
		public bool CheckBside(int a, int b, int c)
		{
			if (b < a + c && b > a - c)
			{
				return true;
			}
			else
				return false;
		}
		public bool CheckCside(int a, int b, int c)
		{
			if(c<a+b && c > a - b)
            {
				return true;
			}
			return false;
		}
		public Shape CreateSquare(int a)
		{
            if (a <= 0)
            {
				throw new ArgumentOutOfRangeException("a","значение не может быть равно нулю или меньше нуля");
			}
			Console.WriteLine("квадрат создан");
			return new Square(a);
		}

		public Shape CreateRectangle(int a, int b)
		{
			if (a<=0 || b <= 0)
            {
				throw new ArgumentOutOfRangeException("a", "значение не может быть равно нулю или меньше нуля");
				throw new ArgumentOutOfRangeException("b", "значение не может быть равно нулю или меньше нуля");
			}
			Console.WriteLine("прямоугольник создан");
			return new Rectangle(a, b);
		}
	}
}
using System;

using System.Collections.Generic;
using System.Text;

namespace Oop.Shapes
{
    public class Circle : Shape
    {
        private readonly double radius;
        const double Pi = Math.PI;
        public double Radius { get { return radius; } }
        public override double Perimeter { get { return 2 * radius * Pi; } }
        public override double Area { get { return radius * radius * Pi; } }

        public override int VertexCount => 0;

        public override bool IsEqual(Shape shape)
        {
            if (shape as Circle !=null )
            {
                Circle circle2 = (Circle)shape;
                if (this.Radius == circle2.Radius)
                    return true;
                else
                    return false;
            }
            else
                return false;
        }
        public Circle (int Radius)
        {
            this.radius = Radius;  
        }
    }
}

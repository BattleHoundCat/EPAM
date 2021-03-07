using System;
using System.Collections.Generic;
using System.Text;

namespace Oop.Shapes
{
    public class Square : Shape
    {
        private readonly double A;
        public double GetAside { get { return A; } }
        public override int VertexCount => 4;

        public override double Perimeter { get { return A *4; } }

        public override double Area
        {
            get
            {
                return Math.Round( A*A);
            }
        }
        public override bool IsEqual(Shape shape)
        {
            if (shape as Square !=null) 
            {
                Square square2 = (Square)shape;
                if (this.A == square2.A)
                    return true;
                else
                    return false;
            }
            else if (shape as Rectangle != null) 
            {
                Rectangle rect2 = (Rectangle)shape;
                if (this.A == rect2.GetAside && this.A == rect2.GetBside)
                    return true;
                else
                    return false;
           }
            else
                return false;      
        }
        public Square(int a)
        {
            this.A = a;
        }
    }
}

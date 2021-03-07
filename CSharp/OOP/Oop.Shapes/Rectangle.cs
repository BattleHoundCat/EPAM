using System;
using System.Collections.Generic;
using System.Text;

namespace Oop.Shapes
{
    public class Rectangle : Shape
    {
        private readonly double A, B;
        public double GetAside{get{ return A; } }
        public double GetBside { get { return B; } }
        public override int VertexCount => 4;

        public override double Perimeter { get { return (A + B)*2; } }

        public override double Area
        {
            get
            {
                return A * B;
            }
        }
        public override bool IsEqual(Shape shape)
        {
            if (shape as Rectangle != null) 
            {
                Rectangle rect2 = (Rectangle)shape; 
                if (this.Area == rect2.Area)
                    return true;
                else
                    return false;
            }
            else if (shape as Square !=null) 
            {
                Square square2 = (Square)shape;
                if (this.GetAside ==  square2.GetAside && this.GetBside == square2.GetAside )
                    return true;
                else
                    return false;
            }
            else
                return false;
        }
    public Rectangle(int a, int b)
        {
            this.A = a;
            this.B = b;
        }
    }
}

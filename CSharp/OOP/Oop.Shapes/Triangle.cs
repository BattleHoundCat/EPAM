using System;
using System.Collections.Generic;
using System.Text;

namespace Oop.Shapes
{
    public class Triangle : Shape
    {
        private readonly int A, B, C;

        public int GetAside { get { return A; } }
        public int GetBside { get { return B; } }
        public int GetCside { get { return C; } }


        public override int VertexCount => 3;

        public override double Perimeter { get { return A + B + C ; } }

        public override double Area 
        { 
            get {
                double HalfPerimeter =((double)A +(double)B + (double)C) / 2;
                Console.WriteLine("HalfPer = " + HalfPerimeter);
                return Math.Sqrt(HalfPerimeter*((HalfPerimeter-A)*(HalfPerimeter-B)*(HalfPerimeter-C))); 
            } 
        }
        public override bool IsEqual(Shape shape)
        {
            if (shape as Triangle != null)
            {
                Triangle tri2 = (Triangle)shape;
                int [] tr1sides = new[] { this.GetAside, this.GetBside, this.GetCside };
                int [] tr2sides = new[] { tri2.GetAside, tri2.GetBside, tri2.GetCside };
                if (CheckSides(tr1sides,tr2sides))
                    return true;
                else
                    return false;
            }
            else
                return false;  
        }
        private Boolean CheckSides(int [] tri1sides, int [] tri2sides)
        {
            int localresult = 0;
            for ( int i = 0; i<tri1sides.Length; i++ )
            {
                for (int j = 0; j < tri2sides.Length; j++)
                {
                    if (tri1sides [i] != tri2sides [j])//тут можно все три if вынести в отдельный метод, если Autocode будет ругаться
                        localresult++;
                    if (localresult == 3)
                        return false;
                    if (j == 2)
                    {
                        localresult = 0;
                    }
                        
                }
            }
            return true;
            
        }
        public Triangle(int a, int b, int c)
        {
            A = a;
            B = b;
            C = c;
        }

    }
}

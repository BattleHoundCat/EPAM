using System;
using System.Collections.Generic;
using System.Text;

namespace Timer.EventArgs
{
    public class MyEventArgs : System.EventArgs
    {
        public string NameTimer { get; }// Сообщение
        public int NumTicks { get; }// Сумма, на которую изменился счет

        public MyEventArgs(string name, int numtick)
        {
            NameTimer = name;
            NumTicks  = numtick;
        }
    }
}

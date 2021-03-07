using System;
using System.Collections;
using System.Collections.Generic;
using Collections.Interfaces;

namespace Collections
{
	public class DynamicArray<T> : IDynamicArray<T>
	{
		public DynamicArray()
		{
			this.Capacity = 8;
			this.Length = 0;
			Array.Resize(ref innerArray, innerArray.Length + 8);
		}

		public DynamicArray(int capacity)
		{
			this.Capacity = capacity;
			this.Length = 0;
			if (capacity >= 1)
            {
				Array.Resize(ref innerArray, innerArray.Length + capacity);
			}	
		}

		public DynamicArray(IEnumerable<T> items)
		{
			this.Capacity = 0;
			foreach ( T element in items)
            {
				this.Length++;	
				Array.Resize(ref innerArray, innerArray.Length +1);
				this.Capacity++;
				innerArray [this.Length - 1] = element;
			}
			lastcell = this.Length - 1;
		}

		public IEnumerator<T> GetEnumerator()
		{
			foreach (var item in innerArray)
				yield return item;
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}

		public T this [int index]   //индексатор
		{
            get
            {
				if (index < 0 || index >= this.Length)
					throw new IndexOutOfRangeException("Index out of range");
				return innerArray [index];
			}
            set
            {
				if (index < 0 || index >= this.Length)
					throw new IndexOutOfRangeException("Index out of range");
				innerArray [index] = value;
            }

		}

		public int Length { get; set; }
		public int Capacity { get; set; }

		private int lastcell = 0;//индекс последней ячейки

		public T [] innerArray = new T [0];//TO-DO: после того,как пройду все юнит-тесты, сделать приватным этот массив
		public void Add(T item)
		{
			Console.WriteLine("сработал метод Add = " + item);
			if (this.Length > 0)
            {
				lastcell = this.Length - 1;
			}
					

			if(this.Capacity > this.Length)//есть свободное место 
			{
				innerArray [lastcell ] = item; // запись в новую последнюю ячейку
				this.Length++;
				lastcell = this.Length - 1;//обновить значение индекса
			}
			else if (this.Capacity == this.Length)//свободного места нет
            {
				if (this.Capacity == 0)
				{
					this.Capacity = 8;
					Array.Resize(ref innerArray, this.Capacity);
					innerArray [0] = item;
					this.Length = 1;
					Console.WriteLine("innerArray[0] = " + innerArray [0]);
				}
                else
                {
					this.Capacity *= 2;
					Array.Resize(ref innerArray, this.Capacity);				
					this.Length++;
					innerArray [this.Length-1] = item;// запись в новую последнюю ячейку
					lastcell = this.Length - 1;//обновить значение индекса
				}
				
			}
            else // this.Capacity < innerArray.Length -1 // емкость меньше, чем реальные заполненные ячейки массива - ошибка
            {
				throw new InvalidOperationException("Capacity не может быть меньше Length");
            }

		}

		public void AddRange(IEnumerable<T> items)
		{
			Console.WriteLine("сработал метод Add = ");
			
			if (this.Length > 0)
			{
				lastcell = this.Length - 1;
			}
			
			int SumOfItems = 0;
			foreach (var item in items)//аналог функции Count() считывание всех элементов в коллекции items
            {
				SumOfItems++;
            }

            if (Capacity < (Length + SumOfItems))//если Capacity меньше чем кол-во элементов, то нужно Capacity увеличить
            {
				if ((Capacity * 2) >= (Length + SumOfItems))//Удвоить Capacity
				{
					Capacity *= 2;
					Array.Resize(ref innerArray, this.Capacity);
					AddRangeCycle(items);
				}
				else if ((Capacity * 4) >= (Length + SumOfItems))//учетверить Capacity
				{
					Capacity *= 4;
					Array.Resize(ref innerArray, this.Capacity);
					AddRangeCycle(items);
				}
				else if ((Capacity * 8) >= (Length + SumOfItems))//в 8 раз Capacity увеличить.
				{
					Capacity *= 8;
					Array.Resize(ref innerArray, this.Capacity);
					AddRangeCycle(items);
				}
			}
			else //если емкость увеличивать не надо, то просто добавляем спектр значений // 2
			{

				AddRangeCycle(items);
			}
		}
		private void AddRangeCycle(IEnumerable<T> items)
        {
			foreach (var item in items)
			{
				if (Length == 0)
                {
					innerArray [0] = item;
					this.Length++;
				}
				else if(Length > 0)
                {
					innerArray [Length ] = item;
					this.Length++;
				}
				
			}
		}
		public void Insert(T item, int index)
		{
			if(Capacity < index + 1 || index < 0)
            {
				throw new IndexOutOfRangeException("значение Index вне допустимых значений массива");
            }

			int delta = (index + 1) - Length;
			if(index+1 == Length)
            {
				//1= сместить одну ячейку
				ShiftSingle(item);
            }
			else if(index+1 < Length)
            {
				//4= сместить группу
				ShiftGroup(item, index);
            }
			if(delta == 1)
            {
				//2=добавить значение в нужную ячейку
				innerArray [index] = item;
				Length++;
            }
			else if(delta > 1)
            {
				//5=вызвать метод Add
				Add(item);
            }
		}
		private void ShiftSingle(T item)
        {
			Capacity++;
			Array.Resize(ref innerArray, Capacity);
			innerArray [lastcell + 1] = innerArray [lastcell];
			innerArray [lastcell] = item;
			lastcell++;
			Length++;
        }
		private void ShiftGroup(T item, int index)
        {
			Capacity++;
			Array.Resize(ref innerArray, Capacity);
			for( int i=lastcell; i > index + 1; i--)
            {
				innerArray [i + 1] = innerArray [i];
            }
			//группа сместилась
			innerArray [index] = item;
			Length++;
		}
		public bool Remove(T item)
		{
			
			 bool IsFound = false;
			 bool IsRemoved = false;
			 int FoundIndex =-1;
			for (int j = 0; j < innerArray.Length; j++)//поиск переменной в массиве
			{
				if (innerArray [j].Equals(item))//подозрение, что Equals будет всегда возвращать false, т.к. ссылки будут разные
				{
					IsFound = true;
					FoundIndex = j;
					break;
				}
			}

            if (IsFound)
            {
				if (FoundIndex == innerArray.Length - 1)//если удаляемый элемент последний в массиве//хотя можно сделать проверку с lastcell
				{
					innerArray [FoundIndex] = default(T);
					IsRemoved = true;
					lastcell--;
					Length--;
				}
				else if (FoundIndex < innerArray.Length - 1)// элемент не последний  в списке и нужно смещать остальные ячейки
				{
					for (int i = FoundIndex; i < innerArray.Length - 1; i++)
					{
						innerArray [i] = innerArray [i + 1];//вот тут может случиться indexoutrange exception, нужно чтобы доходило 
															//прямо до конца массива и не выходило за его пределы
					}
					innerArray [lastcell] = default(T);
					lastcell--;
					Length--;
					IsRemoved = true;
				}
			}
			

			return IsRemoved;
		}
	}
}
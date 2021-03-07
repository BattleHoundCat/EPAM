using System;
using System.Text;
namespace CSharpBasics.Utilities
{
	public class StringHelper
	{
		/// <summary>
		/// Вычисляет среднюю длину слова в переданной строке без учётов знаков препинания и специальных символов
		/// </summary>
		/// <param name="inputString">Исходная строка</param>
		/// <returns>Средняя длина слова</returns>
		public int GetAverageWordLength(string inputString)
		{
			string [] RawWords;
			int averageLength = 0;
			char [] separators = new char [] { ' ' };
			int RealWords = 0;
			if (inputString != null)
			{
				RawWords = inputString.Split(separators, StringSplitOptions.None);
				Console.WriteLine("Raw words length = " + RawWords.Length);
				for (int i = 0; i < RawWords.Length; i++)
				{
					Console.WriteLine("слово = " + RawWords [i]);
				}
				//подсчет общей длины слов
				if (RawWords.Length > 0)
				{
					int sumwords = 0;
					SumAndRealWords(ref RawWords, ref sumwords, ref RealWords);

					Console.WriteLine("общая длина слов = " + sumwords);
					if (RealWords > 0)//это тоже можно вынести в SumAndRealWords
					{
						averageLength = sumwords / RealWords;
						return averageLength;
					}

					return 0;
				}
				return averageLength;
			}
			else
				return averageLength;
		}
		public void SumAndRealWords(ref string [] RawWords,ref int sumwords,ref int RealWords)
        {
			foreach (string str in RawWords)
			{
				int realletters = 0;
				if (IsWord(str))
				{
					realletters = checkRealLetters(str);//проверка сколько символов в слове являются буквами
					sumwords += realletters;
					RealWords++;
				}
			}
		}
		public bool IsWord(string str) //является ли набор симоволов словом или нет
		{
			bool Word = false; 
			foreach (char ch in str)
            {
				if (Char.IsLetter(ch))
                {
					Word = true;
					break;
				}
				else
					Word = false;
            }
			return Word;
        }
		public int checkRealLetters(string str) //сколько реальных букв в слове,а не любые другие символы
        {
			int realletters = 0;
			foreach(char ch in str)
            {
				if (Char.IsLetter(ch))
					realletters++;
            }
			Console.WriteLine("Кол-во реальных букв realletters = " + realletters);
			return realletters;
        }
		/// <summary>
		/// Удваивает в строке <see cref="original"/> все буквы, принадлежащие строке <see cref="toDuplicate"/>
		/// </summary>
		/// <param name="original">Строка, символы в которой нужно удвоить</param>
		/// <param name="toDuplicate">Строка, символы из которой нужно удвоить</param>
		/// <returns>Строка <see cref="original"/> с удвоенными символами, которые есть в строке <see cref="toDuplicate"/></returns>
		public string DuplicateCharsInString(string original, string strDuplicate)
		{
			StringBuilder sb= new StringBuilder("");
			string resultstring = "";
			StringComparison comp = StringComparison.OrdinalIgnoreCase;
			if (original != null)
				if (strDuplicate != null) 
				{
					{
						foreach (char ch in original)
							if (!strDuplicate.Contains(ch, comp))
								sb.Append(ch);
							else
							{
								sb.Append(ch);
								sb.Append(ch);
							}
						return sb.ToString();
					}
				}
                else
                {
					resultstring = original;
					return resultstring;
                }
            
            else
            {
				resultstring = null;
				return resultstring;
            }
		}
	}
}
using System;

namespace FileMonitoring.Interfaces
{
	/// <summary>
	/// Следит за изменениями текстовых файлов в папке и может откатывать изменения на определенную дату\время
	/// </summary>
	public interface IFileMonitor : IDisposable
	{
		/// <summary>
		/// Запуск слежения за изменениями в текстовых файлах
		/// </summary>
		void Start();

		/// <summary>
		/// Остановка слежения за изменениями в тестовых файлах
		/// </summary>
		void Stop();

		/// <summary>
		/// Восстановление состояния всех текстовых файлов в папке на момент <see cref="onDateTime"/>>
		/// </summary>
		/// <param name="onDateTime">Дата и время, по состоянию на которое необходимо вернуть состояние текстовых файлов в папке</param>
		void Reset(DateTime onDateTime);
	}
}

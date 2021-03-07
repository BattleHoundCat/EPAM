namespace FileMonitoring.Interfaces
{
	/// <summary>
	/// Настройки
	/// </summary>
	public interface IConfiguration
	{
		/// <summary>
		/// Путь к папке, за файлами в которой нужно следить
		/// </summary>
		public string Path { get; } 

		/// <summary>
		/// Путь к папке, в которой должны сохраняться бэкапы
		/// </summary>
		public string BackupPath { get; }
	}
}
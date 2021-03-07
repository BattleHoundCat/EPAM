using Newtonsoft.Json;

namespace HrDepartment.Utils.Extensions
{
	public static class SerializationExtensions
	{
		public static string ToJson<T>(this T obj)
		{
			return JsonConvert.SerializeObject(obj, Formatting.None);
		}
	}
}

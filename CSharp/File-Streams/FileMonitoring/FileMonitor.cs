using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using FileMonitoring.Interfaces;

namespace FileMonitoring
{
    public class FileMonitor : IFileMonitor
    {
        private readonly FileSystemWatcher watcher = new FileSystemWatcher();

        private static List<DateTime> dtList = new List<DateTime>();
        private static DateTime dt;
        private static string Path;
        private static string BackupPath;
        public FileMonitor(IConfiguration configuration)
        {
            Path = configuration.Path;
            BackupPath = configuration.BackupPath;
        }


        static void BackUpAll()
        {
            dt = DateTime.Now;
            dt = dt.AddSeconds(-5);
            dtList.Add(dt);

            string bu = System.IO.Path.Combine(BackupPath, dt.ToString().Replace(":", ""));

            if (!Directory.Exists(bu))
                Directory.CreateDirectory(bu);

            var files = from file in Directory.EnumerateFiles(Path)
                        where file.Contains(".txt")
                        select file;

            foreach (var s in files)
            {
                string fileName = System.IO.Path.GetFileName(s);
                string destFile = System.IO.Path.Combine(bu, fileName);
                File.Copy(s, destFile, true);
            }
        }

        public void Start()
        {
            if (!Directory.Exists(BackupPath))
                Directory.CreateDirectory(BackupPath);

            BackUpAll();

            watcher.Path = Path;
            watcher.NotifyFilter = NotifyFilters.LastWrite;

            watcher.Filter = "*.txt";
            watcher.Changed += OnChanged;
            watcher.Created += OnChanged;
            watcher.Deleted += OnChanged;
            watcher.EnableRaisingEvents = true;

            static void OnChanged(object source, FileSystemEventArgs e)
            {
                dt = DateTime.Now;
                dtList.Add(dt);

                string bu = System.IO.Path.Combine(BackupPath, dt.ToString().Replace(":", ""));

                if (!Directory.Exists(bu))
                    Directory.CreateDirectory(bu);

                var files = from file in Directory.EnumerateFiles(Path)
                            where file.Contains(".txt")
                            select file;

                foreach (var s in files)
                {
                    string fileName = System.IO.Path.GetFileName(s);
                    string destFile = System.IO.Path.Combine(bu, fileName);
                    File.Copy(s, destFile, true);
                }
            }
        }

        public void Stop()
        {
            dtList.Clear();
            watcher.Dispose();
            Directory.Delete(BackupPath, true);
        }

        public void Reset(DateTime dateTime)
        {
            watcher.EnableRaisingEvents = false;
            int index = 0;

            for (int i = 0; i < dtList.Count(); i++)
                if (dtList [i].CompareTo(dateTime) >= 0)
                {
                    index = i;
                    break;
                }

            if (index > 0)
                index--;

            string bu = System.IO.Path.Combine(BackupPath, dtList [index].ToString().Replace(":", ""));
            var files = from file in Directory.EnumerateFiles(bu)
                        where file.Contains(".txt")
                        select file;
            foreach (var s in files)
            {
                string fileName = System.IO.Path.GetFileName(s);
                string destFile = System.IO.Path.Combine(Path, fileName);
                File.Copy(s, destFile, true);
            }
            watcher.EnableRaisingEvents = true;
        }

        public void Dispose()
        {
            dtList.Clear();
            watcher.Dispose();
            Directory.Delete(BackupPath, true);
        }
    }
}

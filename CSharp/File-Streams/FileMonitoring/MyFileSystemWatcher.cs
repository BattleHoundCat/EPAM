using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
namespace FileMonitoring
{
    class MyFileSystemWatcher : FileSystemWatcher
    {
        public string WatcherBackupPath { get; set; }//путь бэкап папки
        public string WatcherWatchingPath { get; set; }// путь папки, за которой наблюдаем
    }
}

# 清理数据缓存

* 修改数据表脚本

```sql
CREATE TABLE IF NOT EXISTS "T_Status" (
	 "statusId" INTEGER NOT NULL,
	 "status" TEXT,
	 "userId" INTEGER,
	 "createTime" TEXT DEFAULT (datetime('now', 'localtime')),
	PRIMARY KEY("statusId")
);
```

* 测试 SQL

```sql
SELECT * FROM T_Status WHERE createTime < '2015-10-30 06:04:55';
```

* 定义缓存时间 常量

```swift
/// 本地缓存数据时间
private let dateCacheTime: NSTimeInterval = 60 // 7 * 24 * 60 * 60
```

* 确认清除缓存日期

```swift
/// 清理缓存
class func clearDataCache() {
    let date = NSDate(timeIntervalSinceNow: -dateCacheTime)
    
    let df = NSDateFormatter()
    df.locale = NSLocale(localeIdentifier: "en")
    df.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let dateStr = df.stringFromDate(date)
    
    print(dateStr)
}
```

* 在 `AppDelegate` 的退出到后台方法中调用清理缓存方法

```swift
/// 应用程序进入后台，清理数据缓存
func applicationDidEnterBackground(application: UIApplication) {
    StatusDAL.clearDataCache()
}
```

* 清理缓存函数

```swift
/// 清理缓存
class func clearDataCache() {
    let date = NSDate(timeIntervalSinceNow: -dateCacheTime)
    
    let df = NSDateFormatter()
    df.locale = NSLocale(localeIdentifier: "en")
    df.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let dateStr = df.stringFromDate(date)
    print(dateStr)
    
    let sql = "DELETE FROM T_Status WHERE createTime < ?;"
    SQLiteManager.sharedManager.queue.inDatabase { (db) -> Void in
        db.executeUpdate(sql, dateStr)
        
        print("删除了 \(db.changes()) 条记录")
    }
}
```

## 小结

* SQLITE 的数据库，会随着数据的增加，数据库文件会不断的变大
* 但是，如果删除了记录，数据库文件并不会变小 —— 留出空间为新增数据使用
* 如果忽视了SQLite的缓存清理，会让程序占用磁盘空间增长的非常可怕！


# 数据访问层

## 数据访问层模型设计

![](StatusDAL.png)

## 数据库程序开发步骤

```
1. 明确函数目标
2. 根据目标确定参数
3. 尽快测试！要让函数今早被调用到，找到合适的入口点！
4. 在 navicat 中编写并且测试 SQL
5. 根据 SQL 确定参数
6. 实现相关的数据操作
7. 小步测试！

提示：在实际开发中，如果 SQL 相对比较复杂，拼接完成后，一定要测试确保 SQL 正确！
```

## 数据访问层对象实现数据缓存

* 新建 `StatusDAL` 专门负责微博数据的数据缓存和网络数据的处理
* 新建 `loadStatus` 函数，编写伪代码

```swift
/// 微博数据数据访问层
class StatusDAL {
    
    /// 加载微博数据
    class func loadStatus() {
        
        // 1. 检查本地是否存在数据缓存
        // 2. 如果有返回本地数据
        // 3. 如果没有，加载网络数据
        // 4. 将网络数据保存至本地数据库
        // 5. 返回网络数据
    }
}
```

### 将网络数据保存至数据库

* 新建 `saveStatus` 函数，首先解决保存微博数据问题

```swift
/// 保存缓存数据
///
/// - parameter array: 网络请求后的字典数组
class func saveCacheData(array: [[String: AnyObject]]) {
    print("缓存网络数据")
}
```

* 在 `StatusListViewModel` 中增加代码调用

```swift
// 判断 result 的数据结构是否争取
guard let array = result?["statuses"] as? [[String: AnyObject]] else {
    print("数据格式错误")
    
    finished(isSuccessed: false)
    return
}

// -- 测试缓存网络数据 --
StatusDAL.saveCacheData(array)

// 遍历字典的数组，字典转模型
// ...
```

* 测试 SQL

```sql
/**
	INSERT OR REPLACE 使用注意事项

	1. SQL 中必须包含主键
		- 如果主键不存在，新建数据
		- 如果主键存在，更新数据
	2. 数据表的主键不能自动增长
*/
INSERT OR REPLACE INTO T_Status (statusId, status, userId)
VALUES (1, 'hello world', 1001);
```

#### 实现 `saveCacheData` 函数

* 填写 SQL，确定参数

```swift
/// 保存缓存数据
///
/// - parameter array: 网络请求后的字典数组
class func saveCacheData(array: [[String: AnyObject]]) {
    
    guard let userId = UserAccountViewModel.sharedUserAccount.account?.uid else {
        print("用户没有登录")
        return
    }
    
    // 1. SQL
    /**
        需要参数
        1. 微博数据中的 id
        2. 单条微博的 json 字符串
        3. userId
    */
    let sql = "INSERT OR REPLACE INTO T_Status (statusId, status, userId) VALUES (?, ?, ?);"
}
```

* 实现数据缓存

```swift
// 2. 遍历数组 - 插入数据
SQLiteManager.sharedManager.queue.inTransaction { (db, rollback) -> Void in
    for dict in array {
        // 1> 微博 id
        let statusId = dict["id"] as! Int
        // 2> 序列化成json字符串 -> NSData
        let json = try! NSJSONSerialization.dataWithJSONObject(dict, options: [])
        
        if !db.executeUpdate(sql, statusId, json, userId) {
            rollback.memory = true
            break
        }
    }
}

print("缓存完成")
```

### 加载本地数据

* 加载本地数据 － 准备函数

```swift
/// 检查本地数据
///
/// - parameter since_id: 下拉刷新 id
/// - parameter max_id:   上拉刷新 id
class func checkCacheData(since_id: Int, max_id: Int) {
    
    guard let userId = UserAccountViewModel.sharedUserAccount.account?.uid else {
        print("用户没有登录")
        return
    }
    
    print("下拉刷新 \(since_id) 上拉刷新 \(max_id)")
}
```

* 在 `StatusListViewModel` 中增加代码调用

```swift
// -- 检查本地数据 --
StatusDAL.checkCacheData(since_id, max_id: max_id)
        
NetworkTools.sharedTools.loadStatus(since_id: since_id, max_id: max_id)

// ...
```

* 测试 SQL

```swift
SELECT statusId, status, userId FROM T_Status
WHERE userId = 5365823342
--	AND statusId > 3903512591192682		-- 下拉刷新
	AND statusId < 3903507004117146		-- 上拉刷新
ORDER BY statusId DESC LIMIT 20;
```

* 函数实现 - 准备 SQL

```swift
// 1. 准备 SQL
var sql = "SELECT statusId, status, userId FROM T_Status \n"
sql += "WHERE userId = \(userId) \n"

if since_id > 0 {       // 下拉刷新
    sql += "    AND statusId > \(since_id) \n"
} else if max_id > 0 {  // 上拉刷新
    sql += "    AND statusId < \(max_id) \n"
}
sql += "ORDER BY statusId DESC LIMIT 20;"

print("刷新 SQL \(sql)")
```

* 执行 SQL 获取结果

```swift
// 2 创建数组
var arrayM = [[String: AnyObject]]()

// 3. 执行 SQL 返回获取结果
SQLiteManager.sharedManager.queue.inDatabase() { (db) -> Void in
    
    guard let rs = db.executeQuery(sql) else {
        return
    }
    
    while rs.next() {
        let data = rs.dataForColumn("status")
        // JSON 反序列化
        let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: [])

        // 追加到数组
        arrayM.append(dict as! [String : AnyObject])
    }
}

return arrayM
```

* 添加返回值，调整完成之后的函数如下：

```swift
/// 检查本地数据
///
/// - parameter since_id: 下拉刷新 id
/// - parameter max_id:   上拉刷新 id
///
/// - returns: 微博数据的字典数组
class func checkCacheData(since_id: Int, max_id: Int) -> [[String: AnyObject]] {
    
    // 0. 创建数组
    var arrayM = [[String: AnyObject]]()
    
    guard let userId = UserAccountViewModel.sharedUserAccount.account?.uid else {
        return arrayM
    }
    
    // 1. 准备 SQL
    var sql = "SELECT statusId, status, userId FROM T_Status \n"
    sql += "WHERE userId = \(userId) \n"

    if since_id > 0 {       // 下拉刷新
        sql += "    AND statusId > \(since_id) \n"
    } else if max_id > 0 {  // 上拉刷新
        sql += "    AND statusId < \(max_id) \n"
    }
    sql += "ORDER BY statusId DESC LIMIT 20;"

    print("刷新 SQL \(sql)")

    // 2. 执行 SQL 返回获取结果
    SQLiteManager.sharedManager.queue.inDatabase() { (db) -> Void in
        
        guard let rs = db.executeQuery(sql) else {
            return
        }
        
        while rs.next() {
            let data = rs.dataForColumn("status")
            // JSON 反序列化
            let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: [])

            // 追加到数组
            arrayM.append(dict as! [String : AnyObject])
        }
    }

    // 3. 返回结果
    return arrayM
}
```

* 修改 `StatusListViewModel` 中的测试代码

```swift
// -- 检查本地数据 --
let array = StatusDAL.checkCacheData(since_id, max_id: max_id)
if array.count > 0 {
    print("有缓存数据")
} else {
    print("没有缓存数据")
}
```

### 实现 `loadStatus` 方法

* 实现 `StatusDAL` 中的加载微博函数

```swift
/// 加载微博数据
///
/// - parameter since_id:    下拉刷新 ID
/// - parameter max_id:      上拉刷新 ID
/// - parameter finished:    完成回调
class func loadStatus(since_id: Int, max_id: Int, finished: (array: [[String: AnyObject]]?) -> ()) {
    
    // 1. 检查本地是否存在数据缓存
    let array = StatusDAL.checkCacheData(since_id, max_id: max_id)
    if array.count > 0 {
        // 2. 如果有返回本地数据
        print("有缓存数据 \(array.count) 条")
        finished(array: array)
        return
    }
    
    // 3. 如果没有，加载网络数据
    print("加载网络数据")
    NetworkTools.sharedTools.loadStatus(since_id: since_id, max_id: max_id) { (result, error) -> () in
        if error != nil {
            print("出错了")
            finished(array: nil)
            return
        }
        
        // 判断 result 的数据结构是否争取
        guard let array = result?["statuses"] as? [[String: AnyObject]] else {
            print("数据格式错误")
            
            finished(array: nil)
            return
        }
        
        // 4. 将网络数据保存至本地数据库
        saveCacheData(array)
        
        // 5. 返回网络数据
        finished(array: array)
    }
}
```

* 修改 `StatusListViewModel` 模型中的 `loadStatus` 函数

```swift
StatusDAL.loadStatus(since_id, max_id: max_id) { (array) -> () in
    guard let array = array else {
        print("出错了")
        
        finished(isSuccessed: false)
        return
    }
    
    // 遍历字典的数组，字典转模型
```

> 运行测试
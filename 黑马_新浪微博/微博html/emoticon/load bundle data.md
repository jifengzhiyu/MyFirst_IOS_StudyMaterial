# 加载模型 & 显示表情

## 三种拖拽素材的方式

* 黄色文件夹：程序文件&框架文件
* 蓝色文件夹：主要用于游戏素材
* bundle：主要用于第三方框架的素材

> 项目中选择 `bundle` 的方式

## 建立模型

* 新建 `Emoticons.swift` 继承自 `NSObject` 处理数据模型

* 定义表情模型

```swift
/// 表情模型
class Emoticon: NSObject {
    /// 表情文字
    var chs: String?
    /// 表情图片文件名
    var png: String?
    /// emoji 编码
    var code: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["chs", "png", "code"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
}
```

* 定义表情包模型

```swift
/// 表情包模型
class EmoticonPackage: NSObject {
    /// 表情包路径名，浪小花的数据需要修改
    var id: String?
    /// 表情包名称
    var group_name_cn: String?
    /// 表情包数组
    lazy var emoticons = [Emoticon]()
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        id = dict["id"] as? String
        group_name_cn = dict["group_name_cn"] as? String

        if let array = dict["emoticons"] as? [[String: String]] {
            for d in array {
                emoticons.append(Emoticon(dict: d))
            }
        }
    }
    
    override var description: String {
        let keys = ["id", "group_name_cn", "emoticons"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
}
```

* 定义表情视图模型

```swift
/// 表情包视图模型
class EmoticonViewModel {
    
    // 表情包数组
    lazy var packages = [EmoticonPackage]()
    
    init() {
        // 加载表情包数据
    }
}
```

* 视图模型功能确定

![](加载表情包.png)

* 加载所有表情包数据

```swift
// MARK: - 构造函数
init() {
    // 1. emoticons.plist 路径
    guard let path = NSBundle.mainBundle().pathForResource("emoticons", ofType: "plist", inDirectory: "Emoticons.bundle") else {
        print("emoticons 文件不存在")
        return
    }
    
    // 2. 加载字典
    guard let dict = NSDictionary(contentsOfFile: path) else {
        print("数据加载错误")
        return
    }
    
    // 3. 提取 packages 中的 id 字符串对应的数组
    let array = (dict["packages"] as! NSArray).valueForKey("id") as! [String]
    
    // 4. 遍历数组，字典转模型
    for id in array {
        loadInfoPlist(id)
    }
}

/// 加载 id 目录下的 info.plist 文件
private func loadInfoPlist(id: String) {
    print(id)
}
```

* `loadInfoPlist` 函数实现

```swift
/// 加载 id 目录下的 info.plist 文件
private func loadInfoPlist(id: String) {
    // 1. 创建路径
    let path = NSBundle.mainBundle().pathForResource("info", ofType: "plist", inDirectory: "Emoticons.bundle/\(id)")!
    
    // 2. 加载字典
    let dict = NSDictionary(contentsOfFile: path) as! [String: AnyObject]
    
    // 3. 字典转模型
    packages.append(EmoticonPackage(dict: dict))
}
```

> 运行测试，数据模型已经加载完成

## 改造单例

* 将 `EmoticonViewModel` 重命名为 `EmoticonManager`
* 创建单例

```swift
/// 表情包管理器
class EmoticonManager {
    
    /// 单例
    static let sharedManager = EmoticonManager()
```

* 将 `init()` 修改为 `private`

* 修改为单例可以避免每次使用表情包数据时都要从磁盘重新加载一堆 plist 文件

## 小结

* 在开发模型的时候，强烈推荐重写 `description` 属性，否则数据的正确与否程序员很难在第一时间发现


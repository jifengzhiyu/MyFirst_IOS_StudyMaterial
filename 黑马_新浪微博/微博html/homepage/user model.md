# 用户模型

## 目标

* 在模型中增加自定义对象
* 嵌套自定义对象的字典转模型

## 定义用户模型

```swift
/// 用户数据模型
class User: NSObject {

    /// 用户UID
    var id: Int = 0
    /// 用户昵称
    var screen_name: String?
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    /// 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = 0
    /// 会员等级 0-6
    var mbrank: Int = 0
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

    override var description: String {
        let keys = ["id", "screen_name", "profile_image_url", "verified_type", "mbrank"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
}
```

## 在 `Status` 中针对用户模型增加处理

* 增加属性

```swift
/// 用户模型
var user: User?
```

* 描述字符串

```swift
override var description: String {
    let keys = ["created_at", "id", "text", "source", "user"]
    
    return dictionaryWithValuesForKeys(keys).description
}
```

> 运行测试，发现 user 字段被 KVO 设置成了字典

* 修改 `Status` 的构造函数

```swift
override func setValue(value: AnyObject?, forKey key: String) {
    // 判断 key 是否是 user
    if key == "user" {
        if let dict = value as? [String: AnyObject] {
            user = User(dict: dict)
        }
        return
    }
    
    super.setValue(value, forKey: key)
}
```

## 小结

* `setValuesForKeysWithDictionary` 会依次调用 `setValueForKey`
* 如果模型中包含 `自定义对象`，可以重写 `setValueForKey`
* 重写时需要注意
    * 设置完自定义对象属性后，需要 `return`
    * 在代码的最后需要 `super.setValue(value, forKey: key)`

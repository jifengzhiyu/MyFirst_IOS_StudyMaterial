# 用户账户模型

## 目标

* 使用网络返回的字典，进行字典转模型，转换成用户账户模型

## 代码实现

### 定义 UserAcount 模型

* 在 `Model` 目录下添加 `UserAccount` 类
* 定义模型属性

```swift
/// 用户帐号模型
/// - see: [http://open.weibo.com/wiki/OAuth2/access_token](http://open.weibo.com/wiki/OAuth2/access_token)
class UserAccount: NSObject {
    
    // 用于调用access_token，接口获取授权后的access token
    var access_token: String?
    // access_token的生命周期，单位是秒数
    var expires_in: NSTimeInterval = 0
    // 当前授权用户的UID
    var uid: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
```

### 创建用户模型

* 创建用户帐号模型，在 `OAuthViewController` 的网络回调代码中添加如下代码

```swift
NetworkTools.sharedTools.loadAccessToken(code) { (result, error) -> () in
    if error != nil {
        print("出错了")
        return
    }
    
    let account = UserAccount(dict: result as! [String: AnyObject])
    print(account)
}
```

* 运行测试程序会崩溃！

> 因为从新浪服务器返回的 `expires_in` 是整数而不是字符串

* 调整代码，验证 `expires_in` 数据类型

```swift
// 测试代码
responseSerializer = AFHTTPResponseSerializer()
request(.POST, URLString: "oauth2/access_token", parameters: params) { (result, error) -> () in
    let string = NSString(data: result as! NSData, encoding: NSUTF8StringEncoding)
    
    print(string)
}
```

> 再次运行测试

* 调试模型信息

* 与 OC 不同，如果要在 Swift 1.2 中调试模型信息，需要遵守 `Printable` 协议，并且重写 `description` 的 `getter` 方法，在 Swift 2.0 中，`description` 属性定义在 `CustomStringConvertible` 协议中

```swift
override var description: String {
    let keys = ["access_token", "expires_in", "uid"]
    
    return dictionaryWithValuesForKeys(keys).description
}
```

## 小结

* 在实际开发中，建议在属性说明未知粘贴 后端提供的接口文档说明
* 如果服务器返回输入无法解析
    * 设置响应格式为二进制的 `AFHTTPResponseSerializer`
    * 将响应结果的二进制数据转换成 字符串 输出
    * 在 JSON 字符串中，如果数字没有使用引号，反序列化时会转换成 `NSNumber`
* 为了方便程序调试，在模型对象中，建议重写 `description` 属性


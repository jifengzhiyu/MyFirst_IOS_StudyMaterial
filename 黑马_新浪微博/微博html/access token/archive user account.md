# 归档 & 解档

## 目标

* 对比 OC 的`归档 & 解档`实现
* 利用`归档 & 解档`保存用户信息

## 代码实现

* 遵守协议

```swfit
class UserAccount: NSObject, NSCoding
```

* 实现协议方法

```swift
// MARK: - 归档 & 解档
/// 归档 -> 将当前对象归档保存至二进制文件之前被调用
///
/// - parameter aCoder: 编码器
func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(access_token, forKey: "access_token")
    aCoder.encodeObject(expiresDate, forKey: "expiresDate")
    aCoder.encodeObject(uid, forKey: "uid")
    aCoder.encodeObject(screen_name, forKey: "screen_name")
    aCoder.encodeObject(avatar_large, forKey: "avatar_large")
}

/// 解档 -> 从二进制文件恢复成对象时调用，与网络的反序列化功能类似
///
/// - parameter aDecoder: 解码器
///
/// - returns: 用户账户对象
required init?(coder aDecoder: NSCoder) {
    access_token = aDecoder.decodeObjectForKey("access_token") as? String
    expiresDate = aDecoder.decodeObjectForKey("expiresDate") as? NSDate
    uid = aDecoder.decodeObjectForKey("uid") as? String
    screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
    avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
}
```

> 注意：指定构造函数不能在 `extension` 中实现

* 实现将当前对象归档保存的函数

```swift
/// 将当前对象保存至沙盒
func saveUserAccount() {
    var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
    path = (path as NSString).stringByAppendingPathComponent("account.plist")
    
    print(path)
    
    NSKeyedArchiver.archiveRootObject(self, toFile: path)
}
```

* 修改 `` 的 `` 函数，加载完用户信息后归档保存

```swift
account.screen_name = dict["screen_name"] as? String
account.avatar_large = dict["avatar_large"] as? String

account.saveUserAccount()
```

## 小结

* 在 Swift 中如果是数据类型之间的桥接转换，可以直接使用 `as`，例如 String -> NSString，数组 -> NSArray，字典 -> NSDictionary
* 从 Xcode 7 beta 5开始，如果要拼接路径，需要将字符串转换成 `NSString`
* 归档方法是将对象以二进制形式保存至磁盘前被调用，与网络的序列化类似
* 解档方法是将二进制数据从磁盘读取并且转换成对象时被调用，与网络的反序列化类似
* 调用归档使用 `NSKeyedArchiver`
* 调用解档使用 `NSKeyedUnarchiver`

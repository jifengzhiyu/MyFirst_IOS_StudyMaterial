# 设置过期日期

* 在新浪微博返回的数据中，过期日期是以当前系统时间加上秒数计算的，为了方便后续使用，增加过期日期属性

## 目标

* 定义过期日期属性，便于后续判断 token 的有效期

## 代码实现

* 定义属性

```swift
/// access_token过期日期
var expiresDate: NSDate?
```

* 在 `expires_in` 的 `didSet` 中增加过期日期设置 

```swift
var expires_in: NSTimeInterval = 0 {
    didSet {
        expiresDate = NSDate(timeIntervalSinceNow: expires_in)
    }
}
```

* 修改 `description`

```swift
let keys = ["access_token", "expires_in", "expiresDate", "uid"]
```

## 小结

* 在重写 `description` 属性时，不一定要包含所有属性，但是一定要包含对象中的重要属性，以方便开发调试
* `description` 属性类似于 JAVA 中的 `toString()` 函数，在很多公司的开发规范中，`toString()` 是必须实现的
* 重写模型的 `description` 是一个很好的习惯

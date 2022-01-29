# emoji 的使用

* 新建 `NSString+Emoji.swift` 文件

```swift
/// 扫描当前16进制字符串生成 emoji 字符串
var emoji: NSString {
    let scanner = NSScanner(string: self as String)
    
    var value: UInt32 = 0
    scanner.scanHexInt(&value)
    
    let c = Character(UnicodeScalar(value))
    return String(c)
}
```

* Swift 调用

```swift
print("0x1f60d".emoji)
```

* OC 调用

```swift
NSString *str = @"0x1f60d";
NSLog(@"%@", str.emoji);
```

# 显示表情符号

* 定义表情包数组懒加载属性

```swift
/// 表情包数组
private lazy var packages = EmoticonManager.sharedManager.packages
```

* 修改数据源方法

```swift
/// 表情包数量
func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return packages.count
}

/// 表情包中的表情数量
func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return packages[section].emoticons.count
}
```

> 注意：在表情键盘开发中，如果使用视图模型中转反而会麻烦，因为本质上需要传递的就是`表情符号`模型

* 设置表情图片

```swift
/// 表情符号
/// 表情符号
var emoticon: Emoticon? {
    didSet {
        emoticonButton.setImage(UIImage(named: emoticon!.png!), forState: .Normal)
    }
}
```

> 运行测试，发现无法显示图片，原因是 em.png 中只有图片的名称，而没有图片路径

* 修改 `EmoticonPackage` 的构造函数

```swift
if let array = dict["emoticons"] as? [[String: String]] {
    for var d in array {
        if let png = d["png"], let dir = id {
            d["png"] = dir + "/" + png
        }
        
        emoticons.append(Emoticon(dict: d))
    }
}
```

* 在 `Emoticon` 的模型中增加计算型属性

```swift
/// 完整的图像路径
var imagePath: String {
    return png == nil ? "" : NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + png!
}
```

* 设置图像

```swift
/// 表情符号
var emoticon: Emoticon? {
    didSet {
        emoticonButton.setImage(UIImage(contentsOfFile: emoticon!.imagePath), forState: .Normal)
    }
}
```

* 新建 `String+Emoji` 分类

```swift
extension String {
    
    // 从当前 16 进制字符串中扫描生成 emoji 字符串
    var emoji: String {
        
        let scanner = NSScanner(string: self)
        var value: UInt32 = 0
        scanner.scanHexInt(&value)
        
        return String(Character(UnicodeScalar(value)))
    }
}
```

* 在 `Emoticon` 模型中增加 `emoji` 属性

```swift
/// emoji 编码
var code: String? {
    didSet {
        emoji = code?.emoji
    }
}
/// emoji 字符串
var emoji: String?
```

* 在 `EmoticonViewCell` 设置 UI

```swift
/// 表情符号
var emoticon: Emoticon? {
    didSet {
        emoticonButton.setImage(UIImage(contentsOfFile: emoticon!.imagePath), forState: .Normal)
        emoticonButton.setTitle(emoticon?.emoji, forState: .Normal)
    }
}
```

* 设置按钮字体

```swift
emoticonButton.titleLabel?.font = UIFont.systemFontOfSize(32)
```

> 提示：此处需要注意 cell 的重用问题


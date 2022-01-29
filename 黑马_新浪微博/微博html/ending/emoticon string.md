# 表情字符串

## 新建项目测试表情字符串转换

* 新建项目
* 将 `Emoticon` 目录拖拽到新建项目中，注意不要勾选 `Copy items if needed`，如下图所示

> 这样做的好处是，开发测试时，一旦对代码进行调整，原始项目中的代码会一起调整

* 设定目标
    - 给定一个表情字符串文字 `我[爱你]啊[笑哈哈]！` 返回对应的属性文本
    - `[爱你]` 来自 `默认` 分组
    - `[笑哈哈]` 来自 `浪小花` 分组

```swift
/// 使用字符串查找表情符号
///
/// - parameter string: [爱你]
///
/// - returns: 表情模型
private func emoticon(string: String) -> Emoticon? {
    
    // 1. 遍历表情包的数组
    for p in EmoticonManager.sharedManager.packages {
        
        // 2. 在 emoticons 数组中查找 chs == string 的表情符号
        if let em = p.emoticons.filter({ (em) -> Bool in
            return em.chs == string
        }).last {
            return em
        }
    }
    
    return nil
}
```

* 使用正则表达式过滤表情字符串

```swift
/// 使用正则表达式将字符串替换成带表情图片的属性字符串
///
/// - parameter string: 字符串
///
/// - returns: 带表情的属性字符串
func emoticonText(string: String, font: UIFont) -> NSAttributedString {
    
    let strM = NSMutableAttributedString(string: string)
    
    // 1. 正则表达式
    let pattern = "\\[.*?\\]"
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    
    let results = regex.matchesInString(string,
        options: [],
        range: NSRange(location: 0, length: string.characters.count))
    
    var count = results.count
    
    // 倒着遍历
    while count > 0 {
        let result = results[--count]
        
        let range = result.rangeAtIndex(0)
        let emStr = (string as NSString).substringWithRange(range)

        if let em = emoticon(emStr) {
            let imageText = EmoticonAttachment(emoticon: em).imageText(font)
            strM.replaceCharactersInRange(range, withAttributedString: imageText)
        }
    }
    
    return strM.copy() as! NSAttributedString
}
```

> 运行测试

* 将以上两个函数移动到 `EmoticonManager` 中

## 在微博项目中使用表情文字

* 重新打开微博项目，会发现测试好的函数已经在那里
* 修改 `StatusCell`

```swift
// 原创微博文本
let text = viewModel?.status.text ?? ""
contentLabel.attributedText = EmoticonManager.sharedManager.emoticonText(text, font: contentLabel.font)
```

* 修改 `StatusForwardCell`

```swift
// 转发微博的文字
let text = viewModel?.retweetedText ?? ""
retweetedLabel.attributedText = EmoticonManager.sharedManager.emoticonText(text, font: retweetedLabel.font)
```

> 运行测试 :D


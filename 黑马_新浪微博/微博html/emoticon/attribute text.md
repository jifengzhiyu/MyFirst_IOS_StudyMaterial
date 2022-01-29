# 属性文本

* 删除按钮

```swift
func insertEmoticon(em: Emoticon) {
    print(em)
    
    // 1. 空白表情
    if em.isEmpty {
        return
    }
    
    // 2. 删除按钮
    if em.isRemoved {
        textView.deleteBackward()
        return
    }
}
```

* emoji

```swift
// 3. emoji
if let emoji = em.emoji {
    textView.replaceRange(textView.selectedTextRange!, withText: emoji)
    return
}
```

## 图文混排演练

> 核心思想：将图片转换成 `NSTextAttachment` 然后再转换成 `NSAttributedString`

* 在文本中插入图片

```swift
// 1> 创建图像附件
let attachment = NSTextAttachment()
attachment.image = UIImage(contentsOfFile: em.imagePath)

let imageText = NSAttributedString(attachment: attachment)

// 2> 获取 textView 的属性文本
let textM = NSMutableAttributedString(attributedString: textView.attributedText)

// 替换属性文本内容
textM.replaceCharactersInRange(textView.selectedRange, withAttributedString: imageText)

// 3> 重新更新 textView 中的属性文本
textView.attributedText = textM
```

> 问题：插入文本之后，光标会移动到文本末尾

* 记录并恢复光标位置

```swift
// 3> 重新更新 textView 中的属性文本
// 1) 记录光标位置
let range = textView.selectedRange
// 2) 设置属性文本
textView.attributedText = textM
// 3) 恢复光标位置
textView.selectedRange = NSRange(location: range.location + 1, length: 0)
```

> 问题：插入图片太大

* 设置 attachment 的 bounds 属性

```swift
let lineHeight = textView.font!.lineHeight
attachment.bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
```

* `bounds` 的值就是 scrollView 的 `contentOffset` 的值

> 问题：插入文本之后，字体大小会变化

* 原因：新实例化了一个 `NSAttributedString`，但是没有设置改文本的初始字体属性

```swift
// 创建可变属性文本
let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
// 添加字体
imageText.addAttribute(NSFontAttributeName, value: textView.font!, range: NSRange(location: 0, length: 1))
```

## 发布文本处理

> 在发送微博时，只发送表情符号对应的文本，而不是表情图片

* 目标：界面上显示图片，但是能够拿到完整的文本字符串

* 打印属性文本

```swift
@IBAction func emoticonText(sender: AnyObject) {
    print(textView.attributedText)
}
```

* 遍历属性文本

```swift
let attrString = textView.attributedText

attrString.enumerateAttributesInRange(NSRange(location: 0, length: attrString.length), options: []) { (dict, range, _)  in

    print("-------")
    print(dict)
    print(range)
}
```

* 根据输出判定如果字典中包含 `NSAttachment` 择是图片，否则是文本

```swift
attrString.enumerateAttributesInRange(NSRange(location: 0, length: attrString.length), options: []) { (dict, range, _)  in

    print("-------")
    if let attachment = dict["NSAttachment"] as? NSTextAttachment {
        print("图片 \(attachment)")
    } else {
        let str = (attrString.string as NSString).substringWithRange(range)
        print("字符串 \(str)")
    }
}
```

> 下一目标：如何从 `NSAttachment` 中获得表情符号？

* 自定义 `NSAttachment` 子类，增加唯一的属性

```swift
/// 表情符号附件
class EmoticonAttachment: NSTextAttachment {

    /// 表情符号对象
    var emoticon: Emoticon
    
    // MARK: - 构造函数
    init(emoticon: Emoticon) {
        self.emoticon = emoticon
        
        super.init(data: nil, ofType: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

* 创建属性图片时设置 chs

```swift
// 1> 创建图像附件
let attachment = EmoticonAttachment(emoticon: em)
```

* 生成完整的文本内容

```swift
@IBAction func emoticonText(sender: AnyObject) {
    
    let attrText = textView.attributedText
    var strM = String()

    attrText.enumerateAttributesInRange(NSRange(location: 0, length: attrText.length),
        options: []) { (dict, range, _) in
            
            if let attachment = dict["NSAttachment"] as? EmoticonAttachment {
                strM += attachment.emoticon.chs ?? ""
            } else {
                let str = (attrText.string as NSString).substringWithRange(range)
                strM += str
            }
    }

    print("最终结果 \(strM)")
}
```

## 代码重构

* 在 `EmoticonAttachment` 中增加函数创建属性文本

```swift
/// 生成带图片的字符串
func imageText(font: UIFont) -> NSAttributedString {
    image = UIImage(contentsOfFile: emoticon.imagePath)
    let lineHeight = font.lineHeight
    bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
    
    let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: self))
    imageText.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: 1))
    
    return imageText
}
```

* 修改 `insertEmoticon` 函数

```swift
// 1. 图片文字
let imageText = EmoticonAttachment(emoticon: em).imageText(textView.font!)
```

* 新建 `UITextView+Extension.swift`

* 抽取插入表情符号函数

```swift
/// 插入表情符号
///
/// - parameter em: 表情模型
func insertEmoticon(em: Emoticon) {
    // 1. 空白按钮
    if em.isEmpty {
        return
    }
    
    // 2. 删除按钮
    if em.isRemoved {
        deleteBackward()
        return
    }
    
    // 3. emoji
    if let emoji = em.emoji {
        replaceRange(selectedTextRange!, withText: emoji)
        return
    }
    
    // 4. 图片表情
    insertImageEmoticon(em)
}

/// 插入图片表情
///
/// - parameter em: 表情模型
private func insertImageEmoticon(em: Emoticon) {
    
    // 1. 图片文字
    let imageText = EmoticonAttachment(emoticon: em).imageText(font!)
    
    // 2. 获得 textView 的完整文本
    let strM = NSMutableAttributedString(attributedString: attributedText)
    
    // 1> 替换文本内容
    strM.replaceCharactersInRange(selectedRange, withAttributedString: imageText)
    
    // 2> 记录光标位置
    let range = selectedRange
    
    // 3> 重新替换 textView 的内容
    attributedText = strM
    
    // 4> 恢复光标位置
    selectedRange = NSRange(location: range.location + 1, length: 0)
}
```

* 抽取完整文本计算型属性

```swift
/// 返回 textView 的完整表情字符串
var emoticonText: String {
    let attrText = attributedText
    var strM = String()
    
    attrText.enumerateAttributesInRange(NSRange(location: 0, length: attrText.length),
        options: []) { (dict, range, _) in
            
            if let attachment = dict["NSAttachment"] as? EmoticonAttachment {
                strM += attachment.emoticon.chs ?? ""
            } else {
                let str = (attrText.string as NSString).substringWithRange(range)
                strM += str
            }
    }
    
    return strM
}
```


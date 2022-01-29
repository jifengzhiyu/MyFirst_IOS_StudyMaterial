# 长度提示标签

* 定义微博文字最大长度常量

```swift
/// 最大撰写长度
private let ComposeMaxLength = 10
```

* 发布微博前检查文字长度

```swift
let text = textView.emoticonText

if text.characters.count > ComposeMaxLength {
    SVProgressHUD.showInfoWithStatus("输入的内容太长", maskType: .Gradient)
    return
}
```

## 长度提示标签

* 定义长度提示标签

```swift
/// 长度提示标签
private lazy var lengthTipLabel: UILabel = UILabel(title: "\(ComposeMaxLength)", fontSize: 12)
```

* 添加控件&设置布局

```swift
// 长度提示标签
view.addSubview(lengthTipLabel)

lengthTipLabel.snp_makeConstraints { (make) -> Void in
    make.bottom.equalTo(textView.snp_bottom).offset(-8)
    make.right.equalTo(textView.snp_right).offset(-8)
}
```

* 在代理方法中设置提示标签内容

```swift
let length = ComposeMaxLength - textView.emoticonText.characters.count
lengthTipLabel.text = "\(length)"
lengthTipLabel.textColor = length >= 0 ? UIColor.darkGrayColor() : UIColor.redColor()
```

# 整合表情键盘

* 将测试项目中的 `Emoticon` 拖拽至项目中
* 在 `ComposeViewController` 中添加以下代码

```swift
/// 表情键盘视图
private lazy var emoticonView: EmoticonView = EmoticonView { [weak self] (emoticon) -> () in
    self?.textView.insertEmoticon(emoticon)
}
```

* 修改选择表情函数

```swift
/// 选择表情键盘
@objc private func selectEmoticon() {
    textView.resignFirstResponder()
    
    textView.inputView = textView.inputView == nil ? emoticonViewController.view : nil
    
    textView.becomeFirstResponder()
}
```

> 运行测试会发现键盘会上下跳动

## 动画选项

* 修改键盘监听的动画方法

```swift
// 动画曲线选项
let curve = (n.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue
...

// 动画
UIView.animateWithDuration(duration) {
    // 设置动画曲线
    UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!)
    self.view.layoutIfNeeded()
}
```

> 苹果官方没有提供关于 `UIViewAnimationCurve` 数值等于 `7` 的文档说明，不过通过实际测试发现，可以设置动画的优先级

* UIViewAnimationCurve == 7 时
    * 如果图层之前动画没有结束，会被终止并执行后续的动画
    * 同时将动画时长修改为 `0.5 s`，并且设定的动画时长不再有效

* 测试动画时长

```swift
let anim = toolbar.layer.animationForKey("position")
print("动画时长 \(anim?.duration)")
```


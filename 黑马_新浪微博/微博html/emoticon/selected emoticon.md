# 选中表情事件传递

* 添加表情键盘视图的构造函数

```swift
/// 选中表情回调函数
private var selectedEmoticonCallBack: (emoticon: Emoticon) -> ()

// MARK: - 构造函数
init(selectedEmoticon: (emoticon: Emoticon) -> ()) {
    self.selectedEmoticonCallBack = selectedEmoticon
    
    var rect = UIScreen.mainScreen().bounds
    rect.size.height = 216
    
    super.init(frame: rect)
    
    // 设置控件
    setupUI()
    
    // 跳转到默认分组
    let indexPath = NSIndexPath(forItem: 0, inSection: 1)
    dispatch_async(dispatch_get_main_queue()) {
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
    }
}
```

* 调整初始化方法

```swift
/// 表情键盘视图
private lazy var emoticonView: EmoticonView = EmoticonView { [weak self] (emoticon) -> () in
    self?.insertEmoticon(emoticon)
}

/// 插入表情符号
///
/// - parameter em: 表情符号
func insertEmoticon(em: Emoticon) {
    textView.text = em.chs
}
```

> 注意：此处会有循环引用！

* 在 `prepareCollectionView` 函数中设置代理

```swift
collectionView.delegate = self
```

* CollectionView 代理方法

```swift
func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let em = packages[indexPath.section].emoticons[indexPath.item]
    
    selectedEmoticonCallBack(emoticon: em)
}
```

* 禁用按钮的用户交互属性

```swift
emoticonButton.userInteractionEnabled = false
```

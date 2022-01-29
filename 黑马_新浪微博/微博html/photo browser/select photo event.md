# 选择照片事件传递

## 照片选中代理

* 在 `StatusPictureView` 的 `initWithFrame` 函数中设置 `collectionView` 的代理

```swift
delegate = self
```

* 利用 `extension` 遵守 `UICollectionViewDelegate` 协议

```swift
extension StatusPictureView: UICollectionViewDataSource, UICollectionViewDelegate {
```

* 实现协议方法

```swift
func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    print(viewModle?.thumbnailUrls![indexPath.item])
}
```

## 利用通知中心传递事件

* 定义通知常量

```swift
/// 选中缩略图照片通知
let WBStatusSelectedPhotoNotification = "WBStatusSelectedPhotoNotification"
```

* 定义通知字典键值常量

```swift
/// 选中 URL 数组 KEY
let WBStatusSelectedPhotoURLKey = "WBStatusSelectedURLKey"
/// 选中 索引 KEY
let WBStatusSelectedPhotoIndexPathKey = "WBStatusSelectedIndexPathKey"
```

* 发送通知

```swift
/// 选中照片
func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    print(viewModle?.thumbnailUrls![indexPath.item])
    
    // 发送通知
    NSNotificationCenter.defaultCenter().postNotificationName(WBStatusSelectedPhotoNotification,
        object: self,
        userInfo: [WBStatusSelectedPhotoURLKey: viewModle!.thumbnailUrls!,
            WBStatusSelectedPhotoIndexPathKey: indexPath])
}
```

* 在 `HomeTableViewController` 的 `viewDidLoad` 函数中增加通知监听处理

```swift
// 注册通知
NSNotificationCenter.defaultCenter().addObserverForName(WBStatusSelectedPhotoNotification,
    object: nil,
    queue: nil) { (n) -> Void in
        print(n)
        print(NSThread.currentThread())
}
```

* 在 `deinit` 中注销通知

```swift
// 注销通知
deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
}
```

### 通知小结

* 包含的属性
    * name - 通知名，通知中心监听的字符串
    * object - 通常时发送通知的对象
    * userinfo - 发送通知时附加传递的数据字典
* 使用场景
    * 单向数据传递，不需要返回值
    * 视图层次嵌套较深，不适合用代理传值时，可以考虑使用通知
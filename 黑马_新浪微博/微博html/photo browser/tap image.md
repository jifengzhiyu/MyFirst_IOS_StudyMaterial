# 点击照片关闭控制器

* 定义协议

```swift
// MARK: - 照片查看 Cell 代理
protocol PhotoBrowserCellDelegate: NSObjectProtocol {
    /// 点击照片图像视图
    func photoBrowserCellDidClickImage()
}
```

* 定义代理

```swift
weak var photoDelegate: PhotoBrowserCellDelegate?
```

* 点击图像监听方法

```swift
// MARK: - 监听方法
@objc private func tapImage() {
    photoDelegate?.photoBrowserCellDidClickImage()
}
```

* 添加手势识别

```swift
// 4. 添加手势识别
let tap = UITapGestureRecognizer(target: self, action: "tapImage")
imageView.userInteractionEnabled = true
imageView.addGestureRecognizer(tap)
```

* 设置代理

```swift
cell.photoDelegate = self
```

* 实现协议方法

```swift
// MARK: - PhotoBrowserCellDelegate
extension PhotoBrowserViewController: PhotoBrowserCellDelegate {
    
    func photoBrowserCellDidClickImage() {
        close()
    }
}
```

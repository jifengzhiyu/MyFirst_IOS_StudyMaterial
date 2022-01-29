# 交互式转场

## 传递缩放比例，实现简单交互转场

* 在 `PhotoBrowserCell` 中定义协议，传递 imageView 的缩放比例

```swift
protocol PhotoBrowserCellDelegate: NSObjectProtocol {
    /// 图像视图被点按
    func photoBrowserCellDidTapImage()
    /// 图像视图缩放
    func photoBrowserCellDidZoom(scale: CGFloat)
}
```

* 传递缩放比例

```swift
func scrollViewDidZoom(scrollView: UIScrollView) {
    photoDelegate?.photoBrowserCellDidZoom(imageView.transform.a)
}
```

* 在控制器中实现代理方法

```swift
// MARK: - PhotoBrowserCellDelegate
extension PhotoBrowserViewController: PhotoBrowserCellDelegate {
    
    /// 图像视图被点按
    func photoBrowserCellDidTapImage() {
        close()
    }
    
    /// 图像视图缩放
    func photoBrowserCellDidZoom(scale: CGFloat) {
        print(scale)
    }
}
```

* 实现照片缩放代理方法

```swift
/// 图像视图缩放
func photoBrowserCellDidZoom(scale: CGFloat) {
    
    // 1. 判断是否缩放视图
    if scale < 1.0 {
        view.alpha = scale
        view.transform = CGAffineTransformMakeScale(scale, scale)
    }
}
```

> 运行测试

* 存在问题
    * 保存按钮 & 关闭按钮应该隐藏
    * 视图的背景颜色影像视觉效果

### 缩放细节

* 隐藏控件

```swift
/// 隐藏控件
private func hiddenControls(isHidden: Bool) {
    closeButton.hidden = isHidden
    saveButton.hidden = isHidden
    
    collectionView.backgroundColor = isHidden ? UIColor.clearColor() : UIColor.blackColor()
}
```

* 调整缩放函数

```swift
/// 图像视图缩放
func photoBrowserCellDidZoom(scale: CGFloat) {
    
    // 0. 是否交互
    let startInteraction = scale < 1.0
    
    // 1. 隐藏控件
    hiddenControls(startInteraction)
    
    // 2. 判断是否缩放视图
    if startInteraction {
        view.alpha = scale
        view.transform = CGAffineTransformMakeScale(scale, scale)
    } else {
        view.alpha = 1
        view.transform = CGAffineTransformIdentity
    }
}
```

## 释放手势解除转场

* 在 `PhotoBrowserCellDelegate` 协议中将 `photoBrowserCellDidTapImage` 修改为 `PhotoBrowserCellDelegate`

```swift
protocol PhotoBrowserCellDelegate: NSObjectProtocol {
    /// 图像视图将要关闭
    func photoBrowserCellShouldDismiss()
    /// 图像视图缩放
    func photoBrowserCellDidZoom(scale: CGFloat)
}
```

* 修改图像点按监听方法

```swift
// MARK: - 监听方法
@objc private func tapImage() {
    photoDelegate?.photoBrowserCellShouldDismiss()
}
```

* 修改 UIScrollView 的完成缩放代理方法

```swift
/// 缩放完成后执行一次
///
/// - parameter scrollView: scrollView
/// - parameter view:       view 被缩放的视图
/// - parameter scale:      被缩放的比例
func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
    
    // 如果缩放比例 < 1 通知控制器关闭界面
    if scale < 1 {
        photoDelegate?.photoBrowserCellShouldDismiss()
        return
    }
    
    // 设置图片间距
    var offsetY = (scrollView.bounds.height - view!.frame.height) * 0.5
    offsetY = offsetY < 0 ? 0 : offsetY
    
    var offsetX = (scrollView.bounds.width - view!.frame.width) * 0.5
    offsetX = offsetX < 0 ? 0 : offsetX
    
    // 设置间距
    scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
}
```

* 修改控制器函数

```swift
/// 图像视图将要关闭
func photoBrowserCellShouldDismiss() {
    close()
}
```

### 修改展现转场动画中的图片闪烁问题

* 取消 `PhotoBrowserViewController` 的 `collectionView` 属性的 `private` 修饰
* 修改 `presentAnimation` 函数，获取 collectionView

```swift
// 2. 获取目标控制器
let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! PhotoBrowserViewController
toVC.collectionView.hidden = true
```

* 动画结束后，再显示 collectionView

```swift
// 4. 开始动画
UIView.animateWithDuration(transitionDuration(transitionContext),
    animations: { () -> Void in

        iv.frame = presentDelegate.photoBrowserPresentToRect(indexPath)
        toView.alpha = 1
        
    }) { (_) -> Void in
        
        // 将图像视图删除
        iv.removeFromSuperview()
        toVC.collectionView.hidden = false
        
        // 告诉系统转场动画完成
        transitionContext.completeTransition(true)
}
```

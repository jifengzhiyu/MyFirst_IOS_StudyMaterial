# 转场动画进阶

## 目标

* 从哪里来 到哪里去
* 利用代理封装转场动画框架，解除控制器之间的耦合
* 不同视图之间的坐标系转换

## 代码实现

### 展现转场协议

* 在 `PhotoBrowserAnimator` 中定义协议 `PhotoBrowserPresentDelegate`

```swift
// MARK: - 照片浏览器展现转场代理
protocol PhotoBrowserPresentDelegate: NSObjectProtocol {
    
    /// 参与转场动画的图像视图
    ///
    /// - parameter indexPath: 照片索引
    ///
    /// - returns: 参与转场动画的全新图像视图
    func imageViewForPresent(indexPath: NSIndexPath) -> UIImageView
    
    /// 展现转场图像起始位置
    ///
    /// - parameter indexPath: 照片索引
    ///
    /// - returns: 相对于屏幕的位置
    func photoBrowserPresentFromRect(indexPath: NSIndexPath) -> CGRect

    /// 展现动画结束时的屏幕位置
    ///
    /// - parameter indexPath: 照片索引
    ///
    /// - returns: 相对于屏幕的位置
    func photoBrowserPresentToRect(indexPath: NSIndexPath) -> CGRect
}
```

#### 实现协议方法

* 让 `StatusPictureView` 遵守协议

```swift
// MARK: - PhotoBrowserPresentDelegate
extension StatusPictureView: PhotoBrowserPresentDelegate {
}
```

* 图像视图协议方法

```swift
/// 参与转场动画的图像视图
///
/// - parameter indexPath: 照片索引
///
/// - returns: 参与转场动画的全新图像视图
func imageViewForPresent(indexPath: NSIndexPath) -> UIImageView {
    
    let iv = UIImageView()
    
    iv.contentMode = .ScaleAspectFill
    iv.clipsToBounds = true
    
    let key = viewModle!.thumbnailUrls![indexPath.item].absoluteString
    iv.image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
    
    iv.sizeToFit()
    
    return iv
}
```

##### 起始位置

* 起始位置协议方法

```swift
/// 展现转场图像起始位置
///
/// - parameter indexPath: 当前选中照片的索引
///
/// - returns: 相对于屏幕的位置
func photoBrowserPresentFromRect(indexPath: NSIndexPath) -> CGRect {
    
    guard let cell = self.cellForItemAtIndexPath(indexPath) else {
        return CGRectZero
    }
    
    let rect = self.convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
    print(rect)
    let v = UIView()
    v.backgroundColor = UIColor.redColor()
    v.frame = rect
    UIApplication.sharedApplication().keyWindow?.addSubview(v)
    return rect
}
```

* 测试起始位置

```swift
/// 选中照片
func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    // 测试协议方法
    photoBrowserPresentFromRect(indexPath)
    
```

* 使用 imageView 替代临时视图，再次测试

```swift
/// 展现转场图像起始位置
///
/// - parameter indexPath: 当前选中照片的索引
///
/// - returns: 相对于屏幕的位置
func photoBrowserPresentFromRect(indexPath: NSIndexPath) -> CGRect {
    
    guard let cell = self.cellForItemAtIndexPath(indexPath) else {
        return CGRectZero
    }
    
    let rect = self.convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
    
    let v = imageViewForPresent(indexPath)
    v.frame = rect
    
    UIApplication.sharedApplication().keyWindow?.addSubview(v)
    return rect
}
```

##### 目标位置

* 实现目标位置协议方法

```swift
/// 展现动画结束时的屏幕位置
///
/// - parameter indexPath: 当前选中照片的索引
///
/// - returns: 相对于屏幕的位置
func photoBrowserPresentToRect(indexPath: NSIndexPath) -> CGRect {
    
    let iv = imageViewForPresent(indexPath)
    iv.center = UIApplication.sharedApplication().keyWindow!.center
    
    UIApplication.sharedApplication().keyWindow?.addSubview(iv)
    
    return iv.frame
}
```

* 测试目标位置

```swift
/// 选中照片
func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    // 测试协议方法
    photoBrowserPresentFromRect(indexPath)
    photoBrowserPresentToRect(indexPath)
```

### 展现转场属性

* 在 `PhotoBrowserAnimator` 定义协议属性

```swift
/// 展现转场代理对象
weak var presentDelegate: PhotoBrowserPresentDelegate?
/// 展现动画对应的照片索引
var indexPath: NSIndexPath?
```

* 添加函数设置属性参数

```swift
/// 设置代理参数
///
/// - parameter presentDelegate: 展现转场代理
/// - parameter indexPath:       照片索引
func setDelegateParams(presentDelegate: PhotoBrowserPresentDelegate,
    indexPath: NSIndexPath) {
        
        self.presentDelegate = presentDelegate
        self.indexPath = indexPath
}
```

* 在 `HomeTableViewController` 为动画代理对象设置属性数值

```swift
guard let cell = n.object as? PhotoBrowserPresentDelegate else {
    return
}

let vc = PhotoBrowserViewController(urls: urls, indexPath: indexPath)

// 1. 设置转场动画类型
vc.modalPresentationStyle = UIModalPresentationStyle.Custom
// 2. 设置转场动画代理
vc.transitioningDelegate = self?.photoBrowserAnimator
// 3. 设置转场动画参数
self?.photoBrowserAnimator.setDelegateParams(cell, indexPath: indexPath)
```

### 展现转场动画

* 实现展现动画转场

```swift
/// 展现转场动画
///
/// - parameter transitionContext: 转场上下文
private func presentAnimation(transitionContext: UIViewControllerContextTransitioning) {
    
    guard let presentDelegate = presentDelegate, indexPath = indexPath else {
        return
    }
    
    // 1. 真正要展现的视图
    // 1> 获取视图
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    // 2> 添加到容器视图
    transitionContext.containerView()?.addSubview(toView)
    // 3> 设置透明度
    toView.alpha = 0
    
    // 2. 转场动画中的`大米`视图
    // 1> 建立转场动画图像视图
    let iv = presentDelegate.imageViewForPresent(indexPath)
    // 2> 设置起始位置
    iv.frame = presentDelegate.photoBrowserPresentFromRect(indexPath)
    // 3> 将图像视图添加到容器视图
    transitionContext.containerView()?.addSubview(iv)
    
    // 5. 动画转场
    UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
        
        iv.frame = presentDelegate.photoBrowserPresentToRect(indexPath)
        iv.alpha = 0
        toView.alpha = 1.0
        
        }) { _ in
            
            // 删除动画转场的图像视图
            iv.removeFromSuperview()
            
            transitionContext.completeTransition(true)
    }
}
```

* 修改目标视图位置

```swift
/// 展现动画结束时的屏幕位置
///
/// - parameter indexPath: 当前选中照片的索引
///
/// - returns: 相对于屏幕的位置
func photoBrowserPresentToRect(indexPath: NSIndexPath) -> CGRect {

    let key = viewModle!.thumbnailUrls![indexPath.item].absoluteString
    guard let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key) else {
        return CGRectZero
    }
    
    let w = UIScreen.mainScreen().bounds.width
    let h = image.size.height * w / image.size.width
    var y: CGFloat = 0
    
    let screenHeight = UIScreen.mainScreen().bounds.height
    if h < screenHeight {
        y = (screenHeight - h) * 0.5
    }

    return CGRect(x: 0, y: y, width: w, height: h)
}
```

### 解除转场动画

* 修改解除转场动画方法

```swift
/// 解除转场动画
///
/// - parameter transitionContext: 转场上下文
private func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
    
    guard let presentDelegate = presentDelegate, indexPath = indexPath else {
        return
    }
    
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
    let rect = presentDelegate.photoBrowserPresentFromRect(indexPath)
    
    UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
        
        fromView.frame = rect
        
        }) { _ in
            
            fromView.removeFromSuperview()
            transitionContext.completeTransition(true)
    }
}
```

> 运行测试发现整个 view 移动，而不是图像视图移动

* 定义解除转场动画协议

```swift
// MARK: - 照片浏览器解除转场代理
protocol PhotoBrowserDismissDelegate: NSObjectProtocol {
    
    /// 解除转场动画的图像视图
    func imageViewForDismiss() -> UIImageView
    /// 解除转场动画的图像索引
    func indexPathForDismiss() -> NSIndexPath
}
```

* 定义解除转场动画代理

```swift
/// 解除转场代理对象
weak var dismissDelegate: PhotoBrowserDismissDelegate?
```

* 修改设置参数函数

```swift
/// 设置代理参数
///
/// - parameter presentDelegate: 展现转场代理
/// - parameter dismissDelegate: 解除转场代理
/// - parameter indexPath:       照片索引
func setDelegateParams(presentDelegate: PhotoBrowserPresentDelegate,
    dismissDelegate: PhotoBrowserDismissDelegate,
    indexPath: NSIndexPath) {
        
        self.presentDelegate = presentDelegate
        self.dismissDelegate = dismissDelegate
        self.indexPath = indexPath
}
```

* 修改 `HomeTableViewController` 中的设置动画参数函数

```swift
// 3. 设置转场动画参数
self?.photoBrowserAnimator.setDelegateParams(cell, dismissDelegate: vc, indexPath: indexPath)
```

* 在 `PhotoBrowserViewController` 中实现协议方法

```swift
// MARK: - PhotoBrowserDismissDelegate
extension PhotoBrowserViewController: PhotoBrowserDismissDelegate {
    
    func imageViewForDismiss() -> UIImageView {
        let iv = UIImageView()
        
        iv.contentMode = .ScaleAspectFill
        iv.clipsToBounds = true
        
        let cell = collectionView.visibleCells()[0] as! PhotoBrowserCell
        
        iv.image = cell.imageView.image
        iv.frame = cell.scrollView.convertRect(cell.imageView.frame,
            toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
        
        print(iv)
        
        return iv
    }
    
    func indexPathForDismiss() -> NSIndexPath {
        return collectionView.indexPathsForVisibleItems()[0]
    }
}
```

* 实现解除转场动画方法

```swift
/// 解除转场动画
///
/// - parameter transitionContext: 转场上下文
private func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
    
    guard let presentDelegate = presentDelegate, dismissDelegate = dismissDelegate else {
        return
    }
    
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
    
    // 2. 转场动画中的大米视图
    let iv = dismissDelegate.imageViewForDismiss()
    let indexPath = dismissDelegate.indexPathForDismiss()
    transitionContext.containerView()?.addSubview(iv)
    
    UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
        
        fromView.alpha = 0
        iv.frame = presentDelegate.photoBrowserPresentFromRect(indexPath)
        
        }) { _ in
            
            iv.removeFromSuperview()
            fromView.removeFromSuperview()
            transitionContext.completeTransition(true)
    }
}
```
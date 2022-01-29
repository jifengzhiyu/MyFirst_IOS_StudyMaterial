# 照片查看 Cell

## 准备工作

* 新建 `PhotoBrowserCell`
* 定义内部控件

```swift
// MARK: - 照片查看 Cell
class PhotoBrowserCell: UICollectionViewCell {
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 1. 添加控件
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        // 2. 设置位置
        scrollView.frame = bounds
    }
    
    // MARK: - 懒加载控件
    /// 滚动视图
    private lazy var scrollView: UIScrollView = UIScrollView()
    /// 图像视图
    private lazy var imageView: UIImageView = UIImageView()
}
```

## 设置图像

* 错误的设置图像

```swift

var imageURL: NSURL? {
    didSet {
        imageView.sd_setImageWithURL(imageURL!)
    }
}
```

> 设置图像后，imageView 的 frame 没有计算

* 修改设置图像代码

```swift
/// 图像 URL
var imageURL: NSURL? {
    didSet {
        imageView.sd_setImageWithURL(imageURL, placeholderImage: nil) { image, _, _, _ in
            self.imageView.sizeToFit()
        }
    }
}
```

> 图像非常小，原因：在微博首页显示的图片是缩略图

* 新建函数处理 imageURL

```swift
/// 创建大图 URL
///
/// - parameter url: 缩略图 URL
///
/// - returns: 中图 URL
private func middleUrl(url: NSURL) -> NSURL {
    var urlString = url.absoluteString
    urlString = urlString.stringByReplacingOccurrencesOfString("/thumbnail/", withString: "/bmiddle/")
    
    return NSURL(string: urlString)!
}
```

* 修改 didSet 函数

```swift
/// 图像 URL
var imageURL: NSURL? {
    didSet {
        
        guard let url = imageURL else {
            return
        }
        
        // 用缩略图当作占位视图
        let key = url.absoluteString
        imageView.image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
        imageView.sizeToFit()
        imageView.center = scrollView.center
        
        imageView.sd_setImageWithURL(middleUrl(imageURL!),
            placeholderImage: nil) { image, _, _, _ in
                
                delay(1.0, callFunc: { () -> () in
                    self.imageView.center = CGPointZero
                    self.imageView.sizeToFit()
                })
        }
    }
}
```

### 计算长短图

* 以 cell 宽度为基准计算显示尺寸

```swift
/// 计算图像显示大小
///
/// - parameter image: 图像
///
/// - returns: 以 ScrollView 宽度为基准的图像大小
private func displaySize(image: UIImage) -> CGSize {
    
    let w = scrollView.bounds.width
    let h = image.size.height * w / image.size.width
    
    return CGSize(width: w, height: h)
}
```

* 在回调代码中重新设置 imageView 的 size

```swift
imageView.sd_setImageWithURL(middleUrl(imageURL!),
    placeholderImage: nil) { image, _, _, _ in
        
        if image == nil {
            SVProgressHUD.showInfoWithStatus("加载图像失败")
            return
        }
        
        delay(1.0, callFunc: { () -> () in
            self.imageView.center = CGPointZero
            self.imageView.frame = CGRect(origin: CGPointZero, size: self.displaySize(image))
        })
}
```

> 提示：此处一定加上图像加载判断，因为 SDWebImage 的超时时长是 15s，一旦超时，图像就会加载失败

* 计算图片位置

```swift
/// 设置图像位置
///
/// * 如果是长图，顶端对齐
/// * 如果是短图，居中显示
private func setImagePosition(image: UIImage) {
    
    // 1. 计算图像显示大小
    let size = displaySize(image)
    scrollView.contentSize = size
    
    // 2. 判断图像高度
    if size.height > scrollView.bounds.height {
        imageView.frame = CGRect(origin: CGPointZero, size: size)
    } else {
        let y = (scrollView.bounds.height - size.height) * 0.5
        imageView.frame = CGRect(x: 0, y: y, width: size.width, height: size.height)
    }
}
```

* 长图增加 contentSize 保证图像能够滚动

```swift
scrollView.contentSize = size
```

* 修改 `imageURL` 的 `didSet`

```swift
self.setImagePosition()
```

> 运行测试

## 缩放处理

* 设置滚动视图

```swift
/// 准备滚动视图
private func prepareScrollView() {
    scrollView.delegate = self
    scrollView.minimumZoomScale = 0.5
    scrollView.maximumZoomScale = 2.0
}
```

* 实现代理方法

```swift
// MARK: - UIScrollViewDelegate
extension PhotoBrowserCell: UIScrollViewDelegate {
    
    /// 返回要缩放的视图
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    /// 缩放完成后才回被调用
    ///
    /// - parameter scrollView: scrollView
    /// - parameter view:       被缩放的视图
    /// - parameter scale:      缩放完成的比例
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
    }
    
    // 只要缩放就会被调用
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
    }
}
```

> 运行测试发现短图放大后，无法滚动显示底部内容

* 调整 `setImagePosition` 函数，使用 `contentInset` 调整短图的图像视图位置

```swift
/// 设置图像位置
///
/// * 如果是长图，顶端对齐
/// * 如果是短图，居中显示
private func setImagePosition(image: UIImage) {
    
    // 1. 计算图像显示大小
    let size = displaySize(image)
    scrollView.contentSize = size
    
    // 2. 判断图像高度
    if size.height > scrollView.bounds.height {
        imageView.frame = CGRect(origin: CGPointZero, size: size)
    } else {
        imageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        let y = (scrollView.bounds.height - size.height) * 0.5
        scrollView.contentInset = UIEdgeInsets(top: y, left: 0, bottom: 0, right: 0)
    }
}
```

* 缩放停止后重新调整 Y 轴位置

```swift
/// 缩放完成后才回被调用
///
/// - parameter scrollView: scrollView
/// - parameter view:       被缩放的视图
/// - parameter scale:      缩放完成的比例
func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
    
    var offsetY = (scrollView.bounds.height - view!.frame.height) * 0.5

    offsetY = offsetY < 0 ? 0 : offsetY

    scrollView.contentInset = UIEdgeInsets(top: offsetY, left: 0, bottom: 0, right: 0)
}
```

> 注意：使用 transform 修改视图大小时，`bounds` 本身不会发生变化，而 `frame` 会发生变化

* 增加水平方向位置调整

```swift
/// 缩放完成后才回被调用
///
/// - parameter scrollView: scrollView
/// - parameter view:       被缩放的视图
/// - parameter scale:      缩放完成的比例
func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
    
    var offsetY = (scrollView.bounds.height - view!.frame.height) * 0.5
    var offsetX = (scrollView.bounds.width - view!.frame.width) * 0.5
    
    offsetY = offsetY < 0 ? 0 : offsetY
    offsetX = offsetX < 0 ? 0 : offsetX
    
    scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
}

```

* 图像缩放比例复位，以及滚动视图内容属性

```swift
/// 重置滚动视图
private func resetScrollView() {
    imageView.transform = CGAffineTransformIdentity
    
    scrollView.contentInset = UIEdgeInsetsZero
    scrollView.contentOffset = CGPointZero
    scrollView.contentSize = CGSizeZero
}
```

* 最终完成的 imageURL 属性

```swift
/// 图像 URL
var imageURL: NSURL? {
    didSet {
        
        guard let url = imageURL else {
            return
        }
        
        // 重置滚动视图
        resetScrollView()
        
        
        // 用缩略图当作占位视图
        let key = url.absoluteString
        imageView.image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
        imageView.sizeToFit()
        imageView.center = scrollView.center

        imageView.sd_setImageWithURL(middleUrl(imageURL!),
            placeholderImage: nil,
            options: [SDWebImageOptions.RetryFailed, SDWebImageOptions.RefreshCached],
            progress: { (current, total) -> Void in

                dispatch_async(dispatch_get_main_queue()) {
                    self.imageView.progress = CGFloat(current) / CGFloat(total)
                }
                
            }) { (image, _, _, _) in
                
                if image == nil {
                    SVProgressHUD.showInfoWithStatus("加载图像失败")
                    return
                }
                
                self.setImagePosition(image)
        }
    }
}
```





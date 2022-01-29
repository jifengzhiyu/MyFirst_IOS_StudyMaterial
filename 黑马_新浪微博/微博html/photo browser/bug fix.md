# 问题列表

## 照片缩放问题

* 问题描述：在多图cell中，第一张图片放大后，第三张图片无法放大
* 问题原因：imageView 的 transform 被修改后，没有复位

* 在 `resetScrollView` 函数中增加 `imageView` 的 `transform` 复位处理

```swift
/// 重设 scrollView 内容属性
private func resetScrollView() {
    // 重设 imageView 的形变参数
    imageView.transform = CGAffineTransformIdentity
    
    // 重设 scrollView
    scrollView.contentInset = UIEdgeInsetsZero
    scrollView.contentOffset = CGPointZero
    scrollView.contentSize = CGSizeZero
}
```

## 占位图像

* 问题描述：设置了缩略图像后，使用 `SDWebImage` 下载大图时，缩略图会消失
* 问题愿意：`SDWebImage` 在下载图像时会把之前的图像清空
* 在真机测试，直接指定 `imageView` 的 `placeholderImage` 同样不显示

### 解决办法

* 定义占位图像属性

```swift
/// 占位图像
private lazy var placeholder: UIImageView = UIImageView()
```

* 修改 `setupUI` 函数添加图像视图

```swift
private func setupUI() {
    // 1. 添加控件
    contentView.addSubview(scrollView)
    scrollView.addSubview(imageView)
    scrollView.addSubview(placeholder)
```

* 添加函数，显示占位视图图像

```swfit
/// 设置占位图像视图
private func setPlaceholder(image: UIImage?) {
    // 0> 显示视图
    placeholder.hidden = false
    // 1> 设置图像
    placeholder.image = image
    // 2> 设置大小
    placeholder.sizeToFit()
    // 3> 设置中心点
    placeholder.center = scrollView.center
}
```

> 注意：参数一定要是可选项，否则如果 SDWebImage 缓存失败，运行时会崩溃！

* 修改 `imageURL` 的 `didSet` 中的设置缩略图代码

```swift
// 1. url 缩略图的地址
let placeholderImage = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(url.absoluteString)
setPlaceholder(placeholderImage)
```

* 修改 `imageURL` 的 `didSet` 中的异步加载大图代码

```swift
// 2. 异步加载大图 - sd_webImage 有一个功能，一但设置了 url，准备异步加载
// 清除之前的图片/如果之前的图片也是异步下载，但是没有完成，取消之前的异步操作！
imageView.sd_setImageWithURL(bmiddleURL(url),
    placeholderImage: nil,
    options: [SDWebImageOptions.RefreshCached, SDWebImageOptions.RetryFailed],
    progress: { current, total in
        
    }) { image, error, _, _ in
    
        // 隐藏占位图像
        self.placeholder.hidden = true
        
        // 设置图像视图位置
        self.setPositon(image)
}
```

### 进度视图

* 新建 `ProgressImageView`

```swift
/// 带进度的图像视图
class ProgressImageView: UIImageView {

    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        
        UIColor.redColor().setFill()
        
        path.fill()
    }
}
```

* 替换占位图像的类

```swift
/// 占位进度图像
private lazy var placeholder: ProgressImageView = ProgressImageView()
```

* 暂时注释 SDWebImage 的加载函数，运行测试，发现绘图函数无法执行

#### 增加进度视图子类

```swift
/// 带进度的图像视图
class ProgressImageView: UIImageView {
    
    // MARK: - 构造函数
    init() {
        super.init(frame: CGRectZero)
        
        addSubview(progressView)
        progressView.backgroundColor = UIColor.redColor()
        
        progressView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.snp_edges)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 懒加载控件
    private lazy var progressView: ProgressView = ProgressView()
}

/// 进度视图
private class ProgressView: UIView {
    
    /// 加载进度 0 ~ 1
    var progress: CGFloat = 0 {
        didSet {
            
        }
    }
}
```

* 在 `ProgressImageView` 中同样增加 `progress` 属性，并且设置进度视图属性

```swift
/// 带进度的图像视图
class ProgressImageView: UIImageView {
    
    /// 加载进度 0 ~ 1
    var progress: CGFloat = 0 {
        didSet {
            progressView.progress = progress
        }
    }
```

* 在 `ProgressView` 的 progress 属性中调用 `setNeedDisplay`

```swift
/// 进度视图
private class ProgressView: UIView {
    
    /// 加载进度 0 ~ 1
    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        
        UIColor.blueColor().setFill()
        
        path.fill()
    }
}
```

* 绘制路径

```swift
/// 进度视图
private class ProgressView: UIView {
    
    /// 加载进度 0 ~ 1
    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private override func drawRect(rect: CGRect) {
        
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let r = min(rect.width, rect.height) * 0.5
        let start = CGFloat(-M_PI_2)
        let end = start + progress * 2 * CGFloat(M_PI)
        
        let path = UIBezierPath(arcCenter: center, radius: r, startAngle: start, endAngle: end, clockwise: true)
        path.addLineToPoint(center)
        path.closePath()
        
        UIColor(white: 1, alpha: 0.5).setFill()
        
        path.fill()
    }
}
```

#### 细节修改

* 修改进度视图的背景颜色

```swift
progressView.backgroundColor = UIColor.clearColor()
```

* 修改 `SDWebImage` 的进度调用

```swift
imageView.sd_setImageWithURL(bmiddleURL(url),
    placeholderImage: nil,
    options: [SDWebImageOptions.RefreshCached, SDWebImageOptions.RetryFailed],
    progress: { current, total in
        
        dispatch_async(dispatch_get_main_queue()) {
            self.placeholder.progress = CGFloat(current) / CGFloat(total)
        }
        
    }) { image, error, _, _ in
    
        if error != nil {
            SVProgressHUD.showInfoWithStatus("下载图像失败")
            return
        }
        
        // 隐藏占位图像
        self.placeholder.hidden = true
        
        // 设置图像视图位置
        self.setPositon(image)
}
```

## 设置选中照片

* 在 `PhotoBrowserViewController` 中设置选中照片

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    // 设置选中照片
    collectionView.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: .CenteredHorizontally, animated: false)
}
```

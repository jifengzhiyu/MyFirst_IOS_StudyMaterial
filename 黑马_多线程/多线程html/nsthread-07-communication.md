# 线程间通讯

## 主线程实现

### 定义属性

```objc
/// 根视图是滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;
/// 图像视图
@property (nonatomic, weak) UIImageView *imageView;
/// 网络下载的图像
@property (nonatomic, weak) UIImage *image;
```

### loadView

1. 加载视图层次结构
2. 用纯代码开发应用程序时使用
3. 功能和 `Storyboard` & `XIB` 是等价的

> 如果重写了 `loadView`，`Storyboard` & `XIB` 都无效

```objc
- (void)loadView {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor orangeColor];
    self.view = _scrollView;

    UIImageView *iv = [[UIImageView alloc] init];
    [self.view addSubview:iv];
    _imageView = iv;
}
```

### viewDidLoad

1. 视图加载完成后执行
2. 可以做一些数据初始化的工作
3. 如果用纯代码开发，不要在此方法中设置界面 UI

```objc
- (void)viewDidLoad {
    [super viewDidLoad];

    // 下载图像
    [self downloadImage];
}
```

### 下载网络图片

```objc
- (void)downloadImage {
    // 1. 网络图片资源路径
    NSURL *url = [NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/4afbfbedab64034f42b14da1aec379310a551d1c.jpg"];

    // 2. 从网络资源路径实例化二进制数据(网络访问)
    NSData *data = [NSData dataWithContentsOfURL:url];

    // 3. 将二进制数据转换成图像
    UIImage *image = [UIImage imageWithData:data];

    // 4. 设置图像
    self.image = image;
}
```

### 设置图片

```objc
- (void)setImage:(UIImage *)image {
    // 1. 设置图像视图的图像
    self.imageView.image = image;

    // 2. 按照图像大小设置图像视图的大小
    [self.imageView sizeToFit];

    // 3. 设置滚动视图的 contentSize
    self.scrollView.contentSize = image.size;
}
```

### 设置滚动视图的缩放

1> 设置滚动视图缩放属性

```objc
// 1> 最小缩放比例
self.scrollView.minimumZoomScale = 0.5;
// 2> 最大缩放比例
self.scrollView.maximumZoomScale = 2.0;
// 3> 设置代理
self.scrollView.delegate = self;
```

2> 实现代理方法 - 告诉滚动视图缩放哪一个视图

```objc
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}
```

3> 跟踪 `scrollView` 缩放效果

```objc
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"%@", NSStringFromCGAffineTransform(self.imageView.transform));
}
```

### 线程间通讯

* 在后台线程下载图像

```objc
[self performSelectorInBackground:@selector(downloadImage) withObject:nil];
```

* 在主线程设置图像

```objc
[self performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
```

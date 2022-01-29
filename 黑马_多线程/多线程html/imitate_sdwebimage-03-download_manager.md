# 下载管理器

* 单例实现

```objc
+ (instancetype)sharedManager {
    static id instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
```

> 之所以设计成单例，是为了实现全局的图像下载管理

* 移植属性和懒加载代码

```objc
/// 下载队列
@property (nonatomic, strong) NSOperationQueue *downloadQueue;
/// 下载操作缓存
@property (nonatomic, strong) NSMutableDictionary *operationCache;

// MARK: - 懒加载
- (NSMutableDictionary *)operationCache {
    if (_operationCache == nil) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}

- (NSOperationQueue *)downloadQueue {
    if (_downloadQueue == nil) {
        _downloadQueue = [[NSOperationQueue alloc] init];
    }
    return _downloadQueue;
}
```

* 定义方法

```objc
///  下载指定 URL 的图像
///
///  @param URLString 图像 URL 字符串
///  @param finished  下载完成回调
- (void)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *image))finished;
```

* 方法实现

```objc
- (void)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *))finished {

    // 检查操作缓冲池
    if (self.operationCache[URLString] != nil) {
        NSLog(@"正在玩命下载中，稍安勿躁");
        return;
    }

    // 创建下载操作
    DownloadImageOperation *op = [DownloadImageOperation downloadImageOperationWithURLString:URLString finished:^(UIImage *image) {
        // 从缓冲池删除操作
        [self.operationCache removeObjectForKey:URLString];

        // 执行回调
        finished(image);
    }];

    // 将操作添加到缓冲池
    [self.operationCache setObject:op forKey:URLString];
    // 将操作添加到队列
    [self.downloadQueue addOperation:op];
}
```

## 修改 `ViewController` 中的代码

* 删除相关属性和懒加载方法
* 用下载管理器接管之前的下载方法

```objc
// 创建下载操作
[[DownloadImageManager sharedManager] downloadImageOperationWithURLString:self.currentURLString finished:^(UIImage *image) {
    self.iconView.image = image;
}];
```

* 增加取消下载功能

```objc
///  取消指定 URL 的下载操作
- (void)cancelDownloadWithURLString:(NSString *)URLString {
    // 1. 从缓冲池中取出下载操作
    DownloadImageOperation *op = self.operationCache[URLString];

    if (op == nil) {
        return;
    }

    // 2. 如果有取消
    [op cancel];
    // 3. 从缓冲池中删除下载操作
    [self.operationCache removeObjectForKey:URLString];
}
```

> 运行测试！

## 缓存管理

* 定义图像缓存属性

```objc
/// 图像缓存
@property (nonatomic, strong) NSMutableDictionary *imageCache;
```

* 懒加载

```objc
- (NSMutableDictionary *)imageCache {
    if (_imageCache == nil) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}
```

* 检测图像缓存方法准备

```objc
///  检查图像缓存
///
///  @return 是否存在图像缓存
- (BOOL)chechImageCache {
    return NO;
}
```

* 方法调用

```objc
// 如果存在图像缓存，直接回调
if ([self chechImageCache]) {
    finished(self.imageCache[URLString]);
    return;
}
```

* 缓存方法实现

```objc
- (BOOL)chechImageCache:(NSString *)URLString {

    // 1. 如果存在内存缓存，直接返回
    if (self.imageCache[URLString]) {
        NSLog(@"内存缓存");
        return YES;
    }

    // 2. 如果存在磁盘缓存
    UIImage *image = [UIImage imageWithContentsOfFile:URLString.appendCachePath];
    if (image != nil) {
        // 2.1 加载图像并设置内存缓存
        NSLog(@"从沙盒缓存");
        [self.imageCache setObject:image forKey:URLString];
        // 2.2 返回
        return YES;
    }

    return NO;
}
```

> 运行测试

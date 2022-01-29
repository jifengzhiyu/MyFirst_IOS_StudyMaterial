# 完成回调

## 回调细节

1. 进度回调，通常在异步执行
    1. 通常进度回调的频率非常高！如果界面上有很多文件，同时下载，又要更新 UI，可能会造成界面的卡顿
    2. 让进度回调，在异步执行，可以有选择的处理进度的显示，例如：只显示一个指示器！
    3. 有些时候，如果文件很小，调用方通常不关心下载进度！(SDWebImage)
    4. 异步回调，可以降低对主线程的压力

2. 完成回调，通常在主线程执行
    1. 调用方不用考虑线程间通讯，直接更新UI即可
    2. 完成只有一次

## 增加类方法

```objc
///  实例化下载操作
///
///  @param url      下载文件的URL
///  @param progress 进度回调
///  @param finised  完成回调
///
///  @return 下载操作
+ (instancetype)downloadWithURL:(NSURL *)url progress:(void (^)(float progress))progress finised:(void (^)(NSString *filePath, NSError *error))finised;

///  开始下载
- (void)download;
```

## 利用属性记录block

- 如果本方法可以直接调用，就不需要使用属性记录
- 如果本方法不能直接调用，就需要使用属性记录，然后在需要的时候执行


### 定义 block 属性

```objc
///  下载文件 URL
@property (nonatomic, strong) NSURL *url;
///  进度回调
@property (nonatomic, copy) void (^progressBlock)(float);
///  完成回调
@property (nonatomic, copy) void (^finishedBlock)(NSString *, NSError *);
```

### 类方法实现

```objc
+ (instancetype)downloadWithURL:(NSURL *)url progress:(void (^)(float))progress finised:(void (^)(NSString *, NSError *))finised {

    HMDownloadOperation *d = [[HMDownloadOperation alloc] init];

    // 记录属性
    d.url = url;
    d.progressBlock = progress;
    d.finishedBlock = finised;

    return d;
}
```

### 在视图控制器中准备块代码

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSURL *url = [NSURL URLWithString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.0.2.dmg"];

    HMDownloadOperation *down = [HMDownloadOperation downloadWithURL:url progress:^(float progress) {
        NSLog(@"%f %@", progress, [NSThread currentThread]);
    } finised:^(NSString *filePath, NSError *error) {
        NSLog(@"%@ %@ %@", filePath, error, [NSThread currentThread]);
    }];

    [down download];
}
```

### 进度回调

```objc
if (self.progressBlock) {
    self.progressBlock(progress);
}
```

### 完成回调

```objc
dispatch_async(dispatch_get_main_queue(), ^{
    self.finishedBlock(self.filePath, nil);
});
```

### 失败回调

```objc
dispatch_async(dispatch_get_main_queue(), ^{
    self.finishedBlock(nil, error);
});
```




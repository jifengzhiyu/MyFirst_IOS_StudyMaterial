# 异步下载图像

## 全局操作队列

```objc
///  全局队列，统一管理所有下载操作
@property (nonatomic, strong) NSOperationQueue *downloadQueue;
```

* 懒加载

```objc
- (NSOperationQueue *)downloadQueue {
    if (_downloadQueue == nil) {
        _downloadQueue = [[NSOperationQueue alloc] init];
    }
    return _downloadQueue;
}
```

## 异步下载

```objc
// 异步加载图像
// 1. 定义下载操作
// 异步加载图像
NSBlockOperation *downloadOp = [NSBlockOperation blockOperationWithBlock:^{
    // 1. 模拟延时
    NSLog(@"正在下载 %@", app.name);
    [NSThread sleepForTimeInterval:0.5];
    // 2. 异步加载网络图片
    NSURL *url = [NSURL URLWithString:app.icon];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];

    // 3. 主线程更新 UI
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        cell.imageView.image = image;
    }];
}];

// 2. 将下载操作添加到队列
[self.downloadQueue addOperation:downloadOp];
```

> 运行测试

## 存在的问题

* 下载完成后不现实图片

原因分析：
* 使用的是系统提供的 cell
* 异步方法中只设置了图像，但是没有设置 frame
* 图像加载后，一旦与 cell 交互，会调用 cell 的 `layoutSubviews` 方法，重新调整 cell 的布局

## 解决办法

* 使用占位图像
* 自定义 Cell

> 注意演示不在主线程更新图像的效果


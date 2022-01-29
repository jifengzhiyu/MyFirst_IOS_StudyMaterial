# 自定义操作

## 准备工作

* 自定义 `DownloadImageOperation` 继承自 NSOperation
* 代码调用

```objc
// 实例化自定义操作
DownloadImageOperation *op = [[DownloadImageOperation alloc] init];
// 将自定义操作添加到下载队列
[self.downloadQueue addOperation:op];
```

## 需求驱动开发

### 目标一：设置自定义操作的执行入口

> 对于自定义操作，只要重写了 `main` 方法，当队列调度操作执行时，会自动运行 `main` 方法

**注意**：`main` 方法中需要使用自动释放池！

```objc
- (void)main {
    @autoreleasepool {
        NSLog(@"%@", [NSThread currentThread]);
    }
}
```

### 目标二：给自定义参数传递参数

* 定义属性

```objc
/// 要下载图像的 URL 字符串
@property (nonatomic, copy) NSString *URLString;
```

* 代码调用

```objc
// 实例化自定义操作
DownloadImageOperation *op = [[DownloadImageOperation alloc] init];
// 设置操作属性
op.URLString = @"https://www.baidu.com/img/bdlogo.png";

// 将自定义操作添加到下载队列，操作启动后会执行 main 方法
[self.downloadQueue addOperation:op];
```

> 注意，`main` 方法被调用时，属性已经准备就绪

### 目标三：如何回调？

#### 利用系统提供的 `CompletionBlock` 属性

```objc
// 设置完成回调
[op setCompletionBlock:^{
    NSLog(@"完成 %@", [NSThread currentThread]);
}];
```

* 只要设置了 `CompletionBlock`，当操作执行完毕后，就会被自动调用
* `CompletionBlock` 既不在主线程也不在操作执行所在线程
* `CompletionBlock` 无法传递参数

#### 自己定义回调 Block，在操作结束后执行

* 定义属性

```objc
/// 完成回调 Block
@property (nonatomic, copy) void (^finishedBlock)(UIImage *image);
```

* 设置自定义回调

```objc
// 设置自定义完成回调
[op setFinishedBlock:^(UIImage *image) {
    NSLog(@"finished %@ %@", [NSThread currentThread], image);
}];
```

* 耗时操作后执行回调

```objc
// 判断自定义回调是否存在
if (self.finishedBlock != nil) {
    // 通常为了简化调用方的代码，异步操作结束后的回调，大多在主线程
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.finishedBlock(@"hello");
    }];
}
```

### 目标四：简化操作创建

* 定义`类`方法

```objc
///  实例化下载图像操作
///
///  @param URLString 图像 URL 字符串
///  @param finished  完成回调 Block
///
///  @return 下载操作实例
+ (instancetype)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *image))finished;
```

* 实现方法

```objc
+ (instancetype)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *))finished {
    DownloadImageOperation *op = [[DownloadImageOperation alloc] init];

    op.URLString = URLString;
    op.finishedBlock = finished;

    return op;
}
```

* 方法调用

```objc
// 使用类方法实例化下载操作
DownloadImageOperation *op = [DownloadImageOperation downloadImageOperationWithURLString:@"http://www.baidu.com/img/bdlogo.png" finished:^(UIImage *image) {
    NSLog(@"%@", image);
}];

// 将自定义操作添加到下载队列，操作启动后会执行 main 方法
[self.downloadQueue addOperation:op];
```

### 目标五：取消操作

> 在关键节点添加 `isCancelled` 判断

* 添加多个下载操作

```objc
for (int i = 0; i < 10; ++i) {
    NSString *urlString = [NSString stringWithFormat:@"http://www.xxx.com/%04d.png", i];

    DownloadImageOperation *op = [DownloadImageOperation downloadImageOperationWithURLString:urlString finished:^(UIImage *image) {
        NSLog(@"===> %@", image);
    }];

    // 将自定义操作添加到下载队列，操作启动后会执行 main 方法
    [self.downloadQueue addOperation:op];
}
```

* 设置队列最大并发操作数

```objc
_downloadQueue.maxConcurrentOperationCount = 2;
```

* 内存警告时取消所有操作

```objc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    [self.downloadQueue cancelAllOperations];
}
```

> `cancelAllOperations` 会向队列中的所有操作发送 `Cancel` 消息

* 调整 `main` 方法，在关键节点判断

```objc
- (void)main {
    NSLog(@"%s", __FUNCTION__);

    @autoreleasepool {

        NSLog(@"下载图像 %@", self.URLString);
        // 模拟延时
        [NSThread sleepForTimeInterval:1.0];

        if (self.isCancelled) {
            NSLog(@"1.--- 返回");
            return;
        }

        // 判断自定义回调是否存在
        if (self.finishedBlock != nil) {
            // 通常为了简化调用方的代码，异步操作结束后的回调，大多在主线程
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.finishedBlock(self.URLString);
            }];
        }
    }
}

- (void)start {
    [super start];

    NSLog(@"%s", __FUNCTION__);
}
```

> 注意：如果操作状态已经是 `Cancel`，则不会执行 `main` 函数

* 队列调度操作时，首先执行 `start` 方法将线程放入`可调度线程池`
* 操作执行时的入口是 `main` 方法


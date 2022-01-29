# NSOperation

## 使用 NSOperation 改造 HMDownloader

### 修改父类

```objc
@interface HMDownloadOperation : NSOperation
```

### 重写 `main` 方法

* 自定义操作，重写了main方法，在当操作被添加到队列的时候，会自动被执行
* 不要忘记自动释放池

```objc
- (void)main {
    // 自定义操作千万不要忘记自动释放池
    @autoreleasepool {
        // 执行下载
        [self download];
    }
}
```

### 修改管理器代码

#### 操作队列

```objc
@property (nonatomic, strong) NSOperationQueue *downloaderQueue;

- (NSOperationQueue *)downloaderQueue {
    if (_downloaderQueue == nil) {
        _downloaderQueue = [[NSOperationQueue alloc] init];
    }
    return _downloaderQueue;
}
```

#### 修改开始下载代码

```objc
// 4. 开始下载
[self.downloaderQueue addOperation:downloader];
```

### 取消下载操作

```objc
- (void)pauserWithURL:(NSURL *)url {
    // 1. 在缓冲池中查找下载操作
    HMDownloadOperation *downloader = self.downloaderCache[url];

    // 2. 判断是否存在下载操作
    if (downloader == nil) {
        NSLog(@"%@", self.downloaderQueue.operations);
        return;
    }

    // 3. 暂停操作，操作队列会认为操作已经完成，会自动将操作从操作队列中删除
    [downloader pause];

    // 4. 将下载操作从缓冲池中删除
    [self.downloaderCache removeObjectForKey:url];
}
```

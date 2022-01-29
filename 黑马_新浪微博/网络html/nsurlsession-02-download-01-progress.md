# 下载进度跟进

> 要跟进下载进度，不能使用全局 session

* 代理模式是`一对一`的

## 定义全局 `session`

```objc
// MARK: - 懒加载
- (NSURLSession *)session {
    if (_session == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];

        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}
```

## 实现代理方法

```objc
///  下载完成，必须实现
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"%@ %@", location, [NSThread currentThread]);
}

/// 进度方法，iOS 7.0 必须实现
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {

    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"%@ %f", [NSThread currentThread], progress);
}

/// 续传方法，iOS 7.0 必须实现
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"%s", __FUNCTION__);
}
```

## 调整下载代码

```objc
- (void)download {

    NSLog(@"开始");

    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://localhost/321.zip"];

    // 2. 下载
    [[self.session downloadTaskWithURL:url] resume];
}
```

### 代理的工作对列

* `nil` - 异步回调 和 实例化一个 操作队列的效果是一样的！
* `[[NSOperationQueue alloc] init]` － 异步回调
    - 注意：下载本身的线程"只有一条"
    - 代理回调可以在"多个线程"回调！
* `[NSOperationQueue mainQueue]` - 主队列回调
    - 下载本身是异步执行的，这一点和 `NSURLConnection` 是一样的
    - 指定代理执行的队列，不会影响到下载本身的执行
    - `NSURLSession` 即使在主线程回调也不会造成阻塞

* 如何选择队列
    - 网络访问结束后，如果不需要做复杂的操作，可以指定主队列，这样不用考虑线程间通讯

### 下载错误监听

```objc
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"%@ %@", task, error);
}
```

> `NSURLSessionDownloadDelegate` 继承自 `NSURLSessionTaskDelegate` 因此可以直接实现 `NSURLSessionTaskDelegate` 的代理方法

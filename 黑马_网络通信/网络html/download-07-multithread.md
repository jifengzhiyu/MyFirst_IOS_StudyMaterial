# 多线程

* 异步下载

```objc
- (void)downloadWithURL:(NSURL *)url {

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1. 检查服务器文件信息
        [self remoteInfoWithURL:url];

        // 2. 检查本地文件大小
        long long fileSize = [self localFileSize];

        if (fileSize == self.expectedContentLength) {
            NSLog(@"下载完成");
            return;
        }

        // 3. 从偏移位置下载文件
        [self downloadWithURL:url offset:fileSize];
    });
}
```

* 启动运行循环

```objc
NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
[conn start];

// NSURLConnection 会在网络请求结束后，自动停止运行循环
[[NSRunLoop currentRunLoop] run];

NSLog(@"come here %@", [NSThread currentThread]);
```

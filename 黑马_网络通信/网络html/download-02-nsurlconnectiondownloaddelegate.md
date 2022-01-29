# NSURLConnectionDownloadDelegate

## 注意

* `NSURLConnectionDownloadDelegate` 代理方法是为 Newsstand Kit’s(杂志包) 创建的下载服务的
* Newsstand 主要在国外使用比较广泛，国内极少
* 如果使用 `NSURLConnectionDownloadDelegate` 代理方法监听下载进度，能够监听到进度，但是：**找不到下载的文件**

示例代码如下：

```objc
- (void)downloadWithURL:(NSURL *)url {

    // 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:kTimeout];

    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDownloadDelegate
- (void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long) expectedTotalBytes {

    NSLog(@"%f", (float)totalBytesWritten / expectedTotalBytes);
}

- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *) destinationURL {

    NSLog(@"%@", destinationURL);
}
```

# 跟踪下载进度

```objc
#pragma mark - NSURLConnectionDataDelegate
// 1. 接收到服务器响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"%@", response);
    self.expectedContentLength = response.expectedContentLength;
    self.fileSize = 0;
}

// 2. 接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    self.fileSize += data.length;
    float progress = (float)self.fileSize / self.expectedContentLength;
    NSLog(@"%f", progress);
}

// 3. 接收完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"下载完成");
}

// 4. 网络错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}
```

## 拼接数据

```objc
- (NSMutableData *)fileData {
    if (_fileData == nil) {
        _fileData = [NSMutableData data];
    }
    return _fileData;
}

// 2. 接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    self.fileSize += data.length;
    float progress = (float)self.fileSize / self.expectedContentLength;
    NSLog(@"%f", progress);

    // 拼接数据
    [self.fileData appendData:data];
}

// 3. 接收完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"下载完成");

    [self.fileData writeToFile:@"/Users/liufan/Desktop/321" atomically:YES];
    self.fileData = nil;
}
```

## 存在的问题

* 内存峰值依旧

> 意外发现：运行结果和 NSURLConnection 的异步方法的效果几乎一样！


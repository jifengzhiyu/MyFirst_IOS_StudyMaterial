# NSOutputStream 拼接文件

## 定义属性

```objc
// 1. 接收到服务器响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"%@", response);
    self.expectedContentLength = response.expectedContentLength;
    self.fileSize = 0;

    self.targetPath = [NSTemporaryDirectory() stringByAppendingPathComponent:response.suggestedFilename];
    NSLog(@"%@", self.targetPath);

    // 删除文件
    [[NSFileManager defaultManager] removeItemAtPath:self.targetPath error:NULL];

    // 打开文件流
    self.fileStream = [[NSOutputStream alloc] initToFileAtPath:self.targetPath append:YES];
    [self.fileStream open];
}

// 2. 接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    self.fileSize += data.length;
    float progress = (float)self.fileSize / self.expectedContentLength;
    NSLog(@"%f", progress);

    // 拼接数据
    [self.fileStream write:data.bytes maxLength:data.length];
}

// 3. 接收完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"下载完成");

    // 关闭流
    [self.fileStream close];
}

// 4. 网络错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);

    [self.fileStream close];
}
```

## 文件流操作方法

```objc
打开流 - 要对文件读写之前，首先需要打开流
- (void)open;

关闭流 - 对文件读写操作完成之后，需要关闭流
- (void)close;

将数据写入到流
- (NSInteger)write:(const uint8_t *)buffer maxLength:(NSUInteger)len;
```

# 断点续传

## 确认思路

1. 检查服务器文件信息
2. 检查本地文件
    * 如果比服务器文件小，续传
    * 如果比服务器文件大，重新下载
    * 如果和服务器文件一样，下载完成
3. 断点续传

## 代码实现

### 检查服务器文件信息

```objc
///  检查服务器文件信息
- (void)remoteInfoWithURL:(NSURL *)url {

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"HEAD";

    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];

    self.expectedContentLength = response.expectedContentLength;
    self.targetPath = [NSTemporaryDirectory() stringByAppendingPathComponent:response.suggestedFilename];
}
```

### 检查本地文件

```objc
///  检查本地文件大小
- (long long)localFileSize {

    NSFileManager *manager = [NSFileManager defaultManager];

    long long fileSize = 0;
    // 1. 文件是否存在
    if ([manager fileExistsAtPath:self.targetPath]) {
        fileSize = [[manager attributesOfItemAtPath:self.targetPath error:NULL] fileSize];
    }

    // 2. 判断是否大于服务器大小
    if (fileSize > self.expectedContentLength) {
        [manager removeItemAtPath:self.targetPath error:NULL];
        fileSize = 0;
    }

    return fileSize;
}
```

### 断点续传

```objc
///  从偏移位置下载文件
- (void)downloadWithURL:(NSURL *)url offset:(long long)offset {

    self.fileSize = offset;

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:kTimeout];

    NSString *rangeStr = [NSString stringWithFormat:@"bytes=%lld-", offset];
    [request setValue:rangeStr forHTTPHeaderField:@"Range"];

    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
}
```

### 修改代理方法

```objc
// 1. 接收到服务器响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // 打开文件流
    self.fileStream = [[NSOutputStream alloc] initToFileAtPath:self.targetPath append:YES];
    [self.fileStream open];
}
```

### 下载主方法

```objc
- (void)downloadWithURL:(NSURL *)url {

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
}
```

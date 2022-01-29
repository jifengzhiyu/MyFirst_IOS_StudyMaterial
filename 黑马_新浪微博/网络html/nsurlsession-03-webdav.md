# WebDav演练

## WebDav 配置

* WebDav 服务器是基于 Apache 的，可以当作文件服务器使用

## 代码实现

### session 懒加载

```objc
// MARK: 懒加载
- (NSURLSession *)session {
    if (_session == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];

        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}
```

### 授权字符串

```objc
/**
 授权字符串格式

 BASIC (用户名:密码).base64
 */
- (NSString *)authString {
    NSString *str = @"admin:123456";

    return [@"BASIC " stringByAppendingString:[self base64Encode:str]];
}

///  BASE 64 编码
- (NSString *)base64Encode:(NSString *)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];

    return [data base64EncodedStringWithOptions:0];
}
```

### WebDav 上传

```objc
// MARK: 上传
- (void)webdavUpload {
    // 1. url - 保存到服务器上的路径
    NSURL *url = [NSURL URLWithString:@"http://localhost/uploads/123.png"];

    // 2. request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"PUT";
    [request setValue:[self authString] forHTTPHeaderField:@"Authorization"];

    // 3. uploadtask
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"001.png" withExtension:nil];

    [[self.session uploadTaskWithRequest:request fromFile:fileURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@ %@", result, response);
    }] resume];
}
```

### WebDav 删除

```objc
// MARK: 删除
- (void)webdavDelete {
    // 1. url - 保存到服务器上的路径
    NSURL *url = [NSURL URLWithString:@"http://localhost/uploads/123.png"];

    // 2. request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"DELETE";
    [request setValue:[self authString] forHTTPHeaderField:@"Authorization"];

    // 3. 数据任务
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@ - %@", result, response);
    }] resume];
}
```

### WebDav GET & HEAD

> `GET` & `HEAD` 不会修改服务器，因此不需要授权

```
///  MARK:
- (void)webdavGet {
    // 1. url - 保存到服务器上的路径
    NSURL *url = [NSURL URLWithString:@"http://localhost/uploads/123.png"];

    // 2. 下载任务
    [[self.session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = [NSData dataWithContentsOfURL:location];

        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconImage.image = [UIImage imageWithData:data];
        });
    }] resume];
}
```

## 上传进度

```objc
/// MARK: - NSURLSessionTaskDelegate
/// 上传进度
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {

    float progress = (float)totalBytesSent / totalBytesExpectedToSend;
    NSLog(@"%f %@", progress, [NSThread currentThread]);
}
```

# HTTPS

## NSURLSession 的 HTTPS 访问

```objc
/**
 接收到身份质询 Challenge

 身份质询保存在受保护空间内！

 * 完成回调参数
 - NSURLSessionAuthChallengeDisposition

    NSURLSessionAuthChallengeUseCredential = 0,                 使用指定的凭据
    NSURLSessionAuthChallengePerformDefaultHandling = 1,        对身份质询的默认处理
    NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2, 取消请求，忽略凭据参数
    NSURLSessionAuthChallengeRejectProtectionSpace = 3,         本次忽略质询
 - NSURLCredential 证书
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {

    NSLog(@"%@", challenge.protectionSpace);
    // 判断身份质询方式是否是信任证书
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {

        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];

        // 回调信任受保护空间中的身份质询
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}
```

## NSURLConnection 的 HTTPS 访问

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSURL *url = [NSURL URLWithString:@"https://mail.itcast.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {

    NSLog(@"%@", challenge);
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        NSLog(@"%@", challenge.sender);
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];

        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.data setData:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"%@", [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding]);
}

- (NSMutableData *)data {
    if (_data == nil) {
        _data = [NSMutableData data];
    }
    return _data;
}
```

## AFN 的 HTTPS 访问

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:@"https://mail.itcast.cn" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
```

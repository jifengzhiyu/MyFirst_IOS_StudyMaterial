# 代码演练

## 常规代码演练

```objc
- (void)postLogin {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    NSDictionary *params = @{@"username": @"张三&李四", @"password": @"123"};

    [mgr POST:@"http://localhost/login.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"POST Login %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)getLogin2 {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    NSDictionary *params = @{@"username": @"张三&李四", @"password": @"123"};

    [mgr GET:@"http://localhost/login.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"GET Login %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)getLogin1 {

    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    [mgr GET:@"http://localhost/login.php?username=zhangsan&password=123" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)getDemo {

    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    [mgr GET:@"http://localhost/demo.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@ %@ %@", responseObject, [responseObject class], [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
```

### 演练小结

* 程序员不需要知道 `URL`，直接使用 `URL` 字符串
* 自动实现 `JSON` 的反序列化
* 网络访问完成的回调，是在主线程，程序员不需要考虑线程间通讯
* `URL` 的参数可以使用 ｀字典` 的形式拼接，程序员不在需要考虑 `url` 的格式
* 程序员不需要考虑百分号转义
    - OC中的百分号转义是有缺陷的，特殊字符(空格 &)或者中文需要添加百分号转义
* 程序员不需要知道 `HTTP` 方法，只需要挑选单词即可！

## XML 解析

### SAX 解析

```objc
tools.responseSerializer = [AFHTTPResponseSerializer serializer];
```

### DOM 解析

```objc
tools.responseSerializer = [AFXMLParserResponseSerializer serializer];
```

# 多值参数

```objc
NetworkTools *tools = [NetworkTools sharedNetworkTools];

NSDictionary *params = @{@"city": @[@"bj", @"sh", @"gz"]};

[tools GET:@"weather.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    NSLog(@"%@", responseObject);
} failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSLog(@"%@", error);
}];
```

# PUT 上传 & 进度跟进

```objc
- (void)putupload {
    NetworkTools *tools = [NetworkTools sharedNetworkTools];

    NSString *urlString = @"http://localhost/uploads/321.png";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"PUT";

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"001.png" withExtension:nil];
    NSProgress *progress = nil;
    [[tools uploadTaskWithRequest:request fromFile:fileURL progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"%@ %@", response, responseObject);
    }] resume];

    // KVO
    [progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = object;
        NSLog(@"%@ - %@ - %f", progress.localizedDescription, progress.localizedAdditionalDescription, progress.fractionCompleted);
    }
}
```

# 网络连接状态监听

```objc
[tools.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    NSLog(@"%zd", status);
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable:
            NSLog(@"没有连接");
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            NSLog(@"WI-FI");
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            NSLog(@"3G");
            break;
        default:
            NSLog(@"未知");
            break;
    }
}];
[tools.reachabilityManager startMonitoring];
```


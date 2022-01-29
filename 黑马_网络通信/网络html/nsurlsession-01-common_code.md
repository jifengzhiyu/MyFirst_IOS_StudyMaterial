# 常见代码

## 代码初体验

```objc
- (void)sessionDemo1 {
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://localhost/demo.json"];

    // 2. session
    NSURLSession *session = [NSURLSession sharedSession];

    // 3. 数据任务
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"%@ %@ %@", result, response, [NSThread currentThread]);
    }];

    // 4. 继续任务
    [task resume];
}
```

### 小结

* 为了方便程序员使用，苹果提供了一个全局 `session`
    * `[NSURLSession sharedSession]`
* 所有的 `任务(Task)` 都是由 `Session` 发起的
* 所有的任务默认是`挂起`的，需要 `Resume`
* `session` 的回调是异步的

## 简化代码

```objc
- (void)sessionDemo2 {
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://localhost/demo.json"];

    // 2. 数据任务
    [self taskWithURL:url];
}

- (void)taskWithURL:(NSURL *)url {
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"%@ %@ %@", result, response, [NSThread currentThread]);
    }] resume];
}
```

* `数据任务`适合于小的数据访问，包括：
    * `JSON`
    * `XML`
    * `PList`
    * `HTML`
    * `图像`

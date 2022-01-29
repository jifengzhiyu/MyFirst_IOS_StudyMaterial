# GET 缓存

## Request 缓存请求头

* `If-None-Match` - 与响应头的 Etag 相对应，可以判断本地缓存数据是否发生变化

### GET 方法缓存演练

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSURL *url = [NSURL URLWithString:@"http://localhost/itcast/images/head1.png"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:10.0];

    if (self.etag.length > 0) {
        NSLog(@"%@", self.etag);

        [request setValue:self.etag forHTTPHeaderField:@"If-None-Match"];
    }

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"%@", httpResponse);

        // 判断服务器返回的状态码，是否是 304
        if (httpResponse.statusCode == 304) {
            NSLog(@"加载缓存数据");

            NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
            data = cachedResponse.data;
        }

        self.etag = httpResponse.allHeaderFields[@"Etag"];
        self.iconView.image = [UIImage imageWithData:data];
    }];
}
```

### 代码小结

* 请求的缓存策略使用 `NSURLRequestReloadIgnoringCacheData`，忽略本地缓存
* 服务器响应结束后，要记录 `Etag`，服务器内容和本地缓存对比是否变化的重要依据
* 在发送请求时，设置 `If-None-Match`，并且传入 `Etag`
* 连接结束后，要判断响应头的状态码，如果是 `304`，说明本地缓存内容没有发生变化

## 设置缓存

```objc
NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
[NSURLCache setSharedURLCache:urlCache];
```

* iOS 5.0开始，支持磁盘缓存，但仅支持 HTTP
* iOS 6.0开始，支持 HTTPS 缓存

> AFNetworking 的作者 Mattt说：无数开发者尝试自己做一个简陋而脆弱的系统来实现网络缓存的功能，殊不知 `NSURLCache` 只要两行代码就能搞定且好上 100 倍。

# 官方演示程序

## AppDelegate

### 设置缓存

```objc
NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
[NSURLCache setSharedURLCache:URLCache];
```

### 设置网络访问标示

```objc
[[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
```

## `AFAppDotNetAPIClient`

* 提供全局网络访问入口

* .h

```objc
@interface AFAppDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

```

* .m

```objc
static NSString * const AFAppDotNetAPIBaseURLString = @"https://api.app.net/";

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });

    return _sharedClient;
}

@end
```

## 小结

1. 在 `AppDelegate` 中设置缓存
2. 在 `AppDelegate` 中设置网络访问指示器
3. 继承 `AFHTTPSessionManager` 创建单例统一管理网络访问
4. 单例方法中使用了 `BaseURL`，设置后，再访问该服务器，可以直接使用相对路径

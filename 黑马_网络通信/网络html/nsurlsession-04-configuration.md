# Configuration

`NSURLSessionConfiguration` 用于设置全局的网络会话属性，包括：身份验证，超时时长，缓存策略，Cookie 等

## 构造方法

* `NSURLSessionConfiguration` 有三个类构造方法，是为不同的用例设计的

    * `defaultSessionConfiguration` 返回标准配置，具有共享 `NSHTTPCookieStorage`，`NSURLCache` 和 `NSURLCredentialStorage`

    * `ephemeralSessionConfiguration` 返回一个预设配置，没有持久性存储的缓存，Cookie或证书。这对于实现像`秘密浏览`功能的功能来说，是很理想的

    * `backgroundSessionConfiguration`，独特之处在于，会创建一个后台会话。后台会话不同于常规的，普通的会话，它甚至可以在应用程序挂起，退出，崩溃的情况下运行上传和下载任务。初始化时指定的标识符，被用于向任何可能在进程外恢复后台传输的守护进程提供上下文

## 常用 `HTTPAdditionalHeaders`

```objc
configuration.HTTPAdditionalHeaders = @{@"Accept": @"application/json",
                                        @"Accept-Language": @"en",
                                        @"Authorization": authString,
                                        @"User-Agent": userAgentString};
```

> 除了以上字段外，`range` 用于断点续传

## 常用属性

| 属性 | 描述 |
| -- | -- |
| HTTPAdditionalHeaders | HTTP 头字段 |
| timeoutIntervalForRequest | 超时时长 |
| timeoutIntervalForResource | 整个资源请求时长 |
| requestCachePolicy | 缓存策略 |
| allowsCellularAccess | 允许蜂窝访问 |
| HTTPMaximumConnectionsPerHost | 对于一个host的最大并发连接数，默认数值是 4，MAC 下的默认数值是 6 |


# NSURLSession注意事项

> 一旦指定了 session 的代理，session会对代理进行强引用，如果不主动取消 session，会造成内存泄漏！

## 解决方案

* 解决方法1：在任务完成后取消 session
    * 缺点：session一旦被取消就无法再次使用
* 解决方法2：在视图将要消失的时候取消 session
    * 优点：只需要一个全局的session统一管理
* 解决方法3：建立一个网络会话管理类，单独处理所有的网络请求，

# NSURLConnection

## 步骤

1. `NSURL`：确定要访问的资源
2. `NSURLRequest`：根据 `URL` 建立请求，向服务器索要数据
3. `NSURLConnection`：建立网络连接，将请求(异步)发送给服务器

### 示例代码

```objc
// 1. `NSURL`：确定要访问的资源
NSURL *url = [NSURL URLWithString:@"http://m.baidu.com"];

// 2. `NSURLRequest`：根据 `URL` 建立请求，向服务器索要数据
NSURLRequest *request = [NSURLRequest requestWithURL:url];

// 3. `NSURLConnection`：建立网络连接，将请求(异步)发送给服务器
[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

    NSLog(@"%@", data);
}];
```

### `NSURLConnection` 代码小结

#### `sendAsynchronousRequest` 发送异步请求

* 此方法就是异步执行的，程序员无序考虑开启线程，或者创建队列
* 会将之前建立好的请求`异步`发送给服务器
* 等到接收到服务器响应后，由 `queue` 负责调度 `completionHandler` 的执行

#### 队列

* 调度 `completionHandler` 执行的队列
    * `[[NSOperationQueue alloc] init]`，后台线程异步执行
    * `[NSOperationQueue mainQueue]`，主线程异步执行
* 队列的选择
    * 如果要对数据进行耗时处理，例如：解压缩等，选择新建队列调度
    * 如果只是做简单处理，立即更新 UI，选择主队列

#### completionHandler

* 网络访问已经结束，接收到服务器响应数据后的回调方法
* `response`，服务器的响应，通常在开发`下载`功能时才会使用

| 响应属性 | 说明 |
| -- | -- |
| `URL` | 服务器反馈的 URL，有的时候，服务器会重定向新的 URL |
| `MIMEType` | <ul><li>服务器告诉客户端，返回的二进制数据的类型</li><li>`ContentType`</li><li>根据 MIMEType 客户端就知道使用什么软件处理返回的二进制数据</li><li>网络之所以这么丰富多彩，是因为有非常多的客户端软件</li></ul> |
| `statusCode` | 状态码<br /><ul><li>1XX消息</li><li>2XX 成功</li><li>3XX 更多选择</li><li>4XX 客户端错误</li><li>5XX 服务器错误</li></ul> |
| `expectedContentLength` | 数据长度，下载文件总长度 |
| `suggestedFilename` | 建议的文件名 |

* `data` 服务器返回的二进制数据，程序员最关心的内容
* `connectionError` 连接错误，任何网络访问都有可能出现错误

```objc
// 标准的错误处理方法
if (connectionError || data == nil) {
    NSLog(@"网络不给力！");
    return;
}
```

### 请求

1. 基于 `URL` 建立请求
2. 设置请求属性：`缓存策略`，`网络超时时长`
3. 告诉服务器额外信息：`客户端类型`，`身份验证`...

```objc
// 告诉服务器，客户端的类型是 iPhone，而且支持 AppleWebKit
[request setValue:@"iPhone AppleWebKit" forHTTPHeaderField:@"User-Agent"];
```

#### 缓存策略

| 枚举 | 数值 | 说明 |
| -- | -- | -- |
| `NSURLRequestUseProtocolCachePolicy` | 0 | 默认的缓存策略 |
| `NSURLRequestReloadIgnoringLocalCacheData` | 1 | <ul><li>忽略本地缓存数据，始终加载服务器的数据</li><li>对数据的及时性要求高的应用</li><li>例如：彩票、股票等</li></ul> |
| `NSURLRequestReturnCacheDataElseLoad` | 2 | 如果有缓存，就返回缓存，否则加载数据 |
| `NSURLRequestReturnCacheDataDontLoad` | 3 | 如果有缓存，就返回缓存，否则不加载 |

#### 超时时长

* 默认网络时长是 `60 s`
* 建议超时时长 `15~30` 秒之间
* 注意超时时长不能太短
* `SDWebImage` 的默认超时时长是 `15` 秒
* `AFN` 的默认超时时长是 `60` 秒

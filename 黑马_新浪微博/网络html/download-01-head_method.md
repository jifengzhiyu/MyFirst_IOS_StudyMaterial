# HTTP HEAD方法

# HEAD方法

`HEAD` 方法通常是用来在下载文件之前，获取远程服务器上的文件信息

- 与 GET 方法相比，同样能够拿到响应头，但是不返回数据实体
- 用户可以根据响应头信息，确定下一步操作

```objc
NSURL *url = [NSURL URLWithString:@"http://localhost/demo.json"];
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:10.0];
request.HTTPMethod = @"HEAD";

NSURLResponse *response = nil;
[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
NSLog(@"要下载文件的长度 %tu", response.expectedContentLength);
```

## 同步方法

* 同步方法是阻塞式的，通常只有 `HEAD` 方法才会使用同步方法
* 如果在开发中，看到参数的类型是 `**`，就传入对象的地址



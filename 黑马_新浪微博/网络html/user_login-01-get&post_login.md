# GET & POST 登录

## GET 登录

```objc
- (void)getLogin {
    NSString *urlString = [NSString stringWithFormat:@"http://localhost/login.php?username=%@&password=%@", self.username, self.pwd];
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataDontLoad timeoutInterval:10.0];
    // 默认就是 GET 方法，无需专门指定
    NSLog(@"%@", request.HTTPMethod);

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"%@ - %@", response, result);
    }];
}
```

### URL 的基本格式

* 登录的脚本：`login.php`，提示：在不同的公司使用的后台接口是不一样的 `jsp`，`aspx`...
* 如果要带参数，使用 `?` 衔接
* 参数格式：`参数名=值`
* 如果有多个参数，使用 `&` 连接

### GET 缓存

* GET 缓存的数据会保存在 Cache 目录中 \bundleId 下 `Cache.db` 中
    - `cfurl_cache_receiver_data`，缓存所有的请求数据
    - `cfurl_cache_response`，缓存所有的响应

> 以上操作仅供演示，相关内容内容会在后续 `SQLite` 讲解

## POST 登录

```objc
- (void)postLogin {
    NSURL *url = [NSURL URLWithString:@"http://localhost/login.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = @"pOsT";
    NSString *bodyStr = [NSString stringWithFormat:@"username=%@&password=%@", self.username, self.pwd];
    request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"%@ - %@", response, result);
    }];
}
```

### GET & POST 对比

#### URL

* GET － 真正的变化都在 URL 中
    * URL 格式
        * login.php 负责登录的脚本（提示，服务器脚本可以有很多种，php是上课使用的一种）
        * 如果接参数，使用 `?`
        * 参数格式，值对：`参数名=值`
        * 多个参数，使用 `&` 连接
        * **如果 `URL` 字符串中有中文/空格等特殊字符，需要添加百分号转义**
```objc
[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
```

* POST
    * `URL` 中不包含任何参数，直接指定脚本路径即可

#### Request

* GET - 是网络访问使用频率最高的方法，从服务器获取数据， `URLRequest` 的默认方法就是 `GET`
    * 不需要做任何改动

* POST
    * 需要指定 HTTP 的访问方法：`POST`
    * 所有的数据参数都在数据体中指定，数据内容可以从 `Firebug` 中粘贴
    * 数据格式和 `GET` 方法的参数定义非常类似，没有 `?`

#### Connection

* 将`请求`发送给服务器
* 返回服务器的二进制数据实体
* 是网络访问中，最单纯的方法
* 无论 `GET` 还是 `POST` 方法，`Connection` 没有变化

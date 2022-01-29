# POST JSON

## POST JSON 主方法

```objc
///  上传 JSON 给服务器
///
///  @param data JSON格式的二进制
- (void)postJSON:(NSData *)data {
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://localhost/post/postjson.php"];

    // 2. request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = data;

    // 3. connection
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
}
```

## 代码演练

### 上传特殊格式的字符串

```objc
///  重要提示：JSON只是格式特殊的字符串
- (void)postDemo1 {
    NSString *jsonString = @"{\"username\": \"xiaofang\", \"age\": 18}";
    [self postJSON:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
}
```

### 上传字典或者数组

```objc
///  POST 字典&数组
- (void)postDict {
    NSDictionary *dict1 = @{@"username": @"lao lao", @"age": @18};
    NSDictionary *dict2 = @{@"username": @"xiao xiao", @"age": @108};
    NSArray *array = @[dict1, dict2];

    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:NULL];
    [self postJSON:data];
}
```

## NSJSONSerialization 类

* A class for converting JSON to Foundation objects and converting Foundation objects to JSON.
* NSJSONSerialization 类是一个负责 转换 JSON 和 Foundation 对象的类

* An object that may be converted to JSON must have the following properties:
* 一个对象能够被转换成 JSON 必须符合以下条件：

    * Top level object is an NSArray or NSDictionary
    * 顶级节点，必须是一个 NSArray or NSDictionary

    * All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
    * 所有的对象必须是 NSString, NSNumber, NSArray, NSDictionary, or NSNull

    * All dictionary keys are NSStrings
    * 所有字典的 key 都必须是 NSString

    * NSNumbers are not NaN or infinity
    * NSNumber 不能为空或者无穷大

## 序列化 & 反序列化

* 反序列化：从服务器接收到 `二进制数据` 转换成 `字典或者数组`
* 序列化：将 `字典或者数组` 转换成 `二进制数据`，准备发送给服务器

### 序列化之前的校验

```objc
- (void)postDemo2 {
    id obj = @"hello";

    // 序列化之前，一定使用 isValidJSONObject 检测一下要序列化的对象
    // 判断是否能够正确被序列化，避免程序执行时出现闪退
    if (![NSJSONSerialization isValidJSONObject:obj]) {
        NSLog(@"数据格式不正确");
        return;
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:NULL];
    [self postJSON:data];
}
```

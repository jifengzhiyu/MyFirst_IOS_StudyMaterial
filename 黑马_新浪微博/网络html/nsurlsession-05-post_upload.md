# POST 上传

## formData 和 upload 方法

> 以下代码从 `POST 增强` 复制

```objc
#define boundary @"itcast-upload"

- (void)uploadFile:(NSString *)fieldName dataDict:(NSDictionary *)dataDict params:(NSDictionary *)params {
    // 1. url - 负责上传文件的脚本
    NSURL *url = [NSURL URLWithString:@"http://localhost/post/upload-m.php"];

    // 2. request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";

    NSString *typeValue = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:typeValue forHTTPHeaderField:@"Content-Type"];

    NSData *data = [self formData:fieldName dataDict:dataDict params:params];

    // 3. 上传
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSLog(@"%@ %@", response, [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]);
    }] resume];
}

///  生成 formData 二进制数据
///
///  @param fieldName 服务器字段名
///  @param dataDict  上传文件数据字典 "保存在服务器文件名": 二进制数据
///  @param params    提交参数字典
///
///  @return formData 二进制数据
- (NSData *)formData:(NSString *)fieldName dataDict:(NSDictionary *)dataDict params:(NSDictionary *)params {

    NSMutableData *dataM = [NSMutableData data];

    // 1. 生成文件数据
    [dataDict enumerateKeysAndObjectsUsingBlock:^(NSString *fileName, NSData *fileData, BOOL *stop) {
        NSMutableString *strM = [NSMutableString string];

        [strM appendFormat:@"--%@\r\n", boundary];
        [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fieldName, fileName];
        [strM appendString:@"Content-Type: application/octet-stream\r\n\r\n"];

        [dataM appendData:[strM dataUsingEncoding:NSUTF8StringEncoding]];
        [dataM appendData:fileData];

        [dataM appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }];

    // 2. 生成参数数据
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {

        NSMutableString *strM = [NSMutableString string];

        [strM appendFormat:@"--%@\r\n", boundary];
        [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
        [strM appendString:value];
        [strM appendString:@"\r\n"];

        [dataM appendData:[strM dataUsingEncoding:NSUTF8StringEncoding]];
    }];

    // 3. 结尾字符串
    NSString *tail = [NSString stringWithFormat:@"--%@--", boundary];
    [dataM appendData:[tail dataUsingEncoding:NSUTF8StringEncoding]];

    return dataM.copy;
}

```

## 测试代码

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 1. 上传文件数据
    NSURL *fileURL1 = [[NSBundle mainBundle] URLForResource:@"001.png" withExtension:nil];
    NSData *data1 = [NSData dataWithContentsOfURL:fileURL1];

    NSURL *fileURL2 = [[NSBundle mainBundle] URLForResource:@"demo.jpg" withExtension:nil];
    NSData *data2 = [NSData dataWithContentsOfURL:fileURL2];

    // 如何传递参数 － 用字典传递参数
    NSDictionary *dataDict = @{@"001.png": data1, @"002.jpg": data2};

    // 2. 字符串参数
    NSDictionary *params = @{@"status": @"how are you"};

    // 3. 上传文件并且提交参数
    [self uploadFile:@"userfile[]" dataDict:dataDict params:params];
}
```

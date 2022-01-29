# MD5

## 约定

* 同样的密码，同样的加密算法，每次加密的结果是不一样

## 密码方案
* 方案一：直接 MD5

```objc
pwd = pwd.md5String;
```

> 非常不安全

* 方案二 MD5 + 盐

```objc
pwd = [pwd stringByAppendingString:salt].md5String;
```
> 盐值要够`咸`，可以从服务器获取


* 安全方案三 - HMAC

```objc
pwd = [pwd hmacMD5StringWithKey:@"itheima"];
```
> 相对之前的方案，安全级别要高很多，使用 `itheima` 对 pwd 进行`加密`，然后在进行 md5，然后再次加密，再次 md5

* 安全方案四 - 时间戳密码

```objc
- (NSString *)timePassword {
    // 1. 生成key
    NSString *key = @"itheima".md5String;
    NSLog(@"HMAC Key - %@", key);

    // 2. 对密码进行 hmac 加密
    NSString *pwd = [self.pwd hmacMD5StringWithKey:key];

    // 3. 获取当前系统时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [fmt stringFromDate:[NSDate date]];
    NSLog(@"%@", dateStr);

    // 4. 将系统时间拼接在第一次加密密码的末尾
    pwd = [pwd stringByAppendingString:dateStr];

    // 5. 返回拼接结果的再次 hmac
    return [pwd hmacMD5StringWithKey:key];
}
```

> 密码时效大约两分钟，需要服务器脚本支持，安全级别高，不过客户端的时间与服务器的时间不同步

* 安全方案五 - 服务器时间戳密码

```objc
/// 生成时间戳密码
- (NSString *)timePassword:(NSString *)pwd {
    // 1. 以 itheima.md5 作为 hmac key
    NSString *key = @"itheima".md5String;
    NSLog(@"HMAC KEY - %@", key);

    // 2. 对密码进行 hamc
    NSString *pwd = [self.pwd hmacMD5StringWithKey:key];

    // 3. 取服务器时间
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://localhost/hmackey.php"]];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSString *dateStr = dict[@"key"];

    // 4. 拼接时间字符串
    pwd = [pwd stringByAppendingString:dateStr];

    // 5. 再次 hmac 散列密码
    return [pwd hmacMD5StringWithKey:key];
}
```


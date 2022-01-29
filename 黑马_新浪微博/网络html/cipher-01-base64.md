# Base64

参考网站：http://zh.wikipedia.org/wiki/Base64

## 简介

* 是网络上使用最广泛的编码系统，能够将任何二进制数据，转换成只有 65 个字符组成的文本文件
* `a~z,A~Z,0~9,+,/,=`
* `Base 64` 编码后的结果能够反算，不够安全
* **`Base 64` 是所有现代加密算法的基础算法**

## 终端命令

```bash
# 将 10.jpg 进行 base64 编码，生成 10.txt 文件
$ base64 10.jpg -o 10.txt

# 将 10.txt 解码生成 1.jpg 文件
$ base64 -D 10.txt -o 1.jpg

# 将字符串 Man 进行 base64 编码
$ echo -n "Man" | base64

# 将字符串 TWFu 解码
$ echo -n "TWFu" | base64 -D
```

## 代码实现

```objc
///  BASE 64 编码
- (NSString *)base64Encode:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    return [data base64EncodedStringWithOptions:0];
}

///  BASE 64 解码
- (NSString *)base64Decode:(NSString *)string {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];

    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
```

## 保存 & 加载用户信息

```objc
///  保存用户信息
- (void)saveUserInfo {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // iOS 8.0 会直接写入沙盒，无需再使用 `[defaults synchronize];`
    [defaults setObject:self.username forKey:HMUsernameKey];

    NSString *pwd = [self base64Encode:self.pwd];
    [defaults setObject:pwd forKey:HMUserPasswordKey];
}

///  加载用户下信息
- (void)loadUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    self.usernameText.text = [defaults stringForKey:HMUsernameKey];
    self.pwdText.text = [self base64Decode:[defaults stringForKey:HMUserPasswordKey]];
}
```

## 存在的问题

1. 使用 `Base64` 不能直接看到用户密码的明文
2. 但是 `Base64` 的算法是公开的，并且算法可逆，安全性并不好


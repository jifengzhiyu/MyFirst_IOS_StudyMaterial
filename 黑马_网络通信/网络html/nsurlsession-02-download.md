# 下载 & 解压缩

## 基本代码

```objc
- (void)download {

    NSLog(@"开始");

    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://localhost/321.zip"];

    // 2. 下载
    [[[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@"%@ %@", location, [NSThread currentThread]);
    }] resume];
}
```

> 运行测试：块代码回调结束后，下载的文件会被删除

原因分析：

1. 一般从网络上下载文件，`zip` 压缩包会比较多
2. 如果是 zip 文件，下载完成后需要：
    - 下载压缩包
    - 解压缩(异步执行)到目标文件夹
    - 删除压缩包

3. 下载任务的特点可以让程序员只关心解压缩的工作

## 解压缩

1. 添加第三方框架 `SSZipArchive`
2. 添加动态库 `libz.dylib`
3. 解压缩

```objc
// 目录
NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
[SSZipArchive unzipFileAtPath:location.path toDestination:cacheDir];
```

> 提示：解压缩只需要指定目标目录即可，因为压缩包中可能会包含多个文件

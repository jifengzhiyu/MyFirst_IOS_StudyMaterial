# JSON 解析第三方框架

## 常见的 JSON 解析第三方框架

* `JSONKit`（最快）
* `SBJson`
* `TouchJSON`

以上三个框架的性能依次降低！

## 介绍 JSONKit 第三方框架的目的

1. `JSON` 的解析并不是表面上那么简单
2. 官方说 `JSONKit` 比苹果原生的 `JSON` 解析速度快！
3. `JSONKit` 在很多老的项目中仍然在使用
    * 知道 `JSONKit` 说明我们是**资深 iOS 程序员**
4. `JSONKit` 已经在 `2012` 年停止更新，适用于 iOS 5.0 以前的版本开发使用
5. 了解 `ARC & MRC` 混编的方法

### 步骤

1. 下载框架 https://github.com/johnezang/JSONKit
2. 导入框架文件
    * JSONKit.h
    * JSONKit.m
3. 设置 MRC 标记
    * 选择"项目"－"Build Phases"－"Compile Sources"
    * 找到 JSONKit.m 并且在 Compiler Flags 中添加 `-fno-objc-arc`
        * 可以告诉编译器，编译 JSONKit.m 时不使用 ARC
4. 修改错误
    * 利用自动修复功能，修改两处 isa 的错误
5. 反序列化

```objc
id result = [[JSONDecoder decoder] objectWithData:data];
```

### 性能测试

```objc
static int largeNumber = 100 * 1000;

- (void)jsonKitDemo {
    NSString *urlString = @"http://localhost/demo.json";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSLog(@"start");
        CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
        for (int i = 0; i < largeNumber; ++i) {
            id result = [[JSONDecoder decoder] objectWithData:data];
        }
        NSLog(@"%f", CFAbsoluteTimeGetCurrent() - start);

        // 数据处理代码...
    }];
}
```

测试结果：

* 时间：3.24s
* 内存：4.74G

苹果原生框架

* 时间：0.18s
* 内存：几乎不变

> 重要提示：进入公司，如果仍然还在使用老的框架解析 `JSON`，可以直接替换成苹果原生的解析


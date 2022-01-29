# 下载操作实现

```objc
#import "NSString+Path.h"

@interface DownloadImageOperation()
/// 要下载图像的 URL 字符串
@property (nonatomic, copy) NSString *URLString;
/// 完成回调 Block
@property (nonatomic, copy) void (^finishedBlock)(UIImage *image);
@end

@implementation DownloadImageOperation

+ (instancetype)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *))finished {
    DownloadImageOperation *op = [[DownloadImageOperation alloc] init];

    op.URLString = URLString;
    op.finishedBlock = finished;

    return op;
}

- (void)main {
    @autoreleasepool {
        // 利用断言要求必须传入完成回调，简化后续代码的分支
        NSAssert(self.finishedBlock != nil, @"必须传入回调 Block");

        // 1. NSURL
        NSURL *url = [NSURL URLWithString:self.URLString];
        // 2. 获取二进制数据
        NSData *data = [NSData dataWithContentsOfURL:url];
        // 3. 保存至沙盒
        if (data != nil) {
            [data writeToFile:self.URLString.appendCachePath atomically:YES];
        }

        if (self.isCancelled) {
            NSLog(@"下载操作被取消");
            return;
        }

        // 主线程回调
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finishedBlock([UIImage imageWithData:data]);
        }];
    }
}
```

## 断言

* 断言是所有 C 语言开发者的最爱
* 断言能够在程序编码时提前预判必须满足某一个条件
* 如果条件不满足，直接让程序崩溃，从而让程序员尽早发现错误
* 断言仅在调试时有效
* 断言可以简化程序的分支逻辑

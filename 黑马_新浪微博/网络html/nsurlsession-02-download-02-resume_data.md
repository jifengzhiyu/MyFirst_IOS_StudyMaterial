# 断点续传

## 基本功能实现

* 定义属性

```objc
///  下载任务
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
///  续传数据
@property (nonatomic, strong) NSData *resumeData;
```

* 开始下载

```objc
- (IBAction)start {

    if (self.downloadTask != nil) {
        NSLog(@"正在玩命下载中...");
        return;
    }

    NSURL *url = [NSURL URLWithString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.0.2.dmg"];

    self.downloadTask = [self.session downloadTaskWithURL:url];
    [self.downloadTask resume];
}
```

* 暂停

```objc
- (IBAction)pause {
    NSLog(@"暂停");
    [self.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        NSLog(@"pause %tu", resumeData.length);
        self.resumeData = resumeData;
        self.downloadTask = nil;
    }];
}
```

* 继续

```objc
- (IBAction)resume {

    if (self.resumeData == nil) {
        NSLog(@"没有续传数据");
        return;
    }

    self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];

    self.resumeData = nil;

    [self.downloadTask resume];
}
```

## 开始下载功能完善

```objc
- (IBAction)start {

    if (self.downloadTask != nil) {
        NSLog(@"正在玩命下载中...");
        return;
    } else if (self.resumeData != nil) {
        NSLog(@"继续下载");

        [self resume];
        return;
    }

    NSURL *url = [NSURL URLWithString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.0.2.dmg"];

    self.downloadTask = [self.session downloadTaskWithURL:url];
    [self.downloadTask resume];
}
```



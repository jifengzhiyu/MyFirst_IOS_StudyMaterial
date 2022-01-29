# 下载管理器

## 单例实现

* `.h` 定义全局访问方法

```objc
+ (instancetype)sharedDownloadManager;
```

* `.m` 实现

```objc
@interface DownloadManager() <NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation DownloadManager

+ (instancetype)sharedDownloadManager {
    static DownloadManager *instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];

        // 实例化网络会话
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance.session = [NSURLSession sessionWithConfiguration:config delegate:instance delegateQueue:nil];
    });

    return instance;
}

@end
```

## 实现代理方法

```objc
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
#warning 错误回调
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
#warning 完成回调
    NSLog(@"%@", location);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {

    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"%f %@", progress, [NSThread currentThread]);
#warning 进度回调
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"%s", __FUNCTION__);
}
```

## 下载方法实现

* 定义接口方法

```objc
///  下载指定 URL
///
///  @param url      URL
///  @param progress 进度回调
///  @param finished 完成回调
- (void)downloadWithURL:(NSURL *)url progress:(void (^)(float progress))progress finished:(void (^)(NSURL *location, NSError *error))finished;
```

* 下载方法实现

```objc
- (void)downloadWithURL:(NSURL *)url progress:(void (^)(float))progress finished:(void (^)(NSURL *, NSError *))finished {

    // 1. 创建下载任务
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:url];

    // 2. 启动下载任务
    [task resume];
}
```

## 替换下载方法

```objc
- (IBAction)start {
//    if (self.downloadTask != nil) {
//        NSLog(@"正在玩命下载中...");
//        return;
//    } else if (self.resumeData != nil) {
//        NSLog(@"继续下载");
//
//        [self resume];
//        return;
//    }

    NSURL *url = [NSURL URLWithString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.0.2.dmg"];
    [[DownloadManager sharedDownloadManager] downloadWithURL:url progress:^(float progress) {
        NSLog(@"%f", progress);
    } finished:^(NSURL *location, NSError *error) {
        NSLog(@"%@ %@", location, error);
    }];
}
```

> 问题：如何识别`下载任务`以及与其绑定的`回调代码`

* 解决办法——自定义`下载任务回调`类

```objc
@interface SessionTaskCallBack : NSObject
///  进度回调，可选
@property (nonatomic, copy) void (^progressBlock)(float progress);
///  完成回调
@property (nonatomic, copy) void (^finishedBlock)(NSURL *location, NSError *error);
///  续传数据
@property (nonatomic, strong) NSData *resumeData;
@end

@implementation SessionTaskCallBack

@end
```

* 定义缓冲池

```objc
///  下载任务缓冲池
@property (nonatomic, strong) NSMutableDictionary *downloadTaskCache;
///  下载任务回调缓冲池
@property (nonatomic, strong) NSMutableDictionary *downloadTaskCallBackCache;
```

* 实现缓冲池

```objc
- (NSMutableDictionary *)downloadTaskCache {
    if (_downloadTaskCache == nil) {
        _downloadTaskCache = [NSMutableDictionary dictionary];
    }
    return _downloadTaskCache;
}

- (NSMutableDictionary *)downloadTaskCallBackCache {
    if (_downloadTaskCallBackCache == nil) {
        _downloadTaskCallBackCache = [NSMutableDictionary dictionary];
    }
    return _downloadTaskCallBackCache;
}
```

* 修改下载方法，添加缓冲池

```objc
- (void)downloadWithURL:(NSURL *)url progress:(void (^)(float))progress finished:(void (^)(NSURL *, NSError *))finished {

    // 0. 判断任务是否存在
    if (self.downloadTaskCache[url] != nil) {
        NSLog(@"下载任务已经存在");
        return;
    }

    // 1. 创建下载任务
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:url];

    // 2. 将下载任务添加到缓冲池
    [self.downloadTaskCache setObject:task forKey:url];

    // 3. 创建下载任务回调类
    SessionTaskCallBack *callBack = [[SessionTaskCallBack alloc] init];
    // 2.1 记录进度回调
    callBack.progressBlock = progress;
    // 2.2 记录完成回调
    callBack.finishedBlock = finished;

    // 将任务回调添加到缓冲池
    [self.downloadTaskCallBackCache setObject:callBack forKey:task];

    // 4. 启动下载任务
    [task resume];
}
```

* 完成回调

```objc
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // 从任务回调缓冲池获取回调对象
    SessionTaskCallBack *callBack = self.downloadTaskCallBackCache[downloadTask];

    if (callBack == nil) {
        NSLog(@"没有任务");

        return;
    }
    if (callBack.finishedBlock != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack.finishedBlock(location, nil);
        });
    }
}
```

* 错误回调

```objc
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {

    // 从任务回调缓冲池获取回调对象
    SessionTaskCallBack *callBack = self.downloadTaskCallBackCache[task];

    if (callBack == nil) {
        NSLog(@"没有任务");
        return;
    }

    if (callBack.finishedBlock != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                callBack.finishedBlock(nil, error);
            }
            // 删除缓存
            [self.downloadTaskCallBackCache removeObjectForKey:task];
            [self.downloadTaskCache enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if (obj == task) {
                    NSLog(@"%@", self.downloadTaskCache);
                    [self.downloadTaskCache removeObjectForKey:key];
                    *stop = YES;
                }
            }];
        });
    }
}
```

* 进度回调

```objc
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {

    // 从任务回调缓冲池获取回调对象
    SessionTaskCallBack *callBack = self.downloadTaskCallBackCache[downloadTask];

    if (callBack == nil) {
        NSLog(@"没有任务");

        return;
    }

    if (callBack.progressBlock != nil) {
        float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
        callBack.progressBlock(progress);
    }
}
```

## 暂停&继续

```objc
- (void)pause:(NSURL *)url {
    NSURLSessionTask *task = self.downloadTaskCache[url];

    if (task.state == NSURLSessionTaskStateRunning) {
        [task suspend];
    }
}

- (void)resume:(NSURL *)url {
    NSURLSessionTask *task = self.downloadTaskCache[url];

    if (task.state == NSURLSessionTaskStateSuspended) {
        [task resume];
    }
}
```


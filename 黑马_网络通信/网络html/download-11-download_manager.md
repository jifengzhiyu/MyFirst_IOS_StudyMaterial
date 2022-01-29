# 下载管理器

## 单例

```objc
+ (instancetype)sharedDownloadManager {
    static id instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}
```

## 移植下载方法

```objc
- (void)downloadWithURL:(NSURL *)url progress:(void (^)(float))progress finised:(void (^)(NSString *, NSError *))finised {

    HMDownloadOperation *downloader = [HMDownloadOperation downloadWithURL:url progress:progress finised:finised];

    [downloader download];
}
```

## 下载缓冲池

### 缓冲池属性

```objc
///  下载缓冲池
@property (nonatomic, strong) NSMutableDictionary *downloaderCache;

// MARK: - 懒加载
- (NSMutableDictionary *)downloaderCache {
    if (_downloaderCache == nil) {
        _downloaderCache = [[NSMutableDictionary alloc] init];
    }
    return _downloaderCache;
}
```

### 修改下载方法

```objc
- (void)downloadWithURL:(NSURL *)url progress:(void (^)(float))progress finised:(void (^)(NSString *, NSError *))finised {

    // 1. 判断下载操作缓冲池中是否存在下载操作
    if (self.downloaderCache[url]) {
        NSLog(@"正在玩命下载中...");
        return;
    }

    // 2. 实例化下载操作
    HMDownloadOperation *downloader = [HMDownloadOperation downloadWithURL:url progress:progress finised:finised];

    // 3. 添加到下载操作缓冲池
    [self.downloaderCache setObject:downloader forKey:url];

    // 4. 开始下载
    [downloader download];
}
```

#### 下载完成后，将操作从缓冲池中删除

```objc
// 2. 实例化下载操作
HMDownloadOperation *downloader = [HMDownloadOperation downloadWithURL:url progress:progress finised:^(NSString *filePath, NSError *error) {

    // 将操作从缓冲池中删除
    [self.downloaderCache removeObjectForKey:url];

    // 执行调用方准备的 finished
    finised(filePath, error);
}];
```

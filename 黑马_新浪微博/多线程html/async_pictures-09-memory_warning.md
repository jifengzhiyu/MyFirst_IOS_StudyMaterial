# 内存警告

> 如果接收到内存警告，程序一定要做处理，日常上课时，不会特意处理。但是工作中的程序一定要处理，否则后果很严重！！！

```objc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // 1. 取消下载操作
    [self.downloadQueue cancelAllOperations];

    // 2. 清空缓冲池
    [self.operationCache removeAllObjects];
    [self.imageCache removeAllObjects];
}
```

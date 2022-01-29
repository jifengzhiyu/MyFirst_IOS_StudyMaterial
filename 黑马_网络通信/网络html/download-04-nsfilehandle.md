# NSFileHandle 拼接文件

* `NSFileManager` : 主要是做文件的删除，移动，复制，检查文件是否存在等操作，类似于 Finder
* `NSFileHandle` : 文件`句柄(指针)`，操纵，提示：凡是看到 Handle 这个单词，就表示对前面一个单词(File)的独立操作

```objc
- (void)writeData:(NSData *)data {

    NSFileHandle *fp = [NSFileHandle fileHandleForWritingAtPath:self.targetPath];

    if (fp == nil) {
        [data writeToFile:self.targetPath atomically:YES];
    } else {
        [fp seekToEndOfFile];
        [fp writeData:data];
        [fp closeFile];
    }
}
```

> 问题：文件会被重复追加

```objc
// 下载前删除文件
[[NSFileManager defaultManager] removeItemAtPath:self.targetPath error:NULL];
```

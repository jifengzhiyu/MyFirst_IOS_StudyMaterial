# Copy 属性

## 视频时长属性

```objc
///  时间字符串
@property (nonatomic, copy) NSString *timeString;
```

### 使用 getter 方法

```objc
- (NSString *)timeString {
    int len = self.length.intValue;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", len / 3600, (len % 3600) / 60, len % 60];
}
```

### 利用 length 的 setter 方法

```objc
- (void)setLength:(NSNumber *)length {
    _length = length;

    int len = length.intValue;
    _timeString = [NSString stringWithFormat:@"%02d:%02d:%02d", len / 3600, (len % 3600) / 60, len % 60];
}
```

* 对比两种方式的效率
* 注意 length 属性的变化

### 修改 setter 方法

```objc
- (void)setLength:(NSNumber *)length {
    _length = [length copy];

    int len = length.intValue;
    _timeString = [NSString stringWithFormat:@"%02d:%02d:%02d", len / 3600, (len % 3600) / 60, len % 60];
}
```

> 如果重写 copy 属性的 setter 方法，一定要使用 `copy`！

# 归档 & 解档

* `归档 & 解档`的概念与网络的`序列化&反序列化`的概念非常像
* 是 iOS 中在沙盒中保存自定义对象的一种手段
* 要使用 `归档和解档` 需要：
    1. 在自定义对象中遵守 `NSCoding` 协议
    2. 实现 `encodeWithCoder` 方法，将对象保存到磁盘之前，将对象转换成二进制数据
    3. 实现 `initWithCoder` 方法，读取归档的二进制文件后，转换成自定义对象
    4. 调用 `[NSKeyedArchiver archiveRootObject:p toFile:path];` 可以将自定义对象或数组归档保存至文件
    5. 调用 `[NSKeyedUnarchiver unarchiveObjectWithFile:path];` 可以从归档保存的文件加载自定义对象或者数组

```objc
/**
 *  编码器：将对象保存到磁盘之前，将对象转换成二进制数据
 *  概念：跟网络的序列化非常像
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"nameKey"];
    [aCoder encodeInt:_age forKey:@"ageKey"];
}

/**
 *  解码器：读取归档的二进制文件后，转换成自定义对象
 *
 *  概念：网络的反序列化非常像
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        // key 一定要和归档的对应
        _name = [aDecoder decodeObjectForKey:@"nameKey"];
        _age = [aDecoder decodeIntForKey:@"ageKey"];
    }
    return self;
}
```

> 归档&解档方法中的 key 一定要对应

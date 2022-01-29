# 操作缓冲池

## 缓冲池的选择

所谓缓冲池，其实就是一个容器，能够存放多个对象

* 数组：按照下标，可以通过 `indexPath` 可以判断操作是否已经在进行中
    * 无法解决上拉&下拉刷新
* NSSet -> 无序的
    * 无法定位到缓存的操作
* `字典`：按照`key`，可以通过下载图像的 `URL`（唯一定位网络资源的字符串）

小结：`选择字典作为操作缓冲池`

## 缓冲池属性

```objc
///  操作缓冲池
@property (nonatomic, strong) NSMutableDictionary *operationCache;
```

* 懒加载

```objc
- (NSMutableDictionary *)operationCache {
    if (_operationCache == nil) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}
```

## 修改代码

* 判断下载操作是否被缓存——正在下载

```objc
// 异步加载图像
// 0. 占位图像
UIImage *placeholder = [UIImage imageNamed:@"user_default"];
cell.iconView.image = placeholder;

// 判断操作是否存在
if (self.operationCache[app.icon] != nil) {
    NSLog(@"正在玩命下载中...");
    return cell;
}
```

* 将操作添加到操作缓冲池

```objc
// 2. 将操作添加到操作缓冲池
[self.operationCache setObject:downloadOp forKey:app.icon];

// 3. 将下载操作添加到队列
[self.downloadQueue addOperation:downloadOp];
```

> 修改占位图像的代码位置，观察会出现的问题

* 下载完成后，将操作从缓冲池中删除

```objc
[self.operationCache removeObjectForKey:app.icon];
```

### 循环引用分析！

* 弱引用 `self` 的编写方法：

```objc
__weak typeof(self) weakSelf = self;
```

* 利用 `dealloc` 辅助分析

```objc
- (void)dealloc {
    NSLog(@"我去了");
}
```

* 注意
    * 如果使用 `self`，视图控制器会在下载完成后被销毁
    * 而使用 `weakSelf`，视图控制器在第一时间被销毁









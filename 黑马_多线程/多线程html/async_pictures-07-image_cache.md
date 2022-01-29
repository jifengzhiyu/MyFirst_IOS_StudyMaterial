# 图像缓冲池

## 使用模型缓存图像的问题

### 优点

* 不用重复下载，利用MVC刷新表格，不会造成数据混乱

### 缺点

* 所有下载后的图像，都会记录在模型中
* 如果模型数据本身很多（2000），单纯图像就会占用很大的内存空间
* 如果图像和模型绑定的很紧，不容易清理内存

### 解决办法

* 使用图像缓存池

## 图像缓存

* 缓存属性

```objc
///  图像缓冲池
@property (nonatomic, strong) NSMutableDictionary *imageCache;
```

* 懒加载

```objc
- (NSMutableDictionary *)imageCache {
    if (_imageCache == nil) {
        _imageCache = [[NSMutableDictionary alloc] init];
    }
    return _imageCache;
}
```

* 删除模型中的 `image` 属性
* 哪里出错改哪里！

## 断网测试

### 问题

* `image == nil` 时会崩溃=>不能向字典中插入 nil
* `image == nil` 时会重复刷新表格，陷入死循环

### 解决办法

* 修改主线程回调代码

```objc
[[NSOperationQueue mainQueue] addOperationWithBlock:^{
    if (image != nil) {
        // 设置模型中的图像
        [weakSelf.imageCache setObject:image forKey:app.icon];
        // 刷新表格
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}];
```


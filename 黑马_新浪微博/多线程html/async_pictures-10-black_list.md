# 黑名单

> 如果网络正常，但是图像下载失败后，为了避免再次都从网络上下载该图像，可以使用“黑名单”

* 黑名单属性

```objc
@property (nonatomic, strong) NSMutableArray *blackList;
```

* 懒加载

```objc
- (NSMutableArray *)blackList {
    if (_blackList == nil) {
        _blackList = [NSMutableArray array];
    }
    return _blackList;
}
```

* 下载失败记录在黑名单中

```
if (image != nil) {
    // 设置模型中的图像
    [weakSelf.imageCache setObject:image forKey:app.icon];
    // 刷新表格
    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
} else {
    // 下载失败记录在黑名单中
    [weakSelf.blackList addObject:app.icon];
}
```

* 判断黑名单

```objc
// 2.1 判断黑名单
if ([self.blackList containsObject:app.icon]) {
    NSLog(@"已经将 %@ 加入黑名单...", app.icon);
    return;
}
```

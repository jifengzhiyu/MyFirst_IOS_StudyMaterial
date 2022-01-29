# 代码重构

## 代码重构介绍

### 重构目的

* 相同的代码最好只出现一次
* 主次方法
    * 主方法
        * 只包含实现完整逻辑的子方法
        * 思维清楚，便于阅读
    * 次方法
        * 实现具体逻辑功能
        * 测试通过后，后续几乎不用维护

### 重构的步骤

* 新建一个方法
    * 新建方法
    * 把要抽取的代码，直接复制到新方法中
    * 根据需求调整参数
* 调整旧代码
    * 注释原代码，给自己一个后悔的机会
    * 调用新方法
* 测试
* 优化代码
    * 在原有位置，因为要照顾更多的逻辑，代码有可能是合理的
    * 而抽取之后，因为代码少了，可以检查是否能够优化
    * 分支嵌套多，不仅执行性能会差，而且不易于阅读
* 测试
* 修改注释
    * 在开发中，注释不是越多越好
    * 如果忽视了注释，有可能过一段时间，自己都看不懂那个注释
    * .m 关键的实现逻辑，或者复杂代码，需要添加注释，否则，时间长了自己都看不懂！
    * .h 中的所有属性和方法，都需要有完整的注释，因为 .h 文件是给整个团队看的

> 重构一定要小步走，要边改变测试

## 重构后的代码

```objc
- (void)downloadImage:(NSIndexPath *)indexPath {

    // 1. 根据 indexPath 获取数据模型
    AppInfo *app = self.appList[indexPath.row];

    // 2. 判断操作是否存在
    if (self.operationCache[app.icon] != nil) {
        NSLog(@"正在玩命下载中...");
        return;
    }

    // 3. 定义下载操作
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *downloadOp = [NSBlockOperation blockOperationWithBlock:^{
        // 1. 模拟延时
        NSLog(@"正在下载 %@", app.name);
        if (indexPath.row == 0) {
            [NSThread sleepForTimeInterval:3.0];
        }
        // 2. 异步加载网络图片
        NSURL *url = [NSURL URLWithString:app.icon];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];

        // 3. 主线程更新 UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 将下载操作从缓冲池中删除
            [weakSelf.operationCache removeObjectForKey:app.icon];

            if (image != nil) {
                // 设置模型中的图像
                [weakSelf.imageCache setObject:image forKey:app.icon];
                // 刷新表格
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }];

    // 4. 将操作添加到操作缓冲池
    [self.operationCache setObject:downloadOp forKey:app.icon];

    // 5. 将下载操作添加到队列
    [self.downloadQueue addOperation:downloadOp];
}
```



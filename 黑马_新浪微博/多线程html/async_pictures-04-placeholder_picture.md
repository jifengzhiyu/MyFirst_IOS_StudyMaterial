# 占位图像

```objc
// 0. 占位图像
UIImage *placeholder = [UIImage imageNamed:@"user_default"];
cell.imageView.image = placeholder;
```

## 问题

* 因为使用的是系统提供的 cell
* 每次和 cell 交互，`layoutSubviews` 方法会根据图像的大小自动调整 `imageView` 的尺寸

## 解决办法

* 自定义 Cell

# 自定义 Cell

```objc
cell.nameLabel.text = app.name;
cell.downloadLabel.text = app.download;

// 异步加载图像
// 0. 占位图像
UIImage *placeholder = [UIImage imageNamed:@"user_default"];
cell.iconView.image = placeholder;

// 1. 定义下载操作
NSBlockOperation *downloadOp = [NSBlockOperation blockOperationWithBlock:^{
    // 1. 模拟延时
    NSLog(@"正在下载 %@", app.name);
    [NSThread sleepForTimeInterval:0.5];
    // 2. 异步加载网络图片
    NSURL *url = [NSURL URLWithString:app.icon];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];

    // 3. 主线程更新 UI
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        cell.iconView.image = image;
    }];
}];

// 2. 将下载操作添加到队列
[self.downloadQueue addOperation:downloadOp];
```

## 问题

* 如果网络图片下载速度不一致，同时用户滚动图片，可能会出现图片显示"错行"的问题

* 修改延时代码，查看错误

```objc
// 1. 模拟延时
if (indexPath.row > 9) {
    [NSThread sleepForTimeInterval:3.0];
}
```

上下滚动一下表格即可看到 cell 复用的错误

## 解决办法

* MVC

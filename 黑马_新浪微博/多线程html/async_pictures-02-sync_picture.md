# 同步加载图像

```objc
// 同步加载图像
// 1. 模拟延时
NSLog(@"正在下载 %@", app.name);
[NSThread sleepForTimeInterval:0.5];
// 2. 同步加载网络图片
NSURL *url = [NSURL URLWithString:app.icon];
NSData *data = [NSData dataWithContentsOfURL:url];
UIImage *image = [UIImage imageWithData:data];

cell.imageView.image = image;
```

> 注意：之前没有设置 `imageView` 时，`imageView` 并不会被创建

## 存在的问题

1. 如果网速慢，会卡爆了！影响用户体验
2. 滚动表格，会重复下载图像，造成用户经济上的损失！

## 解决办法

* 异步下载图像


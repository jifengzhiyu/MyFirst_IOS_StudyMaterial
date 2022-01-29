# SDWebImage初体验

## 简介

* iOS中著名的牛逼的网络图片处理框架
* 包含的功能：图片下载、图片缓存、下载进度监听、gif处理等等
* 用法极其简单，功能十分强大，大大提高了网络图片的处理效率
* 国内超过90%的iOS项目都有它的影子
* 框架地址：https://github.com/rs/SDWebImage

## 演示 `SDWebImage`

* 导入框架
* 添加头文件

```objc
#import "UIImageView+WebCache.h"
```

* 设置图像

```objc
[cell.iconView sd_setImageWithURL:[NSURL URLWithString:app.icon]];
```

## 思考：SDWebImage 是如何实现的？

* 将网络图片的异步加载功能封装在 `UIImageView` 的分类中
* 与 `UITableView` 完全解耦

> 要实现这一目标，需要解决以下问题：

* 给 `UIImageView` 下载图像的功能
* 要解决表格滚动时，因为图像下载速度慢造成的图片错行问题，可以在给 `UIImageView` 设置新的 `URL` 时，`取消之前未完成的下载操作`

> 目标锁定：取消正在执行中的操作！


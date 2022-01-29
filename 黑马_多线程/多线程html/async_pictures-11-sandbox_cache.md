# 沙盒缓存实现

## 沙盒目录介绍

* Documents
    - 保存由应用程序产生的文件或者数据，例如：涂鸦程序生成的图片，游戏关卡记录
    - iCloud 会自动备份 Document 中的所有文件
    - 如果保存了从网络下载的文件，在上架审批的时候，会被拒！
* tmp
    - 临时文件夹，保存临时文件
    - 保存在 tmp 文件夹中的文件，系统会自动回收，譬如磁盘空间紧张或者重新启动手机
    - 程序员不需要管 tmp 文件夹中的释放

* Caches
    - 缓存，保存从网络下载的文件，后续仍然需要继续使用，例如：网络下载的离线数据，图片，视频...
    - 缓存目录中的文件系统不会自动删除，可以做离线访问！
	- **要求程序必需提供一个完善的清除缓存目录的"解决方案"！**

* Preferences
	- 系统偏好，用户偏好
	- 操作是通过 `[NSUserDefaults standardDefaults]` 来直接操作

### iOS 不同版本间沙盒目录的变化

* iOS 7.0及以前版本 `bundle` 目录和沙盒目录是在一起的
* iOS 8.0之后，`bundle` 目录和沙盒目录是分开的

## NSString+Path

```objc
#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString *)appendDocumentPath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appendCachePath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appendTempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

@end
```

## 沙盒缓存

* 将图像保存至沙盒

```objc
if (data != nil) {
    [data writeToFile:app.icon.appendCachePath atomically:true];
}
```

* 检查沙盒缓存

```objc
// 判断沙盒文件是否存在
UIImage *image = [UIImage imageWithContentsOfFile:app.icon.appendCachePath];
if (image != nil) {
    NSLog(@"从沙盒加载图像 ... %@", app.name);
    // 将图像添加至图像缓存
    [self.imageCache setObject:image forKey:app.icon];
    cell.iconView.image = image;

    return cell;
}
```

# iOS6 的适配问题

**面试题：iOS 6.0 的程序直接运行在 iOS 7.0 的系统中，通常会出现什么问题**

* 状态栏高度 20 个点是不包含在 `view.frame` 中的，`self.view` 的左上角原点的坐标位置是从状态栏下方开始计算
	* iOS 6.0 程序直接在 iOS 7.0 的系统中运行最常见的问题，就是少了20个点

* 如果包含有 `UINavigationController`，`self.view`的左上角坐标原点从状态栏下方开始计算
	* 因此，iOS 6.0的系统无法实现表格从导航条下方穿透的效果

* 如果包含有 `UITabBarController`，`self.view`的底部不包含 TabBar
	* 因此，iOS 6.0的系统无法实现表格从 TabBar 下方穿透效果

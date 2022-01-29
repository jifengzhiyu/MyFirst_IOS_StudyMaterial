# 自定义 UIImageView

* 目标：
    * 利用下载管理器获取指定 `URLString` 的图像，完成后设置 `image`
    * 如果之前存在未完成的下载，判断是否与给定的 `URLString` 一致
    * 如果一致，等待下载结束
    * 如果不一致，取消之前的下载操作

* 定义方法

```objc
///  设置指定 URL 字符串的网络图像
///
///  @param URLString 网络图像 URL 字符串
- (void)setImageWithURLString:(NSString *)URLString;
```

* 方法实现

```objc
@interface WebImageView()
///  当前正在下载的 URL 字符串
@property (nonatomic, copy) NSString *currentURLString;
@end

@implementation WebImageView

- (void)setImageWithURLString:(NSString *)URLString {

    // 取消之前的下载操作
    if (![URLString isEqualToString:self.currentURLString]) {
        // 取消之前操作
        [[DownloadImageManager sharedManager] cancelDownloadWithURLString:self.currentURLString];
    }

    // 记录当前操作
    self.currentURLString = URLString;

    // 创建下载操作
    __weak typeof(self) weakSelf = self;
    [[DownloadImageManager sharedManager] downloadImageOperationWithURLString:URLString finished:^(UIImage *image) {
        weakSelf.image = image;
    }];
}

@end
```

* 修改 `ViewController` 中的调用代码

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    int seed = arc4random_uniform((UInt32)self.appList.count);
    AppInfo *app = self.appList[seed];

    [self.iconView setImageWithURLString:app.icon];
}
```

## 运行时机制 —— 关联对象

```objc
// MARK: - 运行时关联对象
const void *HMCurrentURLStringKey = "HMCurrentURLStringKey";

- (void)setCurrentURLString:(NSString *)currentURLString {
    objc_setAssociatedObject(self, HMCurrentURLStringKey, currentURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)currentURLString {
    return objc_getAssociatedObject(self, HMCurrentURLStringKey);
}
```

* 为了防止 `Cell` 重用，取消之前下载操作的同时，清空 image

```objc
self.image = nil;
```

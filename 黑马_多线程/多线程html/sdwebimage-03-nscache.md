# NSCache

## 介绍

* `NSCache` 是苹果提供的一个专门用来做缓存的类
* 使用和 `NSMutableDictionary` 非常相似
* 是线程安全的
* 当内存`不足`的时候，会自动清理缓存
* 程序开始时，可以指定缓存的`数量` & `成本`

## 方法

* 取值
    * `- (id)objectForKey:(id)key;`

* 设置对象，0成本
    * `- (void)setObject:(id)obj forKey:(id)key;`

* 设置对象并指定`成本`
    * `- (void)setObject:(id)obj forKey:(id)key cost:(NSUInteger)g;`

* 成本示例，以图片为例：
    * 方案一：缓存 `100` 张图片
    * 方案二：总缓存成本设定为 `10M`，以图片的 `宽 * 高`当作成本，图像`像素`。这样，无论缓存的多少张照片，只要像素值超过 10M，就会自动清理
    * 结论：在缓存图像时，使用成本，比单纯设置数量要科学！

* 删除
    * `- (void)removeObjectForKey:(id)key;`

* 删除全部（不要使用！）
    * `- (void)removeAllObjects;`

## 属性

* `@property NSUInteger totalCostLimit;`
    * 缓存总成本

* `@property NSUInteger countLimit;`
    * 缓存总数量

* `@property BOOL evictsObjectsWithDiscardedContent;`
    * 是否自动清理缓存，默认是 `YES`

## 代码演练

* 定义缓存属性

```objc
@property (nonatomic, strong) NSCache *cache;
```

* 懒加载并设置限制

```objc
- (NSCache *)cache {
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.delegate = self;
        _cache.countLimit = 10;
    }
    return _cache;
}
```

* 触摸事件添加缓存

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (int i = 0; i < 20; ++i) {
        NSString *str = [NSString stringWithFormat:@"%d", i];
        NSLog(@"set -> %@", str);
        [self.cache setObject:str forKey:@(i)];
        NSLog(@"set -> %@ over", str);
    }

    // 遍历缓存
    NSLog(@"------");

    for (int i = 0; i < 20; ++i) {
        NSLog(@"%@", [self.cache objectForKey:@(i)]);
    }
}

// 代理方法，仅供观察使用，开发时不建议重写此方法
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"remove -> %@", obj);
}
```

## 修改网络图片框架

* 修改图像缓冲池类型，并移动到 `.h` 中，以便后续测试

```objc
///  图像缓冲池
@property (nonatomic, strong) NSCache *imageCache;
```

* 修改懒加载，并设置数量限制

```objc
- (NSCache *)imageCache {
    if (_imageCache == nil) {
        _imageCache = [[NSCache alloc] init];
        _imageCache.countLimit = 15;
    }
    return _imageCache;
}
```

* 修改其他几处代码，将 `self.imageCache[URLString]` 替换为 `[self.imageCache setObject:image forKey:URLString];`

* 测试缓存中的图片变化

```objc
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (AppInfo *app in self.appList) {
        NSLog(@"%@ %@", [[DownloadImageManager sharedManager].imageCache objectForKey:app.icon], app.name);
    }
}
```

* 注册通知，监听内存警告

```objc
- (instancetype)init
{
    self = [super init];
    if (self) {
        // 注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMemory) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

// 提示：虽然执行不到，但是写了也无所谓
- (void)dealloc {
    // 删除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
```

* 清理内存

```objc
- (void)clearMemory {
    NSLog(@"%s", __FUNCTION__);

    // 取消所有下载操作
    [self.downloadQueue cancelAllOperations];

    // 删除缓冲池
    [self.operationChache removeAllObjects];
}
```

> 注意：内存警告或者超出限制后，缓存中的任何对象，都有可能被清理。使用 NSCache 做缓存一定要保证能够有恢复的通道！

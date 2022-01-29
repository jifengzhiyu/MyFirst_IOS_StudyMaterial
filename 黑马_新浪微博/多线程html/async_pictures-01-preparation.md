# 搭建界面&数据准备

## 代码

### 数据准备

```objc
@interface AppInfo : NSObject
///  App 名称
@property (nonatomic, copy) NSString *name;
///  图标 URL
@property (nonatomic, copy) NSString *icon;
///  下载数量
@property (nonatomic, copy) NSString *download;

+ (instancetype)appInfoWithDict:(NSDictionary *)dict;
///  从 Plist 加载 AppInfo
+ (NSArray *)appList;

@end
```

```objc
+ (instancetype)appInfoWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];

    [obj setValuesForKeysWithDictionary:dict];

    return obj;
}

///  从 Plist 加载 AppInfo
+ (NSArray *)appList {

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"apps.plist" withExtension:nil];
    NSArray *array = [NSArray arrayWithContentsOfURL:url];

    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];

    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [arrayM addObject:[self appInfoWithDict:obj]];
    }];

    return arrayM.copy;
}
```

### 视图控制器数据

```objc
///  应用程序列表
@property (nonatomic, strong) NSArray *appList;
```

* 懒加载

```objc
- (NSArray *)appList {
    if (_appList == nil) {
        _appList = [AppInfo appList];
    }
    return _appList;
}
```

## 表格数据源方法

```objc
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell"];

    // 设置 Cell...
    AppInfo *app = self.appList[indexPath.row];

    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;

    return cell;
}
```

## 知识点

1. 数据模型应该负责所有数据准备工作，在需要时被调用
2. 数据模型不需要关心被谁调用
3. 数组使用
    * `[NSMutableArray arrayWithCapacity:array.count];` 的效率更高
    * 使用块代码遍历的效率比 for 要快
4. `@"AppCell"` 格式定义的字符串是保存在常量区的
5. 在 OC 中，懒加载是无处不在的
    * 设置 `cell` 内容时如果没有指定图像，择不会创建 `imageView`

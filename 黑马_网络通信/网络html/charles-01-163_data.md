# 拦截网易新闻数据

| 分类 | URL |
| -- | -- |
| 新闻首页 | http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html |
| 科技 | http://c.m.163.com/nc/article/list/T1348649580692/0-20.html |
| 手机 | http://c.m.163.com/nc/article/list/T1348649654285/0-20.html |
| 移动互联 | http://c.m.163.com/nc/article/list/T1351233117091/0-20.html |
| 首页广告 | http://c.m.163.com/nc/ad/headline/0-4.html |

## 网络访问

### 建立网络访问单例

```objc
+ (instancetype)sharedManager {
    static NetworkTools *instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        // 注意：baseURL 应该以 / 结尾
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/article/headline/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];

        instance = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:config];

    return instance;
}
```

### 加载新闻首页数据

```objc
- (void)loadData {
    [[NetworkTools sharedManager] GET:@"T1348647853363/0-20.html" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"%@ %@", responseObject, [responseObject class]);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
```

> 运行测试，statecode == 200，但是不支持数据格式 "text/html"

### 扩展反序列化格式类型

* 在 `NetworkTools` 单例中，扩展反序列化格式类型

```objc
instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
```

## 字典转模型

### 字典使用技巧 － 取第一个键值内容

```objc
// 直接取出字典中第一个 key T1348647853363 对应的数组
NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
NSLog(@"%@", array);
```

### 新闻模型

#### .h

```objc
///  标题
@property (nonatomic, copy) NSString *title;
///  摘要
@property (nonatomic, copy) NSString *digest;
///  配图地址
@property (nonatomic, copy) NSString *imgsrc;

+ (instancetype)newsWithDict:(NSDictionary *)dict;
```

#### .m

```objc
+ (instancetype)newsWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];

    [obj setValuesForKeysWithDictionary:dict];

    return obj;
}
```

### 字典转模型

```objc
NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];

[array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [arrayM addObject:[News newsWithDict:obj]];
}];

NSLog(@"%@", arrayM);
```

> 运行测试－崩溃

* 因为网络字典中的属性键值比 News 模型中的属性多，直接使用 `setValuesForKeysWithDictionary` 方法会崩溃

### 修改新闻模型

```objc
+ (instancetype)newsWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];

    NSArray *properties = [self properties];
    for (NSString *key in properties) {
        if (dict[key] != nil) {
            [obj setValue:dict[key] forKey:key];
        }
    }

    return obj;
}

+ (NSArray *)properties {
    return @[@"title", @"digest", @"imgsrc"];
}
```

#### 增加 description

```objc
- (NSString *)description {
    NSDictionary *dict = [self dictionaryWithValuesForKeys:[News properties]];

    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, dict];
}
```

### 利用运行时动态获取类属性

```objc
const char* propertiesKey = "propertiesKey";

+ (NSArray *)properties {
    NSMutableArray *arrayM = objc_getAssociatedObject(self, propertiesKey);
    if (arrayM != nil) {
        NSLog(@"返回关联数组");
        return arrayM;
    }

    NSLog(@"动态获取类属性");

    unsigned int count = 0;
    objc_property_t *ptys = class_copyPropertyList([self class], &count);

    arrayM = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; ++i) {
        objc_property_t pty = ptys[i];
        const char* cname = property_getName(pty);
        [arrayM addObject:[NSString stringWithUTF8String:cname]];
    }

    free(ptys);

    objc_setAssociatedObject(self, propertiesKey, arrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    return arrayM;
}
```

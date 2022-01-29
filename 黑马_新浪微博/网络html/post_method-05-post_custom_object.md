# POST自定义对象

## Person 对象

### 接口文件

```objc
@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;

+ (instancetype)personWithDict:(NSDictionary *)dict;
@end
```

### 实现文件

```objc
@interface Person() {
    float _height;
}

@property (nonatomic, copy) NSString *title;
@end

@implementation Person

+ (instancetype)personWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];

    [obj setValuesForKeysWithDictionary:dict];

    return obj;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _title = @"BOSS";
        _height = 1.5;
    }
    return self;
}
```

## POST 自定义对象

```objc
- (void)postPerson {

    id obj = [self.person dictionaryWithValuesForKeys:@[@"name", @"age", @"title", @"height"]];

    if (![NSJSONSerialization isValidJSONObject:obj]) {
        NSLog(@"数据格式不正确");
        return;
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:NULL];
    [self postJSON:data];
}
```

## KVC

* `KVC` 间接给对象属性设置数值的方法，被称为 cocoa 的大招！
* 字典转模型
    * `setValuesForKeysWithDictionary`
* 模型转字典
    * `dictionaryWithValuesForKeys`
* 在 iOS 中，核心动画是 KVC 的典型应用

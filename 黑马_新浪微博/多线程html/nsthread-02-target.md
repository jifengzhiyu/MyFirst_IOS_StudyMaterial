# NSThread 的 Target

* `NSThread` 的实例化方法中的 `target` 指的是开启线程后，在线程中执行 `哪一个对象` 的 `@selector` 方法

## 代码演练

* 准备对象

```objc
@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@end

@implementation Person

+ (instancetype)personWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];

    [obj setValuesForKeysWithDictionary:dict];

    return obj;
}

- (void)longOperation:(id)obj {
    NSLog(@"%@ - %@ - %@", [NSThread currentThread], self.name, obj);
}

@end
```

* 定义属性

```objc
@property (nonatomic, strong) Person *person;
```

* 懒加载

```objc
- (Person *)person {
    if (_person == nil) {
        _person = [Person personWithDict:@{@"name": @"zhangsan"}];
    }
    return _person;
}
```

### 三种线程调度方法

* alloc / init

```objc
NSThread *thread = [[NSThread alloc] initWithTarget:self.person selector:@selector(longOperation:) object:@"THREAD"];

[thread start];
```

* detach

```objc
[NSThread detachNewThreadSelector:@selector(longOperation:) toTarget:self.person withObject:@"DETACH"];
```

* 分类方法

```objc
[self.person performSelectorInBackground:@selector(longOperation:) withObject:@"PERFORM"];
```

#### 代码小结

* 通过指定不同的 `target` 会在后台线程执行该对象的 `@selector` 方法
* 提示：不要看见 `target` 就写 `self`
* `performSelectorInBackground` 可以让方便地在后台线程执行任意 `NSObject` 对象的方法

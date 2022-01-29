# 位移枚举

* 位移枚举是非常古老的 C 语言技巧
* `按位与` 如果都是 1 结果就是1
* `按位或` 如果都是 0 结果就是0

## 演练

* 定义枚举类型

```objc
/// 操作类型枚举
typedef enum {
    ActionTypeTop       = 1 << 0,
    ActionTypeBottom    = 1 << 1,
    ActionTypeLeft      = 1 << 2,
    ActionTypeRight     = 1 << 3
} ActionType;
```

* 方法目标
    * 根据操作类型参数，做出不同的响应
    * 操作类型可以任意组合

* 方法实现

```objc
- (void)action:(ActionType)type {

    if (type == 0) {
        NSLog(@"无操作");
        return;
    }

    if (type & ActionTypeTop) {
        NSLog(@"Top %tu", type & ActionTypeTop);
    }
    if (type & ActionTypeBottom) {
        NSLog(@"Bottom %tu", type & ActionTypeBottom);
    }
    if (type & ActionTypeLeft) {
        NSLog(@"Left %tu", type & ActionTypeLeft);
    }
    if (type & ActionTypeRight) {
        NSLog(@"Right %tu", type & ActionTypeRight);
    }
}
```

* 方法调用

```objc
ActionType type = ActionTypeTop | ActionTypeRight;
[self action:type];
```

## 代码小结

* 使用 `按位或` 可以给一个参数同时设置多个 `类型`
* 在具体执行时，使用 `按位与` 可以判断具体的 `类型`
* 通过位移设置，就能够得到非常多的组合！
* 对于位移枚举类型，如果`传入 0`，表示什么附加操作都不做，通常执行效率是最高的
* 如果开发中，看到位移的枚举，同时不要做任何的附加操作，参数可以直接输入 0！

## iOS 特有语法

* iOS 5.0之后，提供了新的枚举定义方式
* 定义枚举的同时，指定枚举中数据的类型
* `typedef NS_OPTIONS(NSUInteger, NSJSONReadingOptions)`
    * 位移枚举，可以使用 `按位或` 设置数值
* `typedef NS_ENUM(NSInteger, UITableViewStyle)`
    * 数字枚举，直接使用枚举设置数值

```objc
typedef NS_OPTIONS(NSUInteger, ActionType) {
    ActionTypeTop       = 1 << 0,
    ActionTypeBottom    = 1 << 1,
    ActionTypeLeft      = 1 << 2,
    ActionTypeRight     = 1 << 3
};
```


# 原子属性

* 原子属性（线程安全），是针对多线程设计的，是默认属性
* 多个线程在写入原子属性时（调用 `setter` 方法），能够保证同一时间只有一个线程执行写入操作
* 原子属性是一种`单(线程)写多(线程)读`的多线程技术
* `原子属性的效率比互斥锁高`，不过可能会出现`脏数据`
* 在定义属性时，必须显示地指定 `nonatomic`

## 代码演练

* 定义属性

```objc
@property (nonatomic, strong) NSObject *obj1;
@property (atomic, strong) NSObject *obj2;
@property (nonatomic, strong) NSObject *obj3;
```

* 模拟原子属性

```objc
@synthesize obj3 = _obj3;
- (void)setObj3:(NSObject *)obj3 {
    @synchronized(self) {
        _obj3 = obj3;
    }
}

- (NSObject *)obj3 {
    return _obj3;
}

* 性能测试

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    int largeNumber = 1000 * 10000;

    NSLog(@"非原子属性");
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < largeNumber; i++) {
        self.obj1 = [[NSObject alloc] init];
    }
    NSLog(@"%f", CFAbsoluteTimeGetCurrent() - start);

    NSLog(@"原子属性");
    start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < largeNumber; i++) {
        self.obj2 = [[NSObject alloc] init];
    }
    NSLog(@"%f", CFAbsoluteTimeGetCurrent() - start);

    NSLog(@"模拟原子属性");
    start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < largeNumber; i++) {
        self.obj3 = [[NSObject alloc] init];
    }
    NSLog(@"%f", CFAbsoluteTimeGetCurrent() - start);
}

```

> 原子属性内部的锁是`自旋锁`，**自旋锁的执行效率比互斥锁高**

## 自旋锁 & 互斥锁

* 共同点
    * 都能够保证同一时间，只有一条线程执行锁定范围的代码

* 不同点
    * `互斥锁`：如果发现有其他线程正在执行锁定的代码，线程会`进入休眠状态`，等待其他线程执行完毕，打开锁之后，线程会被`唤醒`
    * `自旋锁`：如果发现有其他线程正在执行锁定的代码，线程会以`死循环`的方式，一直等待锁定代码执行完成

* 结论
    * 自旋锁更适合执行非常短的代码
    * 无论什么锁，都是要付出代价

## 线程安全

* 多个线程进行读写操作时，仍然能够得到正确结果，被称为线程安全
* 要实现线程安全，必须要用到`锁`
* 为了得到更佳的用户体验，`UIKit 不是线程安全的`

> 约定：所有更新 UI 的操作都必须主线程上执行！

* 因此，`主线程`又被称为`UI 线程`

## iOS 开发建议

1. 所有属性都声明为 `nonatomic`
2. 尽量避免多线程抢夺同一块资源
3. 尽量将加锁、资源抢夺的业务逻辑交给服务器端处理，减小移动客户端的压力



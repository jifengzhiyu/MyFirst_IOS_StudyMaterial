# 线程属性

## 代码演练

```objc
// MARK: - 线程属性
- (void)threadProperty {
    NSThread *t1 = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];

    // 1. 线程名称
    t1.name = @"Thread AAA";
    // 2. 优先级
    t1.threadPriority = 0;

    [t1 start];

    NSThread *t2 = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];

    // 1. 线程名称
    t2.name = @"Thread BBB";
    // 2. 优先级
    t2.threadPriority = 1;

    [t2 start];
}

- (void)demo {
    for (int i = 0; i < 10; ++i) {
        // 堆栈大小
        NSLog(@"%@ 堆栈大小：%tuK", [NSThread currentThread], [NSThread currentThread].stackSize / 1024);
    }

    // 模拟崩溃
    // 判断是否是主线程
//    if (![NSThread currentThread].isMainThread) {
//        NSMutableArray *a = [NSMutableArray array];
//
//        [a addObject:nil];
//    }
}
```

## 属性

### 1. `name` - 线程名称

* 在大的商业项目中，通常需要在程序崩溃时，获取程序准确执行所在的线程

### 2. `threadPriority` - 线程优先级

* 优先级，是一个浮点数，取值范围从 `0~1.0`
    * `1.0`表示优先级最高
    * `0.0`表示优先级最低
    * 默认优先级是`0.5`
* 优先级高只是保证 CPU 调度的可能性会高
* 刀哥个人建议，在开发的时候，不要修改优先级
* 多线程的目的：是将耗时的操作放在后台，不阻塞主线程和用户的交互！
* 多线程开发的原则：简单

### 3. `stackSize` - 栈区大小

* 默认情况下，无论是主线程还是子线程，栈区大小都是 `512K`
* 栈区大小可以设置

```objc
[NSThread currentThread].stackSize = 1024 * 1024;
```

### 4. `isMainThread` - 是否主线程


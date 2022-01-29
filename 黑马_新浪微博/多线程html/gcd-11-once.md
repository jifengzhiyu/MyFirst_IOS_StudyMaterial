# 一次性执行

> 有的时候，在程序开发中，有些代码只想从程序启动就只执行一次，典型的应用场景就是“单例”

```objc
// MARK: 一次性执行
- (void)once {
    static dispatch_once_t onceToken;
    NSLog(@"%ld", onceToken);

    dispatch_once(&onceToken, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"一次性吗?");
    });
    NSLog(@"come here");
}
```

* dispatch 内部也有一把锁，是能够保证"线程安全"的！而且是苹果公司推荐使用的
* 以下代码用于测试多线程的一次性执行

```objc
- (void)demoOnce {
    for (int i = 0; i < 10; ++i) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self once];
        });
    }
}
```

## 单例测试

### 单例的特点

1. 在内存中只有一个实例
2. 提供一个全局的访问点

### 单例实现

```objc
// 使用 dispatch_once 实现单例
+ (instancetype)sharedSingleton {
    static id instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}

// 使用互斥锁实现单例
+ (instancetype)sharedSync {
    static id syncInstance;

    @synchronized(self) {
        if (syncInstance == nil) {
            syncInstance = [[self alloc] init];
        }
    }

    return syncInstance;
}
```

> 面试时只要实现上面 `sharedSingleton` 方法即可

### 单例测试

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    long largeNumber = 1000 * 1000;

    // 测试互斥锁
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    for (long i = 0; i < largeNumber; ++i) {
        [Singleton sharedSync];
    }
    NSLog(@"互斥锁： %f", CFAbsoluteTimeGetCurrent() - start);

    // 测试 dispatch_once
    start = CFAbsoluteTimeGetCurrent();
    for (long i = 0; i < largeNumber; ++i) {
        [Singleton sharedSingleton];
    }
    NSLog(@"dispatch_once： %f", CFAbsoluteTimeGetCurrent() - start);
}
```

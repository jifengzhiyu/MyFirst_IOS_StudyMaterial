# 主队列

## 特点

* 专门用来在主线程上调度任务的队列
* 不会开启线程
* 以`先进先出`的方式，在`主线程空闲时`才会调度队列中的任务在主线程执行
* **如果当前主线程正在有任务执行，那么无论主队列中当前被添加了什么任务，都不会被调度**

## 队列获取

* 主队列是负责在主线程调度任务的
* 会随着程序启动一起创建
* 主队列只需要获取不用创建

```objc
dispatch_queue_t queue = dispatch_get_main_queue();
```

## 主队列演练

* 主队列，异步执行

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self gcdDemo1];

    [NSThread sleepForTimeInterval:1];
    NSLog(@"over");
}

- (void)gcdDemo1 {

    dispatch_queue_t queue = dispatch_get_main_queue();

    for (int i = 0; i < 10; ++i) {
        dispatch_async(queue, ^{
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        });
        NSLog(@"---> %d", i);
    }

    NSLog(@"come here");
}
```

> 在`主线程空闲时`才会调度队列中的任务在主线程执行

* 主队列，同步执行

```objc
// MARK: 主队列，同步任务
- (void)gcdDemo6 {
    // 1. 队列
    dispatch_queue_t q = dispatch_get_main_queue();

    NSLog(@"!!!");

    // 2. 同步
    dispatch_sync(q, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });

    NSLog(@"come here");
}
```

> `主队列`和`主线程`相互等待会造成死锁



# 同步任务的作用

> 同步任务，可以让其他异步执行的任务，`依赖`某一个同步任务

例如：在用户登录之后，再异步下载文件！

```objc
- (void)gcdDemo1 {
    dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_sync(queue, ^{
        NSLog(@"登录 %@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"下载 A %@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"下载 B %@", [NSThread currentThread]);
    });
}
```

* 代码改造，让登录也在异步执行

```objc
- (void)gcdDemo2 {
    dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", DISPATCH_QUEUE_CONCURRENT);

    void (^task)() = ^{
        dispatch_sync(queue, ^{
            NSLog(@"登录 %@", [NSThread currentThread]);
        });

        dispatch_async(queue, ^{
            NSLog(@"下载 A %@", [NSThread currentThread]);
        });

        dispatch_async(queue, ^{
            NSLog(@"下载 B %@", [NSThread currentThread]);
        });
    };

    dispatch_async(queue, task);
}
```

* 主队列调度同步队列不死锁

```objc
- (void)gcdDemo3 {

    dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", DISPATCH_QUEUE_CONCURRENT);

    void (^task)() = ^ {
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"死？");
        });
    };

    dispatch_async(queue, task);
}
```

> 主队列在`主线程空闲时`才会调度队列中的任务在主线程执行

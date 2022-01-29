# 并发队列

## 特点

* 以`先进先出`的方式，`并发`调度队列中的任务执行
* 如果当前调度的任务是`同步`执行的，会等待任务执行完成后，再调度后续的任务
* 如果当前调度的任务是`异步`执行的，**同时底层线程池有可用的线程资源**，会再新的线程调度后续任务的执行

## 队列创建

```objc
dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", DISPATCH_QUEUE_CONCURRENT);
```

## 并发队列演练

* 并发队列 异步执行

```objc
/**
 提问：是否开线程？是否顺序执行？come here 的位置？
 */
- (void)gcdDemo3 {

    // 1. 队列
    dispatch_queue_t q = dispatch_queue_create("itheima", DISPATCH_QUEUE_CONCURRENT);

    // 2. 执行任务
    for (int i = 0; i < 10; ++i) {
        dispatch_async(q, ^{
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        });
    }

    NSLog(@"come here");
}
```

* 并发队列 同步执行

```objc
/**
 提问：是否开线程？是否顺序执行？come here 的位置？
 */
- (void)gcdDemo4 {

    // 1. 队列
    dispatch_queue_t q = dispatch_queue_create("itheima", DISPATCH_QUEUE_CONCURRENT);

    // 2. 执行任务
    for (int i = 0; i < 10; ++i) {
        dispatch_sync(q, ^{
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        });
        NSLog(@"---> %i", i);
    }

    NSLog(@"come here");
}
```


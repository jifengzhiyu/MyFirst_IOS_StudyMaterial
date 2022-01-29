# 串行队列

## 特点

* 以`先进先出`的方式，`顺序`调度队列中的任务执行
* **无论队列中所指定的执行任务函数是同步还是异步，都会等待前一个任务执行完成后，再调度后面的任务**

## 队列创建

```objc
dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", DISPATCH_QUEUE_SERIAL);

dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", NULL);
```

## 串行队列演练

* 串行队列 同步执行

```objc
/**
 提问：是否开线程？是否顺序执行？come here 的位置？
 */
- (void)gcdDemo1 {
    // 1. 队列
    dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", DISPATCH_QUEUE_SERIAL);

    // 2. 执行任务
    for (int i = 0; i < 10; ++i) {
        NSLog(@"--- %d", i);

        dispatch_sync(q, ^{
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        });
    }

    NSLog(@"come here");
}
```

* 串行队列 异步执行

```objc
/**
 提问：是否开线程？是否顺序执行？come here 的位置？
 */
- (void)gcdDemo2 {
    // 1. 队列
    dispatch_queue_t q = dispatch_queue_create("itheima", NULL);

    // 2. 执行任务
    for (int i = 0; i < 10; ++i) {
        NSLog(@"--- %@ %d", [NSThread currentThread], i);

        dispatch_async(q, ^{
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        });
    }

    NSLog(@"come here");
}
```

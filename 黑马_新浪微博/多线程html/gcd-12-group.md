# 调度组

## 常规用法

```objc
- (void)group1 {

    // 1. 调度组
    dispatch_group_t group = dispatch_group_create();

    // 2. 队列
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);

    // 3. 将任务添加到队列和调度组
    dispatch_group_async(group, q, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"任务 1 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 2 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 3 %@", [NSThread currentThread]);
    });

    // 4. 监听所有任务完成
    dispatch_group_notify(group, q, ^{
        NSLog(@"OVER %@", [NSThread currentThread]);
    });

    // 5. 判断异步
    NSLog(@"come here");
}
```

## enter & leavel

```objc
// MARK: - 调度组 2
- (void)group2 {
    // 1. 调度组
    dispatch_group_t group = dispatch_group_create();

    // 2. 队列
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);

    // dispatch_group_enter & dispatch_group_leave 必须成对出现
    dispatch_group_enter(group);
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 1 %@", [NSThread currentThread]);

        // dispatch_group_leave 必须是 block 的最后一句
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 2 %@", [NSThread currentThread]);

        // dispatch_group_leave 必须是 block 的最后一句
        dispatch_group_leave(group);
    });

    // 4. 阻塞式等待调度组中所有任务执行完毕
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

    // 5. 判断异步
    NSLog(@"OVER %@", [NSThread currentThread]);
}
```

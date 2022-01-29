# 延迟操作

```objc
// MARK: - 延迟执行
- (void)delay {
    /**
     从现在开始，经过多少纳秒，由"队列"调度异步执行 block 中的代码

     参数
     1. when    从现在开始，经过多少纳秒
     2. queue   队列
     3. block   异步执行的任务
     */
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    void (^task)() = ^ {
        NSLog(@"%@", [NSThread currentThread]);
    };
    // 主队列
//    dispatch_after(when, dispatch_get_main_queue(), task);
    // 全局队列
//    dispatch_after(when, dispatch_get_global_queue(0, 0), task);
    // 串行队列
    dispatch_after(when, dispatch_queue_create("itheima", NULL), task);

    NSLog(@"come here");
}

- (void)after {
    [self.view performSelector:@selector(setBackgroundColor:) withObject:[UIColor orangeColor] afterDelay:1.0];

    NSLog(@"come here");
}
```

# 线程状态

## 线程状态

* `新建`
    * 实例化线程对象
* `就绪`
    * 向线程对象发送 `start` 消息，线程对象被加入 `可调度线程池` 等待 CPU 调度
    * `detach` 方法和 `performSelectorInBackground` 方法会直接实例化一个线程对象并加入 `可调度线程池`
* `运行`
    * CPU 负责调度`可调度线程池`中线程的执行
    * 线程执行完成之前，状态可能会在`就绪`和`运行`之间来回切换
    * `就绪`和`运行`之间的状态变化由 CPU 负责，程序员不能干预
* `阻塞`
    * 当满足某个预定条件时，可以使用休眠或锁阻塞线程执行
        * `sleepForTimeInterval`：休眠指定时长
        * `sleepUntilDate`：休眠到指定日期
        * `@synchronized(self)`：乎斥锁
* `死亡`
    * 正常死亡
        * 线程执行完毕
    * 非正常死亡
        * 当满足某个条件后，在线程内部中止执行
        * 当满足某个条件后，在主线程中止线程对象

## 代码演练

```objc
- (void)statusDemo {

    NSLog(@"先睡会");
    [NSThread sleepForTimeInterval:1.0];

    for (int i = 0; i < 20; i++) {
        if (i == 9) {
            NSLog(@"再睡会");
            [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        }

        NSLog(@"%d %@", i, [NSThread currentThread]);

        if (i == 16) {
            NSLog(@"88");
            // 终止线程之前，需要记住释放资源
            [NSThread exit];
        }
    }
    NSLog(@"over");
}
```

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 注意不要在主线程上调用 exit 方法
//    [NSThread exit];

    // 实例化线程对象(新建)
    NSThread *t = [[NSThread alloc] initWithTarget:self selector:@selector(statusDemo) object:nil];

    // 线程就绪(被添加到可调度线程池中)
    [t start];
}
```

### 代码小结

#### 阻塞

* 方法执行过程，符合某一条件时，可以利用 `sleep` 方法让线程进入 `阻塞` 状态

    - `sleepForTimeInterval` 从现在起睡多少`秒`
    - `sleepUntilDate` 从现在起睡到指定的日期

#### 死亡

```objc
[NSThread exit];
```

* 一旦强行终止线程，后续的所有代码都不会被执行
* **注意：在终止线程之前，应该注意释放之前分配的对象！**

> 注意：线程从`就绪`和`运行`状态之间的切换是由 `CPU` 负责的，程序员无法干预


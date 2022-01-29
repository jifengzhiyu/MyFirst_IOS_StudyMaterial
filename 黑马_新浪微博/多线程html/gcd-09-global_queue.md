# 全局队列

* 是系统为了方便程序员开发提供的，其工作表现与`并发队列`一致

## 全局队列 & 并发队列的区别

* 全局队列
    * 没有名称
    * 无论 MRC & ARC 都不需要考虑释放
    * 日常开发中，建议使用"全局队列"
* 并发队列
    * 有名字，和 `NSThread` 的 `name` 属性作用类似
    * 如果在 MRC 开发时，需要使用 `dispatch_release(q);` 释放相应的对象
    * `dispatch_barrier` 必须使用自定义的并发队列
    * 开发第三方框架时，建议使用并发队列

## 全局队列 异步任务

```objc
/**
 提问：是否开线程？是否顺序执行？come here 的位置？
 */
- (void)gcdDemo8 {
    // 1. 队列
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);

    // 2. 执行任务
    for (int i = 0; i < 10; ++i) {
        dispatch_async(q, ^{
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        });
    }

    NSLog(@"come here");
}
```

> 运行效果与并发队列相同

## 参数

1. 服务质量(队列对任务调度的优先级)/iOS 7.0 之前，是优先级
    - iOS 8.0(新增，暂时不能用，今年年底)
        - `QOS_CLASS_USER_INTERACTIVE` 0x21, 用户交互(希望最快完成－不能用太耗时的操作)
        - `QOS_CLASS_USER_INITIATED` 0x19, 用户期望(希望快，也不能太耗时)
        - `QOS_CLASS_DEFAULT` 0x15, 默认(用来底层重置队列使用的，不是给程序员用的)
        - `QOS_CLASS_UTILITY` 0x11, 实用工具(专门用来处理耗时操作！)
        - `QOS_CLASS_BACKGROUND` 0x09, 后台
        - `QOS_CLASS_UNSPECIFIED` 0x00, 未指定，可以和iOS 7.0 适配
    - iOS 7.0
        - `DISPATCH_QUEUE_PRIORITY_HIGH` 2 高优先级
        - `DISPATCH_QUEUE_PRIORITY_DEFAULT` 0 默认优先级
        - `DISPATCH_QUEUE_PRIORITY_LOW` (-2) 低优先级
        - `DISPATCH_QUEUE_PRIORITY_BACKGROUND` INT16_MIN 后台优先级

2. 为未来保留使用的，应该永远传入0

> 结论：如果要适配 iOS 7.0 & 8.0，使用以下代码：
`dispatch_get_global_queue(0, 0);`

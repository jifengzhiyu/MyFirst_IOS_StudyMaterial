# 基本演练

## NSInvocationOperation

### start

* `start` 方法 会在当前线程执行 `@selector` 方法

```objc
- (void)opDemo1 {
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"Invocation"];

    // start方法 会在当前线程执行 @selector 方法
    [op start];
}

- (void)downloadImage:(id)obj {

    NSLog(@"%@ %@", [NSThread currentThread], obj);
}
```

### 添加到队列

* 将操作添加到队列，会"异步"执行 `selector` 方法

```objc
- (void)opDemo2 {
    NSOperationQueue *q = [[NSOperationQueue alloc] init];

    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"queue"];

    [q addOperation:op];
}
```

### 添加多个操作

```objc
- (void)opDemo3 {
    NSOperationQueue *q = [[NSOperationQueue alloc] init];

    for (int i = 0; i < 10; ++i) {
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@(i)];

        [q addOperation:op];
    }
}
```

> 执行效果：会开启多条线程，而且不是顺序执行。与GCD中并发队列&异步执行效果一样！

结论，在 NSOperation 中：

* 操作 -> 异步执行的任务
* 队列 -> 全局队列

## NSBlockOperation

```objc
- (void)opDemo4 {
    NSOperationQueue *q = [[NSOperationQueue alloc] init];

    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];

    [q addOperation:op];
}
```

> 使用 block 来定义操作，所有的代码写在一起，更简单，便于维护！

## 更简单的，直接添加 Block

```objc
- (void)opDemo5 {
    NSOperationQueue *q = [[NSOperationQueue alloc] init];

    for (int i = 0; i < 10; ++i) {
        [q addOperationWithBlock:^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        }];
    }
}
```

## 向队列中添加不同的操作

```objc
- (void)opDemo5 {
    NSOperationQueue *q = [[NSOperationQueue alloc] init];

    for (int i = 0; i < 10; ++i) {
        [q addOperationWithBlock:^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        }];
    }

    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"block %@", [NSThread currentThread]);
    }];
    [q addOperation:op1];

    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"invocation"];
    [q addOperation:op2];
}
```

* 可以向 `NSOperationQueue` 中添加任意 `NSOperation` 的子类

## 线程间通讯

```objc
- (void)opDemo6 {
    NSOperationQueue *q = [[NSOperationQueue alloc] init];

    [q addOperationWithBlock:^{
        NSLog(@"耗时操作 %@", [NSThread currentThread]);

        // 主线程更新 UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"更新 UI %@", [NSThread currentThread]);
        }];
    }];
}
```

# 创建线程的方式

* 准备在后台线程调用的方法 `longOperation:`

```objc
- (void)longOperation:(id)obj {
    NSLog(@"%@ - %@", [NSThread currentThread], obj);
}
```

## 方式1：alloc / init - start

```objc
- (void)threadDemo1 {
    NSLog(@"before %@", [NSThread currentThread]);

    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(longOperation:) object:@"THREAD"];

    [thread start];

    NSLog(@"after %@", [NSThread currentThread]);
}
```

### 代码小结

* `[thread start];`执行后，会在另外一个线程执行 `longOperation:` 方法
* 在 OC 中，任何一个方法的代码都是从上向下顺序执行的
* 同一个方法内的代码，都是在相同线程执行的(`block`除外)

## 方式2：detachNewThreadSelector

```objc
- (void)threadDemo2 {
    NSLog(@"before %@", [NSThread currentThread]);

    [NSThread detachNewThreadSelector:@selector(longOperation:) toTarget:self withObject:@"DETACH"];

    NSLog(@"after %@", [NSThread currentThread]);
}
```

### 代码小结

* `detachNewThreadSelector` 类方法不需要启动，会自动创建线程并执行 `@selector` 方法

## 方式3：分类方法

```objc
- (void)threadDemo3 {
    NSLog(@"before %@", [NSThread currentThread]);

    [self performSelectorInBackground:@selector(longOperation:) withObject:@"PERFORM"];

    NSLog(@"after %@", [NSThread currentThread]);
}
```

### 代码小结

* `performSelectorInBackground` 是 `NSObject` 的分类方法
* 会自动在后台线程执行 `@selector` 方法
* 没有 `thread` 字眼，`隐式`创建并启动线程
* 所有 `NSObject` 都可以使用此方法，在其他线程执行方法



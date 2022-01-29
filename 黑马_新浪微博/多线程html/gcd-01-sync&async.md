# 同步 & 异步

## 概念

* 同步
    * 必须等待当前语句执行完毕，才会执行下一条语句
* 异步
    * 不用等待当前语句执行完毕，就可以执行下一条语句

## `NSThread` 中的 `同步` & `异步`

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"start");

    // 同步执行
//    [self demo];
    // 异步执行
    [self performSelectorInBackground:@selector(demo) withObject:nil];

    NSLog(@"over");
}

- (void)demo {

    NSLog(@"%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:1.0];
    NSLog(@"demo 完成");
}
```

### 代码小结

* `同步` 从上到下顺序执行
* `异步` 是`多线程的代名词`

# 资源共享

# 资源共享-卖票

多线程开发的复杂度相对较高，在开发时可以按照以下套路编写代码：

1. 首先确保单个线程执行正确
2. 添加线程

## 卖票逻辑
```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tickets = 20;

    [self saleTickets];
}

/// 卖票逻辑 - 每一个售票逻辑(窗口)应该把所有的票卖完
- (void)saleTickets {
    while (YES) {
        if (self.tickets > 0) {
            self.tickets--;
            NSLog(@"剩余票数 %d %@", self.tickets, [NSThread currentThread]);
        } else {
            NSLog(@"没票了 %@", [NSThread currentThread]);
            break;
        }
    }
}
```

## 添加线程

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tickets = 20;

    NSThread *t1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets) object:nil];
    t1.name = @"售票员 A";
    [t1 start];

    NSThread *t2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets) object:nil];
    t2.name = @"售票员 B";
    [t2 start];
}
```

### 添加休眠

```objc
- (void)saleTickets {
    while (YES) {
        // 模拟休眠
        [NSThread sleepForTimeInterval:1.0];

        if (self.tickets > 0) {
            self.tickets--;
            NSLog(@"剩余票数 %d %@", self.tickets, [NSThread currentThread]);
        } else {
            NSLog(@"没票了 %@", [NSThread currentThread]);
            break;
        }
    }
}
```

> 运行测试结果

## 互斥锁

### 添加互斥锁

```objc
- (void)saleTickets {

    while (YES) {
        [NSThread sleepForTimeInterval:1.0];

        @synchronized(self) {
            if (self.tickets > 0) {
                self.tickets--;
                NSLog(@"剩余票数 %d %@", self.tickets, [NSThread currentThread]);
                continue;
            }
        }

        NSLog(@"没票了 %@", [NSThread currentThread]);
        break;
    }
}
```

### 互斥锁小结

1. 保证锁内的代码，同一时间，只有一条线程能够执行！
2. 互斥锁的锁定范围，应该尽量小，锁定范围越大，效率越差！
3. 速记技巧 `[[NSUserDefaults standardUserDefaults] synchronize];`

#### 互斥锁参数

1. 能够加锁的任意 `NSObject` 对象
2. **注意：锁对象一定要保证所有的线程都能够访问**
3. 如果代码中只有一个地方需要加锁，大多都使用 `self`，这样可以避免单独再创建一个锁对象


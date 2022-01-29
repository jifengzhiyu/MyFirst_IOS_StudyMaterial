# pthread

* `pthread` 是 `POSIX` 多线程开发框架，由于是跨平台的 C 语言框架，在苹果的头文件中并没有详细的注释
* 要查阅 `pthread` 有关资料，可以访问 http://baike.baidu.com

## 导入头文件

```objc
#import <pthread.h>
```

## pthread演练

```objc
// 创建线程，并且在线程中执行 demo 函数
- (void)pthreadDemo {

    /**
     参数：
     1> 指向线程标识符的指针，C 语言中类型的结尾通常 _t/Ref，而且不需要使用 *
     2> 用来设置线程属性
     3> 线程运行函数的起始地址
     4> 运行函数的参数

     返回值：
     - 若线程创建成功，则返回0
     - 若线程创建失败，则返回出错编号


     */
    pthread_t threadId = NULL;
    NSString *str = @"Hello Pthread";
    int result = pthread_create(&threadId, NULL, demo, (__bridge void *)(str));

    if (result == 0) {
        NSLog(@"创建线程 OK");
    } else {
        NSLog(@"创建线程失败 %d", result);
    }
}

// 后台线程调用函数
void *demo(void *params) {
    NSString *str = (__bridge NSString *)(params);

    NSLog(@"%@ - %@", [NSThread currentThread], str);

    return NULL;
}
```

## 小结

1. 在 C 语言中，没有`对象`的概念，对象是以`结构体`的方式来实现的
2. 通常，在 C 语言框架中，对象类型以 `_t/Ref` 结尾，而且声明时不需要使用 `*`
3. **C 语言中的 `void *` 和 OC 中的 `id` 是等价的**
4. 内存管理
    * 在 OC 中，如果是 `ARC` 开发，编译器会在编译时，根据代码结构，自动添加 `retain`/`release`/`autorelease`
    * 但是，`ARC` 只负责管理 `OC` 部分的内存管理，而不负责 `C 语言` 代码的内存管理
    * 因此，开发过程中，如果使用的 `C` 语言框架出现 `retain`/`create`/`copy`/`new` 等字样的函数，大多都需要 `release`，否则会出现内存泄漏
5. 在混合开发时，如果在 `C` 和 `OC` 之间传递数据，需要使用 `__bridge` 进行桥接，`桥接`的目的就是为了告诉编译器如何管理内存
6. 桥接的添加可以借助 Xcode 的辅助功能添加
7. `MRC` 中不需要使用桥接



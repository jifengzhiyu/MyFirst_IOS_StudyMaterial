//
//  ViewController.m
//  串行队列
//
//  Created by 翟佳阳 on 2021/12/21.
//

#import "ViewController.h"

/*
 * GCD中提供了全局队列
 * 但是，在第三方框架中，为了获取更大的灵活性，通常会自己创建队列
 */
/*属性会有相应的getter方法和setter方法，而成员变量没有，另外，外部访问属性可以用"."来访问，访问成员变量需要用"->"来访问
 */
@interface ViewController () {
    // 串行队列成员变量
    dispatch_queue_t _queue;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建串行队列
    _queue = dispatch_queue_create("com.itheima.queue", DISPATCH_QUEUE_SERIAL);
    
    [self demo];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 串行队列，同步执行不能嵌套使用
    //会互相等待，产生死锁
    dispatch_sync(_queue, ^{
        NSLog(@"come here");
        
        dispatch_sync(_queue, ^{
            NSLog(@"hehe");
        });
    });
}

/// 串行队列的演示
- (void)demo {
    for (int i = 0; i < 10; i++) {
        // 耗时的操作需要异步执行
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            // 数据库操作又需要保证同一时间，只能有一个操作！
            // `同步`执行 － 串行队列没有开线程的能力
            // 同步，能够做到，即使在异步执行所有的数据库操作任务，仍然能够保证顺序
            dispatch_sync(self->_queue, ^{
                NSLog(@"%@ %d", [NSThread currentThread], i);
            });
        });
    }
}
@end

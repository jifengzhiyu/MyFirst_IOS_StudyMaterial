//
//  ViewController.m
//  主队列
//
//  Created by 翟佳阳 on 2021/10/20.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self demo1];
    //[self demo2];
    [self demo3];
}

//主队列，异步执行
//有序，在主线程顺序执行
- (void)demo1{
    for (int i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"hi--%@--%d",[NSThread currentThread],i);
        });
    }
}

/*
//主队列，同步执行
报错
原因：1、先执行主线程上的代码，才会执行队列中的任务；
NSLog(@"hi--%@--%d",[NSThread currentThread],i);
 
2、 dispatch_sync(dispatch_get_main_queue(), ^{
NSLog(@"hi--%@--%d",[NSThread currentThread],i);
});
属于主线程上的代码，想要执行要等主线程上的代码结束
所以该语句永远都执行不了
 
即 死锁
 
 */

/*
 老师的话：
 主线程在等着同步执行
 同步执行等着第一个任务执行完
 第一个任务在主线程上
 */

/*
 又想了一下：
 这句话在主线程上
 这句话在等着这句话执行完
 （主队列特点）
 
 这句话第一次执行，也就是第一个任务执行才会执行下一个任务
 但是第一次永远无法执行，之后的任务也不会执行
 （同步执行特点）
 */
- (void)demo2{
    for (int i = 0; i < 10; i++) {
        //主队列同步执行，在主线程上 死锁
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"hi--%@--%d",[NSThread currentThread],i);
        });
    }
}

//解决死锁
- (void)demo3{
    NSLog(@"begin");

    
    //全局队列，异步执行（子线程执行
    //循环里面的同步执行就不要等待，因为它在子线程里面
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10; i++) {
            //主队列 任务，一定在主线程上执行
            //同步执行，执行在子线程上
            //这里不明白先算了，放一放估计就会了
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"hi--%@--%d",[NSThread currentThread],i);
            });
        }
    });
    NSLog(@"end");
}
@end

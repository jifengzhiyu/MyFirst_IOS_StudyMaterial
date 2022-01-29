//
//  ViewController.m
//  并行队列
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
    [self demo2];
}

//并行队列，同步执行
//== 穿行队列，同步执行
//不开线程，顺序执行
- (void)demo1{
    dispatch_queue_t queue = dispatch_queue_create("jf", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"hello--%@---%d",[NSThread currentThread],i);
        });
    }
}

//并行队列，异步执行
//有重用的线程（从线程池拿
//开多个线程，无序执行
- (void)demo2{
    dispatch_queue_t queue = dispatch_queue_create("jf", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"hello--%@---%d",[NSThread currentThread],i);
        });
    }
}
@end

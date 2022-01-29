//
//  ViewController.m
//  串行队列
//
//  Created by 翟佳阳 on 2021/10/19.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self demo1];
    //[self demo2];
}



//串行队列，同步执行
//不开新的线程（在当前线程上），任务按照顺序执行
- (void)demo1{
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("jf", DISPATCH_QUEUE_SERIAL);
    //一个队列，多个任务
    for (int i = 0; i < 10; i ++) {
        dispatch_sync(queue, ^{
            NSLog(@"hi---%d----%@",i,[NSThread currentThread]);
        });
    }
}

//串行队列，异步执行
//开启一个新线程，任务有序执行
- (void)demo2{
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("jf", DISPATCH_QUEUE_SERIAL);
    //一个队列，多个任务
    for (int i = 0; i < 10; i ++) {
        dispatch_async(queue, ^{
            NSLog(@"hi---%d----%@",i,[NSThread currentThread]);
        });
    }
}
@end

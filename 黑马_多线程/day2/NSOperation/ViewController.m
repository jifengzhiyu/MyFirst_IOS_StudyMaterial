//
//  ViewController.m
//  NSOperation
//
//  Created by 翟佳阳 on 2021/10/20.
//

//NSInvocationOperation
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self test1];
    [self test2];
    
}

//start法
- (void)test1{
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
        NSLog(@"%d",op.isFinished);
        //start更新操作的状态 ； 调用main方法
        //不会开启新线程
        //只调用一次
        [op start];
        [op start];
        [op start];
        NSLog(@"%d",op.isFinished);
}


//操作添加到队列
//创建一个新的线程
- (void)test2{
    //创建操作
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
    //队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //把操作添加到队列里
    //父类指针可以指向子类对象
    [queue addOperation:op];
}


- (void)demo{
    NSLog(@"hi--%@",[NSThread currentThread]);
}

@end

//
//  ViewController.m
//  NSBlockOperation
//
//  Created by 翟佳阳 on 2021/10/20.
//

#import "ViewController.h"

@interface ViewController ()
//相当于全局队列
@property (nonatomic, strong) NSOperationQueue *queue;


@end

@implementation ViewController

- (NSOperationQueue *)queue{
    if(_queue == nil){
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self demo1];
    //[self demo2];
//    [self demo3];
//    [self demo4];
    [self demo5];

}

//start法
- (void)demo1{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    //start更新操作的状态 ； 调用main方法
    //不会开启新线程
    //只调用一次
    [op start];
//    [op start];
//    [op start];

}

//操作添加到队列法
//创建一个新的线程
- (void)demo2{
    //创建操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    //队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //把操作添加到队列里
    [queue addOperation:op];
}


//demo2进化版
- (void)demo3{
    NSOperationQueue *que = [[NSOperationQueue alloc] init];
    [que addOperationWithBlock:^{
            NSLog(@"%@",[NSThread currentThread]);

    }];
}

//使用全局队列
- (void)demo4{
    //类似于GCD四种队列的：并发队列，异步执行
    for (int i = 0; i < 10; i++) {
        [self.queue addOperationWithBlock:^{
            NSLog(@"%@--%d",[NSThread currentThread],i);
        }];
    }
}

//NSOperation的方法completionBlock
//都在子线程执行
- (void)demo5{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"hi--%@",[NSThread currentThread]);
    }];
    
    [self.queue addOperation:op];

    
    [op setCompletionBlock:^{
            NSLog(@"end--%@",[NSThread currentThread]);
    }];
    
}

@end

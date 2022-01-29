//
//  ViewController.m
//  操作依赖
//
//  Created by 翟佳阳 on 2021/10/21.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *queue;


@end

@implementation ViewController
- (NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //下载--解压---升级
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1");
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op2");
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op3");
    }];
    
    //设置依赖
    //op2依赖 op1
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    //循环依赖的话，程序不执行，不报错
//    [op3 addDependency:op1];
    
    //操作添加到队列
    [self.queue addOperations:@[op1,op2] waitUntilFinished:NO];
    
    //依赖关系可以跨队列执行
    [[NSOperationQueue mainQueue] addOperation:op3];
}


@end

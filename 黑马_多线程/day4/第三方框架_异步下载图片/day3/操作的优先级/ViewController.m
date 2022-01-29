//
//  ViewController.m
//  操作的优先级
//
//  Created by 翟佳阳 on 2021/10/21.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *queue;


@end

@implementation ViewController
- (NSOperationQueue *)queue{
    if(_queue == nil){
        _queue = [NSOperationQueue new];
    }
    return _queue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //操作1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 200; i++) {
            NSLog(@"op1---%d",i);
        }
    }];
    //设置优先级最高（人机交互
    op1.qualityOfService = NSQualityOfServiceUserInteractive;
    [self.queue addOperation:op1];
    //等操作完成，执行在子线程上
    [op1 setCompletionBlock:^{
            NSLog(@"op1--end========%@",[NSThread currentThread]);
    }];
    
    
    
    //操作2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 200; i++) {
            NSLog(@"op2---%d",i);
        }
    }];
    //设置优先级最低
    op2.qualityOfService = NSQualityOfServiceBackground;
    [self.queue addOperation:op2];
    
    
}


@end

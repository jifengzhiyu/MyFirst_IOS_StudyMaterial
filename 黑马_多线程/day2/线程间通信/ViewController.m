//
//  ViewController.m
//  线程间通信
//
//  Created by 翟佳阳 on 2021/10/20.
//

#import "ViewController.h"

@interface ViewController ()
//创建全局队列
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
    
    [self.queue addOperationWithBlock:^{
            //异步下载图片
            NSLog(@"下载--%@",[NSThread currentThread]);
            
            //线程间通信，回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"更新UI--%@",[NSThread currentThread]);
        }];
    }];
}


@end

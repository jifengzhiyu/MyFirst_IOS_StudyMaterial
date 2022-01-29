//
//  ViewController.m
//  同步任务
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
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"输入密码 %@",[NSThread currentThread]);
        });
        
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"支付 %@",[NSThread currentThread]);
        });
        
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"下载  %@",[NSThread currentThread]);
        });
    });
}


@end

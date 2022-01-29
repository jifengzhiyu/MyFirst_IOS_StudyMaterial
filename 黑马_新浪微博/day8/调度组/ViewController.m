//
//  ViewController.m
//  调度组
//
//  Created by 翟佳阳 on 2021/12/7.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
// 调度组 － 监听一组任务统一完成之后，执行某一个操作
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self group2];
}

//    dispatch_group_enter(group);
//        dispatch_group_leave(group);
//入组出组 配对出现
- (void)group2 {
    
    // 1. 创建 group
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    // 2. 创建并发任务
    dispatch_group_enter(group);
    dispatch_async(q, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"AAA - %@", [NSThread currentThread]);
        
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(q, ^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"BBB - %@", [NSThread currentThread]);
        
        dispatch_group_leave(group);
    });

    // 3. 监听调度组
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"over");
    });
}


/**
void
dispatch_group_async(dispatch_group_t group, dispatch_queue_t queue, dispatch_block_t block)
{
    // 入组 - 会监听后续的 block(任意) 的执行
    // 入组和出组一定要配对出现！
    dispatch_group_enter(group);
 
    dispatch_async(queue, ^{
        block();
 
        // 出组 - 通知调度组，任务完成
        // 出组的代码，一定放在 block 的最后一句
        dispatch_group_leave(group);
    });
}
 */

- (void)group1 {
    
    // 1. 创建 group
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    // 2. 创建并发任务
    dispatch_group_async(group, q, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"AAA - %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, q, ^{
        NSLog(@"BBB - %@", [NSThread currentThread]);
    });
    
    // 3. 统一获取通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"over");
    });
}

@end

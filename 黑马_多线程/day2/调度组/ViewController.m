//
//  ViewController.m
//  调度组
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
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self demo1];
}

//调度组的基本使用
- (void)demo1{
    //创建组
    dispatch_group_t group = dispatch_group_create();
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"No1");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"No2");
    });
     
    dispatch_group_async(group, queue, ^{
        NSLog(@"No3");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"over");
    });
}

@end

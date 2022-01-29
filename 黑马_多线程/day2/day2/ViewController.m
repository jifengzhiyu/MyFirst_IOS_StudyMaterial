//
//  ViewController.m
//  day2
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
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(demo) userInfo:nil repeats:YES];
    //把当前定时器添加到当前线程的消息循环中
    //调用demo方法需要先等1秒
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)demo{
    //当前消息循环的模式
    NSLog(@"demo---%@",[NSRunLoop currentRunLoop].currentMode);
    
}
@end

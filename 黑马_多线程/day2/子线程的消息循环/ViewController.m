//
//  ViewController.m
//  子线程的消息循环
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
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    
    //往子线程的消息循环中添加输入源
    [self performSelector:@selector(demo1) onThread:thread withObject:nil waitUntilDone:NO];
    
    [thread start];

}

//执行子线程上的方法
- (void)demo{
    NSLog(@"running");
    //开启子线程的消息循环
    //一般来说，开启子线程的消息循环，一旦开启，就会一直运行
    
    
    //如果[self performSelector:@selector(demo1) onThread:thread withObject:nil waitUntilDone:NO];没了
    //即 如果消息循环中没有添加输入事件 消息循环就会立即结束
    //[[NSRunLoop currentRunLoop] run];
    
    //2秒后 消息循环结束
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    NSLog(@"end");
}

//执行在子线程的消息循环中
- (void)demo1{
    NSLog(@"running on runloop");
}

@end

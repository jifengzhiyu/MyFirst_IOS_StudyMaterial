//
//  ViewController.m
//  day1
//
//  Created by 翟佳阳 on 2021/10/17.
//

#import "ViewController.h"
#import <pthread.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //新建状态
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    
    thread.name = @"t1";
    
    //就绪状态
    [thread start];
    
    
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    
    thread.name = @"t1";
    
    //就绪状态
    [thread1 start];
}

- (void)demo{
    for (int i = 0; i < 20; i++) {
        NSLog(@"%d----%@",i,[NSThread currentThread]);
        
        if(i == 5){
            //阻塞状态
            //[NSThread sleepForTimeInterval:3];
        }
        
//        if(i == 10){
//            //线程退出 死亡状态
//            [NSThread exit];
        //}
    }
}
@end

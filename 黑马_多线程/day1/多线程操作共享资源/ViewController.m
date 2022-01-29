//
//  ViewController.m
//  多线程操作共享资源
//
//  Created by 翟佳阳 on 2021/10/18.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) int num;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.num = 10;
    NSThread *t1 = [[NSThread alloc] initWithTarget:self selector:@selector(sell) object:nil];
    [t1 start];
    
    NSThread *t2 = [[NSThread alloc] initWithTarget:self selector:@selector(sell) object:nil];
    [t2 start];
    
}

- (void)sell{
    while (YES) {
        //模拟耗时
        [NSThread sleepForTimeInterval:1.0];
        
        //同步
        //任意一个对象内部都有一把锁
        @synchronized (self) {
                   if(self.num > 0){
                       self.num --;
                       NSLog(@"剩余%d",self.num);
                   }else{
                       NSLog(@"无");
                       break;
                   }
               }
           }
}

@end

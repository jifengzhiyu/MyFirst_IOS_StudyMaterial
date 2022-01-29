//
//  ViewController.m
//  12-block的循环引用
//
//  Created by male on 15/10/11.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "NetworkTools.h"

@interface ViewController ()
@property (nonatomic, strong) NetworkTools *tools;
@end

@implementation ViewController

// 1. 解除循环引用，需要注意打断引用链条即可！
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 局部变量不会产生循环应用，全局属性会产生循环引用
    self.tools = [[NetworkTools alloc] init];
    
    // 1. 定义 block 的时候，会对外部变量做一次 copy，会对 self 进行强引用
    
    // 解除循环引用方法1
    // __weak 是 iOS 5.0 推出的
    // 如果异步操作没有完成，释放控制器，__weak 本身是弱引用
    // 当异步执行完毕，进行回调，self 已经被释放，无法访问属性，也无法调用方法
    // __weak 相当于 weak，不会做强引用，但是如果对象被释放，执行的地址，会指向 nil
    // __weak 更安全
    __weak typeof(self) weakSelf = self;
    
    // 解除循环引用方法2
    // __unsafe_unretained 是 iOS 4.0 推出的
    // MRC 经典错误，EXC_BAD_ACCESS 坏内存访问，野指针
    // 相当于 assign，不会做强引用，但是如果对象被释放，内存地址保持不变，如果此时再调用，就会出现野指针访问
//    __unsafe_unretained typeof(self) weakSelf = self;
    
    [self.tools loadData:^(NSString *html) {
        
        // 工作中会看到一个代码，流传出来的，一直没有人太过深究，大家记住了套路
        // strongSelf 强引用，对 weakSelf 进行强引用，本意，希望在异步完成后，继续执行回调代码
        __strong typeof(self) strongSelf = weakSelf;
        
        NSLog(@"%@ %@", html, strongSelf.view);
    }];
}

- (void)dealloc {
    NSLog(@"控制器 88");
}

@end

//
//  NetworkTools.m
//  12-block的循环引用
//
//  Created by male on 15/10/11.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "NetworkTools.h"

@interface NetworkTools()
@property (nonatomic, copy) void (^finishedBlock)(NSString *);
@end

@implementation NetworkTools

/**
 block 是一组提前准备好的代码，在需要的时候执行
 可以当作参数传递
 
 在异步的方法中，如果能够执行 block，就直接执行！
 如果不能直接执行 block，通常需要定义一个属性，记录 block，在需要的时候执行
 */
// -- 演练二，间接调用
- (void)loadData:(void (^)(NSString *))finished {
    
    // 1. 使用属性记录 block
    self.finishedBlock = finished;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"异步处理");
        
        // 模拟延时
        [NSThread sleepForTimeInterval:2.0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"准备回调");
            
            // 2. 由 working 调用 finished
            [self working];
        });
    });
}

- (void)working {
    // 执行回调函数
    if (self.finishedBlock != nil) {
        self.finishedBlock(@"hello .....");
    }
}


// -- 演练一，直接执行 block
- (void)loadData2:(void (^)(NSString *))finished {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"异步处理");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"准备回调");
            
            // 执行回调
            finished(@"html..........");
        });
    });
}

- (void)dealloc {
    NSLog(@"network tools 88");
}

@end

//
//  NetWorkTools.m
//  OC单例
//
//  Created by 翟佳阳 on 2021/11/25.
//

#import "NetWorkTools.h"

@implementation NetWorkTools

// 面试的时候，手写单例就写以下部分即可！
+ (instancetype)sharedNetWorkTools{
    static id instance;
    
    static dispatch_once_t onceToken;
    // 如果为 0，就执行 block 中的代码！

    NSLog(@"---> %ld", onceToken);

    
    dispatch_once(&onceToken,^{
        instance = [[self alloc] init];
    });
    return instance;
}
@end

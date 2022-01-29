//
//  MyTools.m
//  单例
//
//  Created by 翟佳阳 on 2021/10/20.
//

#import "MyTools.h"

@implementation MyTools
//不推荐使用，锁会休眠，耽误时间
+ (instancetype)sharedMyTools{
    static id instance = nil;
    //保证线程安全
    @synchronized (self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}



+ (instancetype)sharedMyToolsOnce{
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}
@end

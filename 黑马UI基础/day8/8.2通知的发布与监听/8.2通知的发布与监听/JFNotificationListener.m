//
//  JFNotificationListener.m
//  8.2通知的发布与监听
//
//  Created by 翟佳阳 on 2021/9/18.
//

#import "JFNotificationListener.h"

@implementation JFNotificationListener

-(void)m1:(NSNotification *)noteInfo{
    //打印出来的：name 监听到通知的名称
    //object 监听到的通知是哪个对象发布的
    //userInto：通知的内容
    NSLog(@"m1方法被执行");
    NSLog(@"%@",noteInfo);
}

//移除通知，解除关系
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

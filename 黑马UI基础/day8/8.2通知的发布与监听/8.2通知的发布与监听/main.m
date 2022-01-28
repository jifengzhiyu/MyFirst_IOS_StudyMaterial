//
//  main.m
//  8.2通知的发布与监听
//
//  Created by 翟佳阳 on 2021/9/18.
//

#import <Foundation/Foundation.h>
#import "JFNotaficationSender.h"
#import "JFNotificationListener.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //创建一个通知的发布者
        JFNotaficationSender *sender1 = [[JFNotaficationSender alloc] init];
        //创建一个通知的监听者
        JFNotificationListener *listener1 = [[JFNotificationListener alloc] init];
        //获取NSNotification对象
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        
        //监听一个通知，必须要监听对象拥有一个监听方法
        [notificationCenter addObserver:listener1 selector:@selector(m1:) name:@"JFname1" object:sender1];
        
        //让sender1对象发布一个通知
        //通过NSNotificationCenter发布一个通知
        [notificationCenter postNotificationName:@"JFname1" object:sender1 userInfo:@{@"title" : @"阿爸爸爸",
                                                                                      @"content" : @"撑死了"
        }];
        
    }
    return 0;
}

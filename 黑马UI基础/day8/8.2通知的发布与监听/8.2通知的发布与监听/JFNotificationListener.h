//
//  JFNotificationListener.h
//  8.2通知的发布与监听
//
//  Created by 翟佳阳 on 2021/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//通知的监听者
@interface JFNotificationListener : NSObject
@property (nonatomic,copy)NSString *name;

//一个用来监听通知的方法
//当通知被监听时会自动传一个NSNotification对象进去
-(void)m1:(NSNotification *)noteInfo;
@end

NS_ASSUME_NONNULL_END

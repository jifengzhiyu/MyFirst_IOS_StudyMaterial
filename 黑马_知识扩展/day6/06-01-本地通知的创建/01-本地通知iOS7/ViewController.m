//
//  ViewController.m
//  01-本地通知iOS7
//
//  Created by male on 15/11/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 // 触发时间
 @property(nullable, nonatomic,copy) NSDate *fireDate;
 // 时区
 @property(nullable, nonatomic,copy) NSTimeZone *timeZone;
 
 // 重复 --> 单位是日历组件 , 0 代表不重复
 @property(nonatomic) NSCalendarUnit repeatInterval;
 
 // 重复 --> 上面那个属性所依赖的日历格式  公历 农历
 @property(nullable, nonatomic,copy) NSCalendar *repeatCalendar;
 
 // 区域
 @property(nullable, nonatomic,copy) CLRegion *region NS_AVAILABLE_IOS(8_0);
 
 // 区域只检测一次
 @property(nonatomic,assign) BOOL regionTriggersOnce NS_AVAILABLE_IOS(8_0);
 
 // 提醒的主题内容
 @property(nullable, nonatomic,copy) NSString *alertBody;   
 
 // 是否显示锁屏时的文字以及提醒样式的按钮文字
 @property(nonatomic) BOOL hasAction;  
 
 // 设置显示锁屏时的文字以及提醒样式的按钮文字
 @property(nullable, nonatomic,copy) NSString *alertAction; 
 
 // 设置启动图
 @property(nullable, nonatomic,copy) NSString *alertLaunchImage; 
 
 // 设置标题
 @property(nullable, nonatomic,copy) NSString *alertTitle
 
 // 设置声音 , 默认声音: UILocalNotificationDefaultSoundName
 @property(nullable, nonatomic,copy) NSString *soundName;
 
 // 设置图标的数字角标 (图标标记)
 @property(nonatomic) NSInteger applicationIconBadgeNumber;  // 0 means no change. defaults to 0
 
 // 设置携带参数
 @property(nullable, nonatomic,copy) NSDictionary *userInfo;
 
 // 设置分类
 @property (nullable, nonatomic, copy) NSString *category

 */


#pragma mark 点击发送本地通知
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1. 创建本地通知对象
    UILocalNotification *localNotifi = [UILocalNotification new];
    
    //2. 设置属性
    
    //2.1 设置触发时间
    localNotifi.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    
    //2.2 设置提示内容
    localNotifi.alertBody = @"今天不适合敲代码";
    
    //2.3 设置声音 (只有真机有效)
    localNotifi.soundName = UILocalNotificationDefaultSoundName;
    
    localNotifi.applicationIconBadgeNumber = 5;
    
    //2.4 设置 默认YES
    localNotifi.hasAction = NO;
    
    //2.5 设置 提醒样式的按钮文字 / 锁屏界面底部的文字
    localNotifi.alertAction = @"回复呵呵";
    
 #pragma mark 不常用属性
    
    //2.6 设置重复 最小单位是分钟 如果此属性设置了, 那么调度池不会用完释放
    //localNotifi.repeatInterval = NSCalendarUnitMinute;
    
    //2.7 设置重复所依赖的日历 不设置的话, 默认是跟随系统设置走得
    
    // 默认就是跟随系统走
    //localNotifi.repeatCalendar = [NSCalendar calendarWithIdentifier:@"跳进官方文档, 里面就有一堆的标示符, 找chinese的选项, 就代表是农历"];
    
    
    //3. 调度通知 , 如果是IOS7 , 这一步写完就OK
    //schedule : 调度
    // 将通知加入到本地调度池中
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotifi];
    
    //4. iOS8 需要增加一个方法 --> 需要授权
    
    /**
     UIUserNotificationTypeNone    = 0,
     UIUserNotificationTypeBadge   = 1 << 0, //图标标记
     UIUserNotificationTypeSound   = 1 << 1, //声音
     UIUserNotificationTypeAlert   = 1 << 2, //提醒
     */
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    //5. 删除通知
    // 删除当前程序注册的所有通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // 删除指定的通知 --> 一般用于干掉会重复的通知 / 或者还没有被调用的通知
    //[[UIApplication sharedApplication] cancelLocalNotification:localNotifi];
    
    // 获取通知 --> 配合删除用的
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *local in localNotifications) {
        NSLog(@"local: %@", local);
    }
    
    // 如果是当前程序内收到了通知, 那么界面没有任何变化
}

@end

//
//  ViewController.m
//  应用程序对象介绍
//
//  Created by 翟佳阳 on 2021/9/27.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)btnClick{
    //应用头像右上角的数字，默认0，没有数字
    //不是0，显示数字
   
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //申请通知权限
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if(granted){
            NSLog(@"通知开启");
        }else{
            NSLog(@"关闭通知");
        }
    }];
    // 获取授权的通知权限
//    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//        NSLog(@"%@", settings);
//    }];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    
    content.badge = @99;
    content.title = @"国庆倒数";
    content.subtitle = @"可喜可贺";
    content.body = @"经历的无数恶心到吐血的调休，我们总算是可以尽情地沉迷于欢乐之中";
    
    // 如果repeats为YES，那么triggerWithTimeInterval的值要大于60s
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    
    NSString *requestIdentifier = @"requestIdentifier";
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger1];
    // 发送通知
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"发送通知出错： %@", error);
    }];
    
    
    
    
}


@end

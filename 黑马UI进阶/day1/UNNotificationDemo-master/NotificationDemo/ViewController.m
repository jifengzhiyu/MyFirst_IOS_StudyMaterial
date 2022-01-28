//
//  ViewController.m
//  NotificationDemo
//
//  Created by Gandalf on 16/11/30.
//  Copyright © 2016年 Gandalf. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController () <UNUserNotificationCenterDelegate>

@property (nonatomic, strong) UNMutableNotificationContent *noticeContent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.noticeContent = [[UNMutableNotificationContent alloc] init];
    
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
}

// 普通通知
- (IBAction)normalNotification:(id)sender {
    [self registerNotification:[[UNMutableNotificationContent alloc] init]];
}

// 图片通知
- (IBAction)imageNotification:(id)sender {
    
    UNMutableNotificationContent *noticeContent = [[UNMutableNotificationContent alloc] init];
    
    NSString *imageFile = [[NSBundle mainBundle] pathForResource:@"sport" ofType:@"png"];
    UNNotificationAttachment *imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttachment" URL:[NSURL fileURLWithPath:imageFile] options:nil error:nil];
    NSAssert(imageAttachment != nil, @"imageAttach 不能为空");
    noticeContent.attachments = @[imageAttachment];
    
    [self registerNotification:noticeContent];
}

// 视频通知
- (IBAction)videoNotification:(id)sender {
    
    UNMutableNotificationContent *noticeContent = [[UNMutableNotificationContent alloc] init];
    
    NSString *movieFile = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mp4"];
    UNNotificationAttachment *movieAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"movieAttachment" URL:[NSURL fileURLWithPath:movieFile] options:nil error:nil];
    NSAssert(movieAttachment != nil, @"movieAttach 不能为空");
    noticeContent.attachments = @[movieAttachment];
    
    [self registerNotification:noticeContent];
    
}

// 交互式通知
- (IBAction)actionableNotification:(id)sender {
    
    UNMutableNotificationContent *noticeContent = [[UNMutableNotificationContent alloc] init];
    
    // 文字action
    UNTextInputNotificationAction *action1 = [UNTextInputNotificationAction actionWithIdentifier:@"replyAction" title:@"文字回复" options:UNNotificationActionOptionNone];
    // 进入应用action
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"enterAction" title:@"进入应用" options:UNNotificationActionOptionForeground];
    // 取消action
    UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:@"cancelAction" title:@"取消" options:UNNotificationActionOptionDestructive];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"Categroy" actions:@[action1, action2, action3] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:category]];
    
    noticeContent.categoryIdentifier = @"Categroy";
    
    [self registerNotification:noticeContent];
}

// 移除通知
- (IBAction)deleteNotification:(id)sender {
    
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[@"requestIdentifier"]];
}


- (void)registerNotification:(UNMutableNotificationContent*)content {
    
    content.title = @"iOS10通知";
    content.subtitle = @"新通知学习笔记";
    content.body = @"新通知变化很大，之前本地通知和远程推送是两个类，现在合成一个了。";
    // 添加声音
    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"caodi.m4a"];
    content.sound = sound;
    // 如果repeats为YES，那么triggerWithTimeInterval的值要大于60s
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    
    NSString *requestIdentifier = @"requestIdentifier";
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger1];
    // 发送通知
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"发送通知出错： %@", error);
    }];
}

#pragma mark - UNUserNotificationCenterDelegate
// 应用在前台收到通知的处理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSLog(@"执行willPresentNotificaiton");
}

// 应用在后台收到通知的处理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
    
    if ([categoryIdentifier isEqualToString:@"Categroy"]) {
        if ([response.actionIdentifier isEqualToString:@"replyAction"]) {
            UNTextInputNotificationResponse *textResponse = (UNTextInputNotificationResponse*)response;
            
            NSString *userText = textResponse.userText;
            
            NSLog(@"您输入的内容：%@", userText);
            
        } else if ([response.actionIdentifier isEqualToString:@"enterAction"]) {
            NSLog(@"点击进入了应用");
        } else {
            NSLog(@"点击了取消");
        }
    }
    
    completionHandler();
}

@end

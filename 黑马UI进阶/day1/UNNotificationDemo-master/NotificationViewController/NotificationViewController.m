//
//  NotificationViewController.m
//  NotificationViewController
//
//  Created by Gandalf on 16/12/1.
//  Copyright © 2016年 Gandalf. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *noticeTitle;

@property IBOutlet UILabel *noticeSubtitle;

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.noticeTitle.text = [notification.request.content.title stringByAppendingString:@"Kelvin Made"];
    
    self.noticeSubtitle.text = notification.request.content.subtitle;
    
    self.label.text = notification.request.content.body;
}

@end

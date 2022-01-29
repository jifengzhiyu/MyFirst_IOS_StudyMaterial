//
//  AppDelegate.m
//  06-通讯录不带 UI
//
//  Created by Romeo on 15/9/24.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "AppDelegate.h"
#import <AddressBook/AddressBook.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //通讯录授权 --> iOS6开始, 必须授权才能上架
    
    /**
     kABAuthorizationStatusNotDetermined = 0   用户未选择
     kABAuthorizationStatusRestricted,         一些许可配置阻止了通讯录的交互
     kABAuthorizationStatusDenied,             用户拒绝
     kABAuthorizationStatusAuthorized          用户授权
     */
    
    
    //1. 获取授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    //2. 创建 AddrssBook
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    //3. 没有授权时就授权
    if (status == kABAuthorizationStatusNotDetermined) {
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            
            //3.1 判断出错
            if (error) {
                return;
            }
            
            //3.2 判断是否授权
            if (granted) {
                NSLog(@"已经授权");
            } else {
                NSLog(@"没有授权");
            }
            
        });
    }
    
    //4. 释放 CF 对象
    CFRelease(addressBook);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

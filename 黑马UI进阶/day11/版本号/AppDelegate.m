//
//  AppDelegate.m
//  版本号
//
//  Created by 翟佳阳 on 2021/10/15.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self saveAppVersion];

    return YES;
}

-(void)saveAppVersion{
    //获取info字典
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    
    //获取当前版本号
    //NSLog(@"%@",info[@"CFBundleShortVersionString"]);
    
    NSString *appVersion = info[@"CFBundleShortVersionString"];
    //获取ud单例
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //保存到沙盒
    [ud setObject:appVersion forKey:@"appVersion"];
    
}
#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end

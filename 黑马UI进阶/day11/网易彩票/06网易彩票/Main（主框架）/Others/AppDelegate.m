//
//  AppDelegate.m
//  06网易彩票
//
//  Created by teacher on 15/7/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "AppDelegate.h"
#import "ITCASTMainTabBarController.h"
#import "ITCASTGuideController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1. 创建UIWindow
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 根据版本号来选择启动的控制器
    [self chooseStartVc];
    
    
    // 统一设置导航栏的外观
    [self setNavigationBarStyle];
    
    // 统一设置状态栏
    [self setStatusBarStyle:application];
    
    
    // 4. 设置self.window为主控器并显示
    [self.window makeKeyAndVisible];
    
    return YES;
}

// 选择启动控制器
- (void)chooseStartVc
{
    
    // 1.1 获取当前的app的版本号
    NSString *appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 1.2 从偏好设置中获取上一次记录下来的版本号
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [usrDefault objectForKey:@"app_ver"];
    
    // 1.3 用这两个版本号进行比较, 判断是否是更新了应用程序后的第一次启动（或者是第一次运行该程序）
    if ([appVersion isEqualToString:lastVersion]) {
    
    //if (NO) {
        // 版本号一致，表示应用程序没有更新
        // 2. 创建根控制器（UITabBarController）
        ITCASTMainTabBarController *mainVc = [[ITCASTMainTabBarController alloc] init];
        // 3. 将UITabBarController设置为self.window的根控制器
        self.window.rootViewController = mainVc;
        
    } else {
       // NSLog(@"应用程序更新了~~~需要显示新特性界面");
        ITCASTGuideController *guideVc = [[ITCASTGuideController alloc] init];
        self.window.rootViewController = guideVc;
    }
    
    
    
    
    // 2. 把当前app的版本号记录下来
    
    [usrDefault setObject:appVersion forKey:@"app_ver"];
    [usrDefault synchronize]; // 同步一下
}

// 统一设置状态栏
- (void)setStatusBarStyle:(UIApplication *)application
{
    application.statusBarStyle = UIStatusBarStyleLightContent;
    // 显示状态栏
    application.statusBarHidden = NO;
}

// 统一设置导航栏的外观
- (void)setNavigationBarStyle
{
    // appearance方法返回当前控件的外观代理对象
    // 我们只要修改了某个控件的外观代理对象的"外观", 那么在当前app中的所有的这类型控件的外观就都跟着改了。
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置导航栏的背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    // 统一设置导航栏中标题文字的颜色
    NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:attrs];
    // 修改导航栏中其他按钮的文字颜色
    [navBar setTintColor:[UIColor whiteColor]];
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

//
//  SceneDelegate.m
//  UITableBarController的简单使用
//
//  Created by 翟佳阳 on 2021/10/3.
//

#import "SceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    //1、创建window
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    //2.1初始化UITableBarController
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    
    //设置tabBar的背景颜色，使tabBarItem都显示出来
    tabbarController.tabBar.backgroundColor = [UIColor whiteColor];
    //2.2创建子控制器
    UIViewController *v1 = [[UIViewController alloc] init];
    UIViewController *v2 = [[UIViewController alloc] init];
    UIViewController *v3 = [[UIViewController alloc] init];
    
    
    //2.3设置背景色
    v1.view.backgroundColor = [UIColor redColor];
    v2.view.backgroundColor = [UIColor blueColor];
    v3.view.backgroundColor = [UIColor purpleColor];
    
    
    //设置标题/图片
    v1.tabBarItem.title = @"联系人";
    v2.tabBarItem.title = @"消息";
    v3.tabBarItem.title = @"设置";
    //设置提醒
    v1.tabBarItem.badgeValue = @"342";
    
    
    //2.4添加子控制器
    //UITableBarController显示第一个添加的控制器，导航控制器显示最后一个添加的控制器
    [tabbarController addChildViewController:v1];
    [tabbarController addChildViewController:v2];
    [tabbarController addChildViewController:v3];

    
    //3、设置window根控制器
    self.window.rootViewController = tabbarController;
    //4、显示
    [self.window makeKeyAndVisible];
    //导航控制器需要依赖于一个控制器，但是UITableBarController不需要
    //可以看到tabBar的Frame
    NSLog(@"%@",tabbarController.tabBar);
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end

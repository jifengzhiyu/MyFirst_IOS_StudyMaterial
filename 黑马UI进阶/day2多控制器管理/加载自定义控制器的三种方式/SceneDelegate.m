//
//  SceneDelegate.m
//  加载自定义控制器的三种方式
//
//  Created by 翟佳阳 on 2021/9/29.
//

#import "SceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    
    //1、创建窗口
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    //2、加载storyboard， boundle为nil即默认mainBoundle
    UIStoryboard *JFboard = [UIStoryboard storyboardWithName:@"JFStoryboard" bundle:nil];
   //3、从storyboard文件中实例化控制器,实例化JFboard里面初始的控制器
//    UIViewController *JFVc = [JFboard instantiateInitialViewController];
    
    //如果一个storyboard里面有多个控制器，加载实例化指定的控制器
    //使用idenfifier指定
    UIViewController *JFVc = [JFboard instantiateViewControllerWithIdentifier:@"brn"];
    //4、创建导航控制器
    UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:JFVc];
    //2.3设置为根控制器 ; 将窗口设为应用的主窗口，可见
    [self.window setRootViewController:rootNav];
    [self.window makeKeyAndVisible];
    
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

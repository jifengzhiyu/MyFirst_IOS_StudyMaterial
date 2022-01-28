//
//  SceneDelegate.m
//  导航控制器的基本使用
//
//  Created by 翟佳阳 on 2021/9/29.
//

#import "SceneDelegate.h"
#import "JFRedViewController.h"
#import "JFBlueViewController.h"
#import "JFGreenViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    //创建window
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    //创建红色控制器
    JFRedViewController *redVc = [[JFRedViewController alloc]init];
    //创建导航控制器,必须同时制定导航控制器的根控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:redVc];
    //设置根控制器
    self.window.rootViewController = nav;
    
    nav.view.backgroundColor = [UIColor greenColor];
    
    //创建三个控制器交给导航控制器管理
//    JFBlueViewController *blueVc = [[JFBlueViewController alloc]init];
//    JFGreenViewController *greenVc = [[JFGreenViewController alloc]init];
//
//    //push进来
//    [nav pushViewController:redVc animated:YES];
//    [nav pushViewController:greenVc animated:YES];
//    [nav pushViewController:blueVc animated:YES];
    
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

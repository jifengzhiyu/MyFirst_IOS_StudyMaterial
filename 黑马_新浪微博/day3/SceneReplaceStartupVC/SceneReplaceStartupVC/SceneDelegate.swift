//
//  SceneDelegate.swift
//  SceneReplaceStartupVC
//
//  Created by billbill on 2021/11/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if (window == nil) {
            print("window => nil")
        }
        // ⚠️ 取消了配置文件之后
        // window? 属性为什么会是 可选呢
        // 因为取消配置文件 main 之后这个值就会为 nil 空
        // 需要自己赋值 并且关联 windowScene
//        guard let _ = (scene as? UIWindowScene) else { return }
        // 这里给需要用到的 win scene 改个名
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 实例化新的 window 视图窗口 => uiwindow 本质是个 uiview 而已
        //“实例化是指在面向对象的编程中，把用类创建对象的过程称为实例化
        // 但是是个特殊的 uiview 自己可以点进去看类的描述 definition
        // 另外这里需要关联当前系统给到的场景
        // 至于这些什么场景 视图 啥的都是苹果为了开发程序弄出来的概念跟结构
        // 方便理顺开发者的思维
        // 反正我是这样理解的
        let newWindow = UIWindow(windowScene: windowScene)
//        let newWindow = UIWindow(frame: UIScreen.main.bounds) 无法显示 因为没有附着到场景 scene 里面
        
        // 实例化新的 vc
//        let vc = AAViewController()
        let vc = ViewController()
        // 设置 vc 掌管的 view 的 bgColor
        vc.view.backgroundColor = .cyan
        
        // 设置新window 的 根部视图控制器
        newWindow.rootViewController = vc
        // 让新窗口可见
        newWindow.makeKeyAndVisible()
        // 赋值系统因为配置文件取消 赋值 nil 的 window 属性为新的自己实例化的启动窗口视图(!!!记住本质是 uiview)
        window = newWindow
        
        /*
         ⚠️
         application => scene 场景 => 场景下面分属 window 视图窗口 => 每个 window 下面掌管 vc 里面的 view, vc 的存在不过是调用业务逻辑更新里面的 view, 这个 view 又会嵌套在 window 上显示, 后面 vc 这玩意会在 SwiftUI 框架里被消灭, 因为后面都流行 mvvm 的架构
         */
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


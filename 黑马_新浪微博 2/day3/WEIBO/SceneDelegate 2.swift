//
//  SceneDelegate.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/11/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupAppeatance()
        
        let newWindow = UIWindow(windowScene: windowScene)
//        let vc = ViewController()
//        let vc = MainViewController()
//        vc.view.backgroundColor = .white
//        newWindow.rootViewController = vc
        
//        newWindow.rootViewController = defaultRootViewController
        
//        newWindow.rootViewController = HomeTableViewController()
        newWindow.rootViewController = MainViewController()
        // 测试通知中心引用代码
//        let vc = UIViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "测试", style: .plain, target: self, action: #selector(self.testClick))
//        newWindow.rootViewController = nav

//        newWindow.makeKeyAndVisible()



        newWindow.makeKeyAndVisible()
        window = newWindow

        print(isNewVersion)
        
        // 监听通知
        //控制中心 是单例
        //[weak self] 控制中心 delegate 都是常驻，两个常驻最好写一个weak
        // 通知名称，通知中心用来识别通知的
        // 发送通知的对象，如果为nil，监听任何对象
        // nil，主线程
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init(rawValue: WBSwitchRootViewControllerNotification), object: nil, queue: nil) { [weak self] notification in
            print(Thread.current)
            //通知的名称
            print(notification)
            
            let vc = notification.object != nil ? WelcomeViewController() : MainViewController()
            //切换控制器
            self?.window?.rootViewController = vc

        }
    }
    
    // 测试通知中心引用代码
//    @objc func testClick() {
//        // push home
//        let nav = window?.rootViewController as! UINavigationController
//
//        nav.pushViewController(HomeTableViewController(), animated: true)
//    }
    // 注销通知 - 注销指定的通知
    deinit {
        
        NotificationCenter.default.removeObserver(self,   // 监听者
        name:NSNotification.Name.init(rawValue: WBSwitchRootViewControllerNotification) ,           // 监听的通知
            object: nil)                                   // 发送通知的对象
    }
    
    
    /// 设置全局外观 - 在很多应用程序中，都会在 这里 中设置所有需要控件的全局外观
    private func setupAppeatance(){
        // 修改导航栏的全局外观 － 要在控件创建之前设置，一经设置全局有效
        UINavigationBar.appearance().tintColor = WBAppearanceTintColor
        
        // 设置 tintColor － 图片渲染颜色（点击的颜色)
        // 性能提升的技巧 - 如果能够用颜色解决，就不建议使用图片
        UITabBar.appearance().tintColor = WBAppearanceTintColor
        
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
        // 清除数据库缓存
        StatusDAL.clearDataCache()
    }


}


// MARK: - 界面切换代码
extension SceneDelegate {
    
    /// 启动的根视图控制器
    private var defaultRootViewController: UIViewController {
        
        // 1. 判断是否登录
        if UserAccountViewModel.sharedUserAccount.userLogon {
            return isNewVersion ? NewFeatureViewController() : WelcomeViewController()
        }
        
        // 2. 没有登录返回主控制器
        return MainViewController()
    }
    
    /// 判断是否新版本
    private var isNewVersion: Bool {
        
        // 1. 当前的版本 - info.plist
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let version = Double(currentVersion)!
        print("当前版本 \(version)")
        
        // 2. `之前`的版本，把当前版本保存在用户偏好 - 如果 key 不存在，返回 0
        let sandboxVersionKey = "sandboxVersionKey"
        let sandboxVersion = UserDefaults.standard.double(forKey: sandboxVersionKey)
        print("之前版本 \(sandboxVersion)")

        // 3. 保存当前版本
        UserDefaults.standard.set(version, forKey: sandboxVersionKey)
        
        return version > sandboxVersion
    }
}

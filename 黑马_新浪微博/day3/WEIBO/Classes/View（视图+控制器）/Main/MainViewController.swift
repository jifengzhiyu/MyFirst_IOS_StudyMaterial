//
//  MainViewController.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/11/23.
//

import UIKit

class MainViewController: UITabBarController {
    // MARK: - 监听方法
    /// 点击撰写按钮
    /// 如果`单纯`使用 `private` 运行循环将无法正确发送消息，导致崩溃
    /// 如果使用 @objc 修饰符号，可以保证运行循环能够发送此消息，即使函数被标记为 private
    @objc private func clickComposedButton() {
        print("点我了")
        // 判断用户是否登录
        var vc: UIViewController
        if UserAccountViewModel.sharedUserAccount.userLogon {
            vc = ComposeViewController()
        } else {
            vc = OAuthViewController()
        }
        
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
    
    
    // MARK: - 视图生命周期函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        addChilds()
        // 添加控制器，并不会创建 tabBar 中的按钮！
        // 懒加载是无处不在的，所有控件都是延迟创建的！
        print(tabBar.subviews)
        
        setUpComposedButton()
    }
    
    //        newWindow.makeKeyAndVisible()
    //执行下面
    override func viewWillAppear(_ animated: Bool) {
        // 会创建 tabBar 中的所有控制器对应的按钮！
        super.viewWillAppear(animated)
        print(tabBar.subviews)
        
        // 将撰写按钮弄到最前面
        tabBar.bringSubviewToFront(composedButton)
    }
    
    
    //MARK: - 懒加载控件
    private lazy var composedButton: UIButton = UIButton(imageName: "tabbar_compose_icon_add", backImageName: "tabbar_compose_button")
    
//    {
//        let button = UIButton()
//        button.setImage(UIImage.init(named: "tabbar_compose_icon_add"), for: .normal)
//        button.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
//        button.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), for: .normal)
//        button.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), for: .highlighted)
//
//        //根据背景图片大小调整尺寸
//        button.sizeToFit()
//        return button
//    }()
    
    
}



//MARK: - 设置界面
extension MainViewController{
    
    ///设置撰写按钮
    private func setUpComposedButton(){
        //添加按钮
        tabBar.addSubview(composedButton)
        
        //调整按钮位置
        let count = children.count
        let w = tabBar.bounds.width / CGFloat(count)

        composedButton.frame.origin = CGPoint(x: 2 * w, y: 0)
        print("\(composedButton.frame.origin)")
        //  添加监听方法
        composedButton.addTarget(self, action: #selector(self.clickComposedButton), for: UIControl.Event.touchUpInside)
        
        
    }
    
    private func addChilds() {
       
        
        addChild(vc: HomeTableViewController(), title: "Home")
        addChild(vc: MessageTableViewController(), title: "Message")
        addChild(UIViewController())
        addChild(vc: ProfileTableViewController(), title: "Profile")
        addChild(vc: DiscoverTableViewController(), title: "Discovwe")

    }
    
    
    
    ///函数的重载，参数不一样时
    ///   - vc: 控制器
    ///   - title: 标题
    private func addChild(vc:UIViewController, title: String) {
        //添加控制器
//        let vc = HomeTableViewController()
        
        //由内至外设置标题，所以这里 一次设置了两个
        vc.title = title
        
        //导航控制器
        let nav = UINavigationController(rootViewController: vc)
        
        addChild(nav)
    }
}

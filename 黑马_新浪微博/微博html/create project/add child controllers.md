# 添加子控制器

## 文件准备

* 将素材文件夹中的 `TabBar` 拖拽到 `Images.xcassets` 目录下

## 代码实现

* 添加第一个视图控制器

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    addChildViewController()
}

private func addChildViewController() {
    let vc = HomeTableViewController()
    vc.title = "首页"
    vc.tabBarItem.image = UIImage(named: "tabbar_home")

    addChildViewController(UINavigationController(rootViewController: vc))
}
```

* 重构代码抽取参数

```swift
/// 添加指定的控制器
///
/// - parameter vc:        控制器
/// - parameter title:     标题
/// - parameter imageName: 图像名
private func addChildViewController(vc: UIViewController, title: String, imageName: String) {
    vc.title = title
    vc.tabBarItem.image = UIImage(named: imageName)
    
    addChildViewController(UINavigationController(rootViewController: vc))
}
```

* 扩充调用函数，添加其他控制器

```swift
// 添加所有子控制器
private func addChildViewControllers() {
    tabBar.tintColor = UIColor.orangeColor()

    addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
    addChildViewController(MessageViewController(), title: "消息", imageName: "tabbar_message_center")
    
    addChildViewController(DiscoverViewController(), title: "发现", imageName: "tabbar_discover")
    addChildViewController(ProfileViewController(), title: "我", imageName: "tabbar_profile")
}
```




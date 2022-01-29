# 自定义 TabBar

## 目标

* 在 4 个控制器切换按钮中间增加一个撰写按钮
* 点击撰写按钮能够弹出对话框撰写微博

### 思路

* 加号按钮的大小与其他 `tabBarItem` 的大小是一致的
* 如果不考虑 modal 的方式，其所在位置应该同样有一个 `tabBarItem`
* 建立一个空的视图控制器形成占位
* 然后在该位置添加一个按钮遮挡

## 代码实现

* 添加空的视图控制器

```swift
/// 添加所有子控制器
private func addChildViewControllers() {
    // ...

    addChildViewController(UIViewController())

    // ...
}
```

> 注意 UIViewController() 的位置

### extension

* 在 `Tools` 目录下新建 `Extensions` 目录
* 新建 `UIButton+Extension.swift` 文件
* 建立 `UIButton` 的便利构造函数

```swift
extension UIButton {
    
    /// 使用 `图像名` 和 `背景图像名` 创建按钮
    ///
    /// - parameter imageName:     imageName
    /// - parameter backImageName: backImageName
    ///
    /// - returns: UIButton
    convenience init(imageName: String, backImageName: String) {
        self.init()
        
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: backImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: backImageName + "_highlighted"), forState: .Highlighted)
    }
}
```

> 目前在国内的 iOS 开发领域，使用纯代码开发的项目比例仍然很高，在实际开发中，如果有意识地积累 `Extension`，抽取封装常用代码，会让开发越来越快

### `MainViewController`

* 添加撰写按钮

```swift
// MARK: - 懒加载控件
/// 撰写按钮
private lazy var composedButton: UIButton = UIButton(imageName: "tabbar_compose_icon_add", backImageName: "tabbar_compose_button")
```

* 设置按钮位置

```swift
override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    tabBar.bringSubviewToFront(composedButton)
}

/// 设置撰写按钮
private func setupComposedButton() {
    tabBar.addSubview(composedButton)
    
    let count = childViewControllers.count
    let w = tabBar.bounds.width / CGFloat(count) - 1
    
    composedButton.frame = CGRectInset(tabBar.bounds, 2 * w, 0)
}
```

* 添加按钮监听方法

```swift
composedButton.addTarget(self, action: "clickComposedButton", forControlEvents: .TouchUpInside)
```

* 按钮监听方法

```swift
// MARK: - 监听方法
@objc private func clickComposedButton() {
    printLog("点击撰写按钮")
}
```

> 注意：按钮的监听方法如果使用 `private`，需要使用 `@objc` 关键字修饰



# 登录视图代码实现

## 目标

* 针对不同的控制器，显示不同的提示信息以及图标

## 代码实现

* 设置访客视图信息

```swift
// MARK: - 设置视图信息
/// 设置访客视图信息
///
/// - parameter imageName: 图像名称，如果是首页传入 nil
/// - parameter message:   描述文字
func setupInfo(imageName: String?, message: String) {
    
    messageLabel.text = message
    
    if let imageName = imageName {
        iconView.image = UIImage(named: imageName)
    }
}
```

* 在 `VisitorViewController` 中添加登录视图属性

```swift
/// 访客视图
var visitorView: VisitorLoginView?
```

* 在 `setupVisitorView` 中记录登录视图

```swift
visitorView = VisitorLoginView()
view = visitorView
```

## 修改功能视图控制器中的代码

* HomeTableViewController

```swift
visitorView?.setupInfo(nil, message: "关注一些人，回这里看看有什么惊喜")
```

* MessageTableViewController

```swift
visitorView?.setupInfo("visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
```

* DiscoverTableViewController

```swift
visitorView?.setupInfo("visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
```

* ProfileTableViewController

```swift
visitorView?.setupInfo("visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
```

* 修改 `setupInfo` 函数，非首页控制器隐藏小房子并且将遮罩视图移动到底层

```swift
/// 设置访客信息
///
/// - parameter imageName: imageName 名称，首页传入 nil
/// - parameter message:     描述文字
func setupInfo(imageName: String?, message: String) {
    
    messageLabel.text = message
    
    guard let imageName = imageName else {
        return
    }
    
    iconView.image = UIImage(named: imageName)
    homeIconView.hidden = true
    sendSubviewToBack(maskIconView)
}
```

* 提示信息
    * 关注一些人，回这里看看有什么惊喜
    * 登录后，别人评论你的微博，发给你的消息，都会在这里收到通知
    * 登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过
    * 登录后，你的微博、相册、个人资料会显示在这里，展示给别人

## 小结

* 每个控制器都拥有独立的 `visitorView`，可以使用以下代码确认

```swift
override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    print(visitorView)
}
```

* `VisitorViewController` 中的 `visitorView` 不要设置为懒加载，否则用户正常登录后，其他控制器中一旦调用 `visitorView`，仍然会创建访客视图，可以使用以下代码测试

```swift
/// 用户登录标记
var userLogon = true
/// 访客视图
lazy var visitorView: VisitorLoginView? = VisitorLoginView()

override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    print(visitorView)
}
```



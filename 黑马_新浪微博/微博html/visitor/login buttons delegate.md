# 登录&注册代理回调

## 目标

* 点击访客视图中的 `登录` & `注册` 按钮，在控制器中作出响应

## 代码实现

### 通过`代理`传递按钮点击事件

* 定义协议

```swift
/// 访客登录视图代理
protocol VisitorLoginViewDelegate: NSObjectProtocol {
    /// 访客视图注册
    func visitorLoginViewDidRegister();
    /// 访客视图登录
    func visitorLoginViewDidLogin();
}
```

> 定义协议时，需要继承自 `NSObjectProtocol`，否则无法设置代理的属性为 `weak`

* 定义代理

```swift
/// 代理
weak var delegate: VisitorLoginViewDelegate?
```

* 按钮回调

```swift
// MARK: - 监听方法
@objc private func register() {
    delegate?.visitorLoginViewDidRegister()
}

@objc private func login() {
    delegate?.visitorLoginViewDidLogin()
}
```

* 在 `setupUI` 中增加按钮监听方法

```swift
// 4. 添加按钮监听方法
registerButton.addTarget(self, action: "register", forControlEvents: .TouchUpInside)
loginButton.addTarget(self, action: "login", forControlEvents: .TouchUpInside)
```

* 遵守协议

```swift
class VisitorViewController: UITableViewController, VisitorLoginViewDelegate
```
* 设置代理

```swift
visitorView?.delegate = self
```

* 实现协议方法

```swift
// MARK: - VisitorLoginViewDelegate
func visitorLoginViewDidLogin() {
    printLog("用户登录")
}

func visitorLoginViewDidRegister() {
    printLog("用户注册")
}
```

* 修改导航条按钮监听方法

```swift
// 设置导航栏按钮
navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "visitorLoginViewDidRegister")
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "visitorLoginViewDidLogin")
```

> 运行测试

### 直接添加登录&注册按钮监听方法

* 修改 `VisitorViewController`
    * 删除遵守协议
    * 删除设置代理属性
* 修改 `VisitorLoginView`
    * 删除协议
    * 删除 `delegate` 属性
    * 删除按钮监听方法
    * 取消 `注册` & `登录` 按钮的 `private` 修饰符
* 在 `setupVisitorView` 方法中添加按钮监听方法

```swift
// 添加按钮监听方法
visitorView?.registerButton.addTarget(self, action: "visitorLoginViewDidRegister", forControlEvents: .TouchUpInside)
visitorView?.loginButton.addTarget(self, action: "visitorLoginViewDidLogin", forControlEvents: .TouchUpInside)
```

* 修改按钮监听方法作用域

```swift
// MARK: - 访客视图按钮监听方法
@objc private func visitorLoginViewDidLogin() {
    printLog("用户登录")
}

@objc private func visitorLoginViewDidRegister() {
    printLog("用户注册")
}
```

## 小结

* 使用代理传递消息是为了在控制器和视图之间解藕，让视图能够被多个控制器复用，例如 `UITableView`
* 但是，如果视图仅仅只是为了封装代码，而从控制器中剥离出来的，并且能够确认该视图不会被其他控制器引用，则可以直接通过 `addTarget` 的方式为该视图中的按钮添加监听方法
* 这样做的代价是耦合度高，控制器和视图绑定在一起，但是会省略部分冗余代码

### 代理的使用

* `swift` 中代理的使用基本与 OC 相同
* 需要注意的是，定义协议时，需要继承自 `NSObjectProtocol`
* 代理属性需要使用 `weak` 防止出现循环引用



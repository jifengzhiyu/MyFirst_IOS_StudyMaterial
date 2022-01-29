# 欢迎界面

## 需求

* 用户登录成功会显示一个欢迎界面
* 特例：如果用户的系统刚刚升级或者第一次登录，会显示 `新特性` 界面，而不是 `欢迎`界面

## 目标 

* 自动布局的动画实现

## 准备文件

* 在 `NewFeature` 目录下新建 `WelcomeViewController.swift` 继承自 `UIViewController`

## 代码实现

* 修改 `AppDelegate` 的根视图控制器

```swift
window?.rootViewController = WelcomeViewController()
```

* 懒加载控件

```swift
/// 背景图像
private lazy var backImageView: UIImageView = UIImageView(imageName: "ad_background")
/// 默认头像
private lazy var iconView: UIImageView = {
   
    let iv = UIImageView(imageName: "avatar_default_big")
    
    iv.layer.cornerRadius = 45
    iv.layer.masksToBounds = true
    
    return iv
}()
/// 欢迎标签
private lazy var welcomeLabel: UILabel = UILabel(title: "欢迎归来", fontSize: 17)
```

* 搭建界面 - 设置根视图

```swift
override func loadView() {
    view = backImageView
    
    setupUI()
    
}
```

* 设置子控件

```swift
// MARK: - 设置界面
extension WelcomeViewController {
    
    private func setupUI() {
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        welcomeLabel.alpha = 0
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(view.snp_bottom).offset(-200)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        welcomeLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(16)
        }
    }
}
```

* 界面动画

```swift
override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    iconView.snp_updateConstraints { (make) -> Void in
        make.bottom.equalTo(view.snp_bottom).offset(-view.bounds.height + 200)
    }
    
    UIView.animateWithDuration(1.0,
        delay: 0,
        usingSpringWithDamping: 0.8,
        initialSpringVelocity: 5,
        options: [],
        animations: { () -> Void in
        
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animateWithDuration(0.8, animations: {
                
                self.welcomeLabel.alpha = 1.0
                
                }) { _ in
                    print("OK")
            }
    }
}
```

* 参数说明
    * `usingSpringWithDamping` 的范围为 `0.0f` 到 `1.0f`，数值越小 `弹簧` 的振动效果越明显
    * `initialSpringVelocity` 则表示初始的速度，数值越大一开始移动越快，初始速度取值较高而时间较短时，会出现反弹情况

### 设置用户头像

* 在 `UserAccountViewModel` 中增加 `avatarUrl` 头像属性

```swift
/// 头像 URL
var avatarUrl: NSURL {
    return NSURL(string: userAccount?.avatar_large ?? "")!
}
```

* 在 `viewDidLoad` 中增加以下代码

```swift

override func viewDidLoad() {
    super.viewDidLoad()

    // 设置头像
    iconView.sd_setImageWithURL(UserAccountViewModel.sharedUserAccount.avatarUrl,
        placeholderImage: UIImage(named: "avatar_default_big"))
}
```

* 添加图像宽高约束

```swift
iconView.snp_makeConstraints { (make) -> Void in
    make.centerX.equalTo(view.snp_centerX)
    make.bottom.equalTo(view.snp_bottom).offset(-200)
    make.width.equalTo(90)
    make.height.equalTo(90)
}
```

## 小结

* 使用自动布局开发时，不要再修改添加了约束视图的 `frame`，否则会引起自动布局系统的错误
* 自动布局系统会在每次事件循环中收集约束的变化，并在事件循环结束前根据约束变化计算子视图的 `frame`，并调用 `layoutSubViews` 更新所有视图的位置
* 如果希望提前更新约束，可以调用 `self.view.layoutIfNeeded()` 更新当前已经修改过的约束

### SnapKit

* 创建约束 `snp_makeConstraints`
* 更新约束 `snp_updateConstraints`
* 重新创建约束 `snp_remakeConstraints`

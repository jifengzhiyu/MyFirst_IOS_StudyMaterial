# 搭建界面

## 目标

* 自定义工具栏
* 文本视图的滚动关闭键盘
* 文本视图与键盘的联动

## 代码实现

### 准备工作

* 新建 `Compose` 目录
* 新建 `ComposeViewController` 继承自 `UIViewController`
* 修改 `MainViewController`

```swift
/// 点击撰写按钮的方法 - 如果用户没有登录，显示用户登录界面
@objc private func clickComposedButton() {
    let vc = UserAccountViewModel.sharedAccountViewModel.userLogon ? ComposeViewController() : OAuthViewController()
    let nav = UINavigationController(rootViewController: vc)
    
    presentViewController(nav, animated: true, completion: nil)
}
```

* 设置背景颜色

```swift
/// 撰写微博控制器
class ComposeViewController: UIViewController {

    override func loadView() {
        view = UIView()
        
        setupUI()
    }
}
```

* 在 `私有 extension` 中实现 `setupUI` 函数

```swift
// MARK: - 设置界面
private extension ComposeViewController {
    
    /// 设置界面
    func setupUI() {
        view.backgroundColor = UIColor.whiteColor()
        
        prepareNavigationBar()
    }
}
```

### 准备导航栏

* 左右按钮

```swift
/// 准备导航栏
private func prepareNavigation() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭",
        style: .Plain,
        target: self,
        action: "close")
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送",
        style: .Plain,
        target: self,
        action: "sendStatus")
    navigationItem.rightBarButtonItem?.enabled = false
}
```

* 监听方法

```swift
// MARK: - 监听方法
/// 关闭
@objc private func close() {
    dismissViewControllerAnimated(true, completion: nil)
}

/// 发布微博
@objc private func sendStatus() {
    print("发布微博")
}
```

* 标题视图

```swift
// 标题栏视图
let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
let titleLabel = UILabel(title: "发微博", fontSize: 15, color: UIColor.darkGrayColor())
let nameLabel = UILabel(title: UserAccountViewModel.sharedUserAccount.account?.screen_name ?? "",
    fontSize: 13,
    color: UIColor.lightGrayColor())

titleView.addSubview(titleLabel)
titleView.addSubview(nameLabel)

titleLabel.snp_makeConstraints { (make) -> Void in
    make.centerX.equalTo(titleView.snp_centerX)
    make.top.equalTo(titleView.snp_top)
}
nameLabel.snp_makeConstraints { (make) -> Void in
    make.centerX.equalTo(titleView.snp_centerX)
    make.bottom.equalTo(titleView.snp_bottom)
}

navigationItem.titleView = titleView
```

### 添加底部工具栏

* 添加素材
* 工具栏懒加载

```swift
/// 工具栏
private lazy var toolbar = UIToolbar()
```

* 添加工具栏

```
/// 准备工具栏
func prepareToolbar() {
    view.addSubview(toolbar)
    
    toolbar.snp_makeConstraints { (make) -> Void in
        make.bottom.equalTo(view.snp_bottom)
        make.left.equalTo(view.snp_left)
        make.right.equalTo(view.snp_right)
        make.height.equalTo(44)
    }
}
```

* 添加按钮

```swift
// 添加工具栏按钮
let itemSettings = [["imageName": "compose_toolbar_picture"],
    ["imageName": "compose_mentionbutton_background"],
    ["imageName": "compose_trendbutton_background"],
    ["imageName": "compose_emoticonbutton_background"],
    ["imageName": "compose_addbutton_background"]]

var items = [UIBarButtonItem]()
for dict in itemSettings {
    let button = UIButton(imageName: dict["imageName"]!, backImageName: "")
    
    items.append(UIBarButtonItem(customView: button))
}

toolbar.items = items
```

* 添加弹簧

```swift
// 添加弹簧
    items.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil))
}
items.removeLast()

toolbar.items = items
```

* 设置背景颜色

```swift
toolbar.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
```

* 添加选择照片函数 

```swift
/// 选择表情
@objc private func selectEmoticon() {
    print("选择表情")
}
```

* 扩展字典

```swift
let itemSettings = [["imageName": "compose_toolbar_picture"],
    ["imageName": "compose_mentionbutton_background"],
    ["imageName": "compose_trendbutton_background"],
    ["imageName": "compose_emoticonbutton_background", "actionName": "selectEmoticon"],
    ["imageName": "compose_addbutton_background"]]
```

* 添加监听方法

```swift
if let actionName = dict["actionName"] {
    button.addTarget(self, action: Selector(actionName), forControlEvents: .TouchUpInside)
}
```

* 修改 UIButton 的便利构造函数 

```swift
/// 便利构造函数
///
/// - parameter imageName:     图像名称
/// - parameter backImageName: 背景图像名称
///
/// - returns: UIButton
convenience init(imageName: String, backImageName: String?) {
    self.init()
    
    setImage(UIImage(named: imageName), forState: .Normal)
    setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
    
    if let backImageName = backImageName {
        setBackgroundImage(UIImage(named: backImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: backImageName + "_highlighted"), forState: .Highlighted)
    }
    
    // 会根据背景图片的大小调整尺寸
    sizeToFit()
}
```

> 使用 `imageName` 创建图像时，如果 imageName == ""，会报 `CUICatalog: Invalid asset name supplied:` 错误

* 代码重构 —— 抽取 `UIBarButtonItem` 扩展

```swift
/// 遍历构造函数
///
/// - parameter imageName:  图像名称
/// - parameter target:     监听对象
/// - parameter actionName: 监听方法名
///
/// - returns: UIBarButtonItem
convenience init(imageName: String, target: AnyObject?, actionName: String?) {
    let button = UIButton(imageName: imageName, backImageName: nil)
    
    if let actionName = actionName {
        button.addTarget(target, action: Selector(actionName), forControlEvents: .TouchUpInside)
    }

    self.init(customView: button)
}
```

* 重构后的代码

```swift
var items = [UIBarButtonItem]()
for dict in itemSettings {
    let item = UIBarButtonItem(imageName: dict["imageName"]!, target: self, actionName: dict["actionName"])
    
    items.append(item)
    
    items.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil))
}

items.removeLast()
toolbar.items = items
```

### 添加 TextView

* 懒加载

```swift
/// 文本视图
private lazy var textView: UITextView = {
    let tv = UITextView()
    
    tv.textColor = UIColor.darkGrayColor()
    tv.font = UIFont.systemFontOfSize(18)
    
    return tv
}()
```

* 准备文本视图

```swift
/// 准备文本视图
private func prepareTextView() {
    view.addSubview(textView)
    
    textView.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(self.snp_topLayoutGuideBottom)
        make.left.equalTo(view.snp_left)
        make.right.equalTo(view.snp_right)
        make.bottom.equalTo(toolbar.snp_top)
    }
    
    textView.text = "分享新鲜事..."
}
```

* 允许始终垂直滚动

```swift
// 允许垂直滚动
tv.alwaysBounceVertical = true
```

* 占位标签懒加载

```swift
/// 占位标签
private lazy var placeHolderLabel = UILabel(title: "分享新鲜事...",
    fontSize: 18, color:
    UIColor.lightGrayColor())
```

* 调整准备文本视图函数

```swift
// 占位标签
textView.addSubview(placeHolderLabel)
placeHolderLabel.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(textView.snp_top).offset(8)
    make.left.equalTo(textView.snp_left).offset(5)
}
```

#### 键盘处理

* 拖动关闭键盘

```swift
tv.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
```

* 关闭按钮

```swift
/// 关闭
@objc private func close() {
    textView.resignFirstResponder()
    
    dismissViewControllerAnimated(true, completion: nil)
}
```

* 激活键盘

```swift
// MARK: - 键盘处理
override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    textView.becomeFirstResponder()
}
```

* 注册&注销键盘通知

```swift
// MARK: - 键盘处理
override func viewDidLoad() {
    super.viewDidLoad()
    
    // 注册键盘通知
    NSNotificationCenter.defaultCenter().addObserver(self,
        selector: "keyboardChanged:",
        name: UIKeyboardWillChangeFrameNotification,
        object: nil)
}

deinit {
    // 注销通知
    NSNotificationCenter.defaultCenter().removeObserver(self)
}

@objc private func keyboardChanged(n: NSNotification) {
    print(n)
}
```

* 键盘通知监听方法

```swift
/// 键盘变化监听方法
@objc private func keyboardChanged(n: NSNotification) {
    print(n)
    
    let duration = (n.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
    let rect = (n.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    
    let offset = -view.bounds.height + rect.origin.y
    toolbar.snp_updateConstraints { (make) -> Void in
        make.bottom.equalTo(view.snp_bottom).offset(offset)
    }
    
    UIView.animateWithDuration(duration) {
        self.view.layoutIfNeeded()
    }
}
```


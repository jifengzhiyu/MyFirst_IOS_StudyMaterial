# 用户登录视图

> 对于第三方开发者，新浪没有开放未登录访问数据的权限，因此在用户登录之前，无法 `加载微博数据` 以及 `关注用户`

## 需求确定

* 用户登录操作视图，用户没有登录时替换表格控制器的根视图
* 每个功能模块的登录视图包含以下四个控件
    * 模块图标
    * 描述文字
    * 注册按钮
    * 登录按钮
* 特例
    * 首页有一个小的转轮图片会不停旋转

## 功能实现

* 拖拽相关图片素材
* 新建 `VisitorLoginView.swift` 继承自 `UIView`

```swift
/// 访客视图
class VisitorLoginView: UIView {

    // MARK: - 设置界面
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    /// 设置界面
    private func setupUI() {

    }
}
```

* 修改 `setupVisitorView` 函数

```swift
// 替换根视图
view = VisitorLoginView()
```

* 添加 `UIImageView` 的便利构造函数

```swift
/// 使用图像名称创建 UIImageView
///
/// - parameter imageName: imageName
///
/// - returns: UIImageView
convenience init(imageName: String) {
    self.init(image: UIImage(named: imageName))
    
    sizeToFit()
}
```

* 添加 `UIButton` 的便利构造函数

```swift
/// 便利构造函数
///
/// - parameter title:         标题
/// - parameter color:         字体颜色
/// - parameter fontSize:      字号
/// - parameter backImageName: 背景图像名称
///
/// - returns: UIButton
convenience init(title: String, color: UIColor, fontSize: CGFloat, backImageName: String) {
    self.init()

    setTitle(title, forState: .Normal)
    setTitleColor(color, forState: .Normal)
    
    titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    
    setBackgroundImage(UIImage(named: backImageName), forState: .Normal)
    setBackgroundImage(UIImage(named: backImageName + "_highlighted"), forState: .Highlighted)
}
```

* 添加界面元素

```swift
/// 设置界面
private func setupUI() {
    // 1. 添加控件
    addSubview(iconView)
    addSubview(homeIconView)
    addSubview(messageLabel)
    addSubview(registerButton)
    addSubview(loginButton)
}

// MARK: - 懒加载控件
/// 图标图片
private lazy var iconView: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_smallicon")
/// 小房子
private lazy var homeIconView: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_house")
/// 描述文字
private lazy var messageLabel: UILabel = {
    let label = UILabel()
    
    label.text = "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜"

    label.sizeToFit()
    
    return label
}()

/// 注册按钮
private lazy var registerButton: UIButton = UIButton(title: "注册", color: UIColor.orangeColor(), fontSize: 14, backImageName: "common_button_white_disable")
/// 登录按钮
private lazy var loginButton: UIButton = UIButton(title: "登录", color: UIColor.darkGrayColor(), fontSize: 14, backImageName: "common_button_white_disable")
```

### 设置自动布局

* 取消 `AutoresizingMask` 属性

```swift
// 2. 自动布局
// 0> 取消 aotoresizing 属性
for v in subviews {
    v.translatesAutoresizingMaskIntoConstraints = false
}
```

* 设置图标约束 - 参照视图居中对齐

```swift
// 1> 图标
addConstraint(NSLayoutConstraint(item: iconView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0))
addConstraint(NSLayoutConstraint(item: iconView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: -60))
```

* 设置首页小房子 - 参照图标居中对齐

```swift
// 2> 小房子
addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .CenterX, relatedBy: .Equal, toItem: iconView, attribute: .CenterX, multiplier: 1.0, constant: 0))
addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .CenterY, relatedBy: .Equal, toItem: iconView, attribute: .CenterY, multiplier: 1.0, constant: 0))
```

* 设置文本 - 参照图标，水平居中，下方 16 个点

```swift
// 3> 描述文字
addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .CenterX, relatedBy: .Equal, toItem: iconView, attribute: .CenterX, multiplier: 1.0, constant: 0))
addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .Top, relatedBy: .Equal, toItem: iconView, attribute: .Bottom, multiplier: 1.0, constant: 16))
```

* 在懒加载函数中设置描述文字属性

```swift
/// 描述文字
private lazy var messageLabel: UILabel = {
    let label = UILabel()
    
    label.text = "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜"
    label.font = UIFont.systemFontOfSize(14)
    label.textColor = UIColor.darkGrayColor()
    label.numberOfLines = 0
    
    label.sizeToFit()
    
    return label
}()
```

* 增加文本宽度约束 - 224，高度约束 - 36

```swift
addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 224))
addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 36))
```

* 注册按钮，文本标签左下(16)对齐，宽度 100，高度 36

```swift
// 4> 注册按钮
addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Left, relatedBy: .Equal, toItem: messageLabel, attribute: .Left, multiplier: 1.0, constant: 0))
addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Top, relatedBy: .Equal, toItem: messageLabel, attribute: .Bottom, multiplier: 1.0, constant: 16))
addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100))
addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 36))
```

* 调整按钮背景图片切片

* 登录按钮，文本标签右下(16)对齐，宽度 100，高度 36

```swift
// 5> 登录按钮
addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Right, relatedBy: .Equal, toItem: messageLabel, attribute: .Right, multiplier: 1.0, constant: 0))
addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Top, relatedBy: .Equal, toItem: messageLabel, attribute: .Bottom, multiplier: 1.0, constant: 16))
addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100))
addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 36))
```

* 调整控件整体垂直位置

```swift
addConstraint(NSLayoutConstraint(item: iconView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: -60))
```

* 抽取 UILabel 的便利构造函数

```swift
/// 遍历构造函数
///
/// - parameter title:    title
/// - parameter fontSize: fontSize
/// - parameter color:    color
///
/// - returns: UILabel
convenience init(title: String, fontSize: CGFloat, color: UIColor) {
    self.init()
    
    text = title
    font = UIFont.systemFontOfSize(fontSize)
    textColor = color
    numberOfLines = 0
    
    sizeToFit()
}
```

* 调整 `messageLabel` 的懒加载代码

```swift
private lazy var messageLabel: UILabel = UILabel(title: "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGrayColor())
```

* 添加遮罩图片视图

```swift
/// 遮罩视图
private lazy var maskIconView: UIImageView = UIImageView(imageName: "visitordiscover_feed_mask_smallicon")
```

```swift
// 1. 添加控件
addSubview(iconView)
addSubview(maskIconView)
addSubview(homeIconView)
...
```

* 遮罩图片自动布局

```swift
// 6. 遮罩视图
addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[maskIconView]-0-|", options: [], metrics: nil, views: ["maskIconView": maskIconView]))
addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[maskIconView]-(regBtnHeight)-[registerButton]", options: [], metrics: ["regBtnHeight": -36], views: ["maskIconView": maskIconView, "registerButton": registerButton]))
```

* 视图背景颜色

```swift
// 3. 设置视图背景颜色
backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
```

> 运行测试


## 小结

* 自动布局核心公式

```swift
view1.attr1 = view2.attr2 * multiplier + constant
```

* 自动布局构造函数

```swift
NSLayoutConstraint(item: 视图, 
    attribute: 约束属性, 
    relatedBy: 约束关系, 
    toItem: 参照视图, 
    attribute: 参照属性, 
    multiplier: 乘积, 
    constant: 约束数值)
```

* 如果指定`宽` `高` 约束
    * 参照视图设置为 `nil`
    * 参照属性选择 `.NotAnAttribute`

* 自动布局类函数

```swift
NSLayoutConstraint.constraintsWithVisualFormat(VLF公式, 
    options: [], 
    metrics: 约束数值字典 [String: 数值], 
    views: 视图字典 [String: 子视图])
```

* VFL 可视化格式语言

    * `H` 水平方向
    * `V` 垂直方向
    * `|` 边界
    * `[]` 包含控件的名称字符串，对应关系在 `views` 字典中定义
    * `()` 定义控件的宽/高，可以在 `metrics` 中指定


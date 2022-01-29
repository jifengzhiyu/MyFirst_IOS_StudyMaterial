# 自定义 cell

## 目标

* 自定义文字微博 Cell
* 利用多个子视图组建微博 Cell
* 动态计算行高

## 单元格分析

微博的单元格包含以下 `6` 种类型：

* 原创微博无图
* 原创微博单图
* 原创微博多图
* 转发微博无图
* 转发微博单图
* 转发微博多图

> 自定义 Cell 中需要注意的

* 单图会按照图片等比例显示
* 多图的图片大小固定
* 多图如果是4张，会按照 `2 * 2` 显示
* 多图其他数量，按照 `3 * 3` 九宫格显示

## 代码实现

### 自定义 Cell

* 建立 `StatusCell` 自定义 `Cell`

```swift
/// 微博 Cell
class StatusCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
}

// MARK: - 设置界面
extension StatusCell {
    
    /// 设置界面
    private func setupUI() {
        
    }
}
```

* 增加视图模型属性

```swift
/// 视图模型
var viewModel: StatusViewModel? {
    didSet {
        
    }
}
```

* 修改 `HomeTableViewController` 的注册 Cell

```swift
/// 准备表格
private func prepareTableView() {
    // 注册 cell
    tableView.registerClass(StatusCell.self, forCellReuseIdentifier: StatusCellNormalId)
    
    // 测试行高
    tableView.rowHeight = 200
}
```

* 修改 `HomeTableViewController` 的数据源方法

```swift
override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier(StatusCellNormalId, forIndexPath: indexPath) as! StatusCell
    
    cell.viewModel = listViewModel.statusList[indexPath.row]
    
    return cell
}
```

### 添加子视图

* 自定义顶部和底部视图
    * `StatusCellTopView`
    * `StatusCellBottomView`

* 定义懒加载控件

```swift
// MARK: - 懒加载控件
/// 顶部信息视图
private lazy var topView: StatusCellTopView = StatusCellTopView()
/// 微博文字
private lazy var contentLabel: UILabel = UILabel(title: "微博文字", fontSize: 15, color: UIColor.darkGrayColor())
/// 底部操作视图
private lazy var bottomView: StatusCellBottomView = StatusCellBottomView()
```

* 添加顶部视图

```swift
/// 设置界面
private func setupUI() {
    
    // 0. 背景颜色
    backgroundColor = UIColor.whiteColor()
    
    // 1. 添加控件
    contentView.addSubview(topView)
    
    // 2. 自动布局
    topView.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(contentView.snp_top)
        make.left.equalTo(contentView.snp_left)
        make.right.equalTo(contentView.snp_right)
        make.height.equalTo(60)
    }
}
```

### 顶部视图布局

* 准备顶部视图

```swift
/// 顶部信息视图
class StatusCellTopView: UIView {

    // 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    
}

// MARK: - 设置界面
extension StatusCellTopView {
    
    private func setupUI() {
        // 0. 背景颜色
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    }
}

```

* 懒加载控件

```swift
// MARK: - 懒加载控件
/// 用户头像
private lazy var iconView: UIImageView = UIImageView(imageName: "avatar_default_big")
/// 姓名标签
private lazy var nameLabel: UILabel = UILabel(title: "我就是刀哥")
/// 会员图标
private lazy var memberIconView: UIImageView = UIImageView(imageName: "common_icon_membership_level1")
/// 认证图标
private lazy var vipIconView: UIImageView = UIImageView(imageName: "avatar_grassroot")
/// 时间标签
private lazy var timeLabel: UILabel = UILabel(title: "刚刚", fontSize: 11, color: UIColor.orangeColor())
/// 来源标签
private lazy var sourceLabel: UILabel = UILabel(title: "黑马微博", fontSize: 11)
```

* 定义间距常量

```swift
/// 微博 Cell 控件间距
let StatusCellMagrin: CGFloat = 12
/// 微博 Cell 头像大小
let StatusIconWidth: CGFloat = 35
```

* 添加控件 & 自动布局

```swift
private func setupUI() {
    // 0. 背景颜色
    backgroundColor = UIColor(white: 0.99, alpha: 1.0)
    
    // 1. 添加控件
    addSubview(iconView)
    addSubview(nameLabel)
    addSubview(memberIconView)
    addSubview(vipIconView)
    addSubview(timeLabel)
    addSubview(sourceLabel)
    
    // 2. 自动布局
    iconView.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(self.snp_top).offset(StatusCellMagrin)
        make.left.equalTo(self.snp_left).offset(StatusCellMagrin)
        make.width.equalTo(StatusIconWidth)
        make.height.equalTo(StatusIconWidth)
    }
    nameLabel.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(iconView.snp_top)
        make.left.equalTo(iconView.snp_right).offset(StatusCellMagrin)
    }
    memberIconView.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(nameLabel.snp_top)
        make.left.equalTo(nameLabel.snp_right).offset(StatusCellMagrin)
    }
    vipIconView.snp_makeConstraints { (make) -> Void in
        make.centerX.equalTo(iconView.snp_right)
        make.centerY.equalTo(iconView.snp_bottom)
    }
    timeLabel.snp_makeConstraints { (make) -> Void in
        make.bottom.equalTo(iconView.snp_bottom)
        make.left.equalTo(iconView.snp_right).offset(StatusCellMagrin)
    }
    sourceLabel.snp_makeConstraints { (make) -> Void in
        make.bottom.equalTo(timeLabel.snp_bottom)
        make.left.equalTo(timeLabel.snp_right).offset(StatusCellMagrin)
    }
}
```

* 设置顶部视图数据

```swift
/// 微博视图模型
var viewModel: StatusViewModel? {
    didSet {
        nameLabel.text = viewModel?.status.user?.screen_name
        
        // TODO: - 设置文字细节
        timeLabel.text = "就是现在"
        sourceLabel.text = "来自 i微博"
    }
}
```

#### 设置用户头像

* 在 `StatusViewModel` 模型中添加 `userProfileUrl` 属性

```swift
/// 用户头像地址
var userProfileUrl: NSURL {
    return NSURL(string: status.user?.profile_image_url ?? "")!
}
/// 用户默认头像
var userDefaultImage: UIImage {
    return UIImage(named: "avatar_default_big")!
}
```

* 在 `StatusCellTopView` 中设置头像

```swift
iconView.sd_setImageWithURL(viewModel?.userProfileUrl, placeholderImage: viewModel?.userDefaultImage)
```

* 在 `StatusViewModel` 模型中添加 `userVipImage` 属性

```swift
/// 用户认证图像 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
var userVipImage: UIImage? {
    switch (status.user?.verified_type ?? -1) {
    case 0: return UIImage(named: "avatar_vip")
    case 2, 3, 5: return UIImage(named: "avatar_enterprise_vip")
    case 220: return UIImage(named: "avatar_grassroot")
    default: return nil
    }
}
```

* 在 `StatusCellTopView` 中设置认证图像

```swift
vipIconView.image = viewModel?.userVipImage
```

* 在 `StatusViewModel` 模型中添加 `userMemberImage`

```swift
/// 会员图标
var userMemberImage: UIImage? {
    if status.user?.mbrank > 0 && status.user?.mbrank < 7 {
        return UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
    }
    return nil
}
```

* 在 `StatusCellTopView` 中设置会员头像

```swift
memberIcon.image = viewModel?.userMemberImage
```

* 移动常量定义到 `StatusCell`

```swift
/// 微博 Cell 控件间距
let StatusCellMagrin: CGFloat = 12
/// 微博 Cell 头像大小
let StatusIconWidth: CGFloat = 35
```

* 修改顶部视图约束

```swift
// 2. 自动布局
topView.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(contentView.snp_top)
    make.left.equalTo(contentView.snp_left)
    make.right.equalTo(contentView.snp_right)
    make.height.equalTo(StatusCellMagrin + StatusIconWidth)
}
```

#### 阶段型小结

* 使用 `视图模型` 封装业务逻辑后，能够简化 `视图` 的代码调用
* `UIImage(named: XXX) ` 建立的图像会被系统缓存，程序员无法销毁，但是非常适用于尺寸小，使用频繁的图像

### 正文文字

* 添加控件并且设置换行宽度

```swift
contentView.addSubview(contentLabel)
contentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 2 * StatusCellMagrin
```

* 自动布局

```swift
contentLabel.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(topView.snp_bottom).offset(StatusCellMagrin)
    make.left.equalTo(contentView.snp_left).offset(StatusCellMagrin)
}
```

* 扩展 `UILabel` 的便利构造函数

```swift
/// 便利构造函数
///
/// - parameter title:          title
/// - parameter fontSize:       fontSize，默认 14 号字
/// - parameter color:          color，默认深灰色
/// - parameter screenInset:    相对屏幕的左右缩进，默认是0
///
/// - returns: UILabel
/// 参数后面的值是参数的默认值，如果不传递，就使用默认值
convenience init(title: String, fontSize: CGFloat = 14, color: UIColor = UIColor.darkGrayColor(), screenInset: CGFloat = 0) {
    self.init()
    
    text = title
    textColor = color
    font = UIFont.systemFontOfSize(fontSize)
    
    numberOfLines = 0
    
    if screenInset > 0 {
        textAlignment = .Left
        preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 2 * screenInset
    } else {
        textAlignment = .Center
    }
}
```

* 修改 `contentLabel` 的懒加载

```swift
/// 微博文字
private lazy var contentLabel: UILabel = UILabel(title: "微博文字",
    fontSize: 15,
    color: UIColor.darkGrayColor(),
    screenInset: StatusCellMagrin)
```

#### 阶段性小结

* 在自动布局中，如果要让 `label` 自动换行，必须要指定 `preferredMaxLayoutWidth`，单纯使用 `左右约束`，自动布局的时候会有计算错误



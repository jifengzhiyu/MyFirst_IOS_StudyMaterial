# 底部视图

* 将素材中的 `home` 拖拽到项目中

* 添加底部视图

```swift
contentView.addSubview(bottomView)
```

* 自动布局

```swift
// 3> 底部视图
bottomView.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
    make.left.equalTo(contentView.snp_left)
    make.right.equalTo(contentView.snp_right)
    make.height.equalTo(44)
    
    // 指定向下的约束
    make.bottom.equalTo(contentView.snp_bottom)
}
```

* `UIButton` extension

```swift
/// 便利构造函数
///
/// - parameter title:     title
/// - parameter fontSize:  fontSize
/// - parameter color:     color
/// - parameter imageName: imageName
///
/// - returns: UIButton
convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String) {
    self.init()
    
    setTitle(title, forState: .Normal)
    setTitleColor(color, forState: .Normal)
    setImage(UIImage(named: imageName), forState: .Normal)
    
    titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    
    sizeToFit()
}
```

* 懒加载控件

```swift
// MARK: - 懒加载控件
/// 转发按钮
private lazy var retweetButton: UIButton = UIButton(title: " 转发",
    fontSize: 12,
    color: UIColor.lightGrayColor(),
    imageName: "timeline_icon_retweet")
/// 评论按钮
private lazy var commentButton: UIButton = UIButton(title: " 评论",
    fontSize: 12,
    color: UIColor.lightGrayColor(),
    imageName: "timeline_icon_comment")
/// 点赞按钮
private lazy var likeButton: UIButton = UIButton(title: " 赞",
    fontSize: 12,
    color: UIColor.lightGrayColor(),
    imageName: "timeline_icon_unlike")
```

* 设置界面

```swift
/// 设置界面
private func setupUI() {
    // 0. 背景颜色
    backgroundColor = UIColor(white: 0.97, alpha: 1.0)
    
    // 1. 添加控件
    addSubview(retweetButton)
    addSubview(commentButton)
    addSubview(likeButton)
    
    // 2. 设置布局
    retweetButton.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(self.snp_top)
        make.left.equalTo(self.snp_left)
        make.bottom.equalTo(self.snp_bottom)
    }
    commentButton.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(retweetButton.snp_top)
        make.left.equalTo(retweetButton.snp_right)
        make.width.equalTo(retweetButton.snp_width)
        make.height.equalTo(retweetButton.snp_height)
    }
    likeButton.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(commentButton.snp_top)
        make.left.equalTo(commentButton.snp_right)
        make.width.equalTo(commentButton.snp_width)
        make.height.equalTo(commentButton.snp_height)
        
        make.right.equalTo(self.snp_right)
    }
}
```

#### 分割线

* 新增函数创建分割线视图

```swift
/// 分隔线视图
private func sepView() -> UIView {
    let v = UIView()
    v.backgroundColor = UIColor.redColor()
    
    return v
}
```

* 添加分割线视图

```swift
let sep1 = sepView()
let sep2 = sepView()
addSubview(sep1)
addSubview(sep2)
```

* 分割线自动视图

```swift
// 3. 分隔线视图
let sepWidth = 0.5
let sepScale = 0.4
sep1.snp_makeConstraints { (make) -> Void in
    make.centerY.equalTo(retweetButton.snp_centerY)
    make.left.equalTo(retweetButton.snp_right)
    make.width.equalTo(sepWidth)
    make.height.equalTo(retweetButton.snp_height).multipliedBy(sepScale)
}
sep2.snp_makeConstraints { (make) -> Void in
    make.centerY.equalTo(retweetButton.snp_centerY)
    make.left.equalTo(commentButton.snp_right)
    make.width.equalTo(sepWidth)
    make.height.equalTo(retweetButton.snp_height).multipliedBy(sepScale)
}
```

### 设置行高

* 在 `HomeTableViewController` 中设置行高

```swift
/// 准备表格
private func prepareTableView() {
    // 注册 cell
    tableView.registerClass(StatusCell.self, forCellReuseIdentifier: StatusCellNormalId)
    
    // 取消分割线
    tableView.separatorStyle = .None
    
    // 设置行高
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableViewAutomaticDimension
}
```

* 设置底部视图的向下约束

```swift
bottomView.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(contentLabel.snp_bottom).offset(WBCellMargin)
    make.left.equalTo(contentView.snp_left)
    make.right.equalTo(contentView.snp_right)
    make.height.equalTo(44)
    make.bottom.equalTo(contentView.snp_bottom)
}
```

#### 阶段性小结

* 使用自动计算行高需要保证两点
    * 设置预估行高 `tableView.estimatedRowHeight = 300`
    * 有一个自上而下布局的控件，设置了底部约束

### 其他细节

* 取消分隔线

```swift
// 取消分隔线
tableView.separatorStyle = .None
```

* 增加 cell 分隔视图

```swift
let sepView = UIView()
sepView.backgroundColor = UIColor.lightGrayColor()
addSubview(sepView)
```

* 修改自动布局

```swift
sepView.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(self.snp_top)
    make.left.equalTo(self.snp_left)
    make.right.equalTo(self.snp_right)
    make.height.equalTo(StatusCellMagrin)
}
iconView.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(sepView.snp_bottom).offset(StatusCellMagrin)
    make.left.equalTo(self.snp_left).offset(StatusCellMagrin)
    make.width.equalTo(StatusIconWidth)
    make.height.equalTo(StatusIconWidth)
}
```

* 修改顶部视图高度

```swift
// 1> 顶部视图
topView.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(contentView.snp_top)
    make.left.equalTo(contentView.snp_left)
    make.right.equalTo(contentView.snp_right)
    make.height.equalTo(2 * StatusCellMagrin + StatusIconWidth)
}
```
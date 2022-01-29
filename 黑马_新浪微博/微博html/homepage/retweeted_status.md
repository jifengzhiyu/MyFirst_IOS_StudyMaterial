# 转发微博

## 阶段性小结 & 下一步目标

### 首页布局开发步骤

* 加载微博数据
* 绑定表格数据
* 扩展用户模型
    * `setValue(value: AnyObject?, forKey key: String)`
    * `description`
* 建立视图模型
* 自定义 Cell
    * 顶部视图
    * 文本标签
    * 底部视图
* 配图视图
    * 在模型中增加 `pic_urls` 字典数组属性
    * 在视图模型中增加 `thumbnailUrls` 属性记录配图 URL
    * 增加配图视图
    * 计算高度
        * 无图
        * 单张图片(临时处理)
        * 4张图片
        * 其他图片
    * 行高 & 行高缓存
    * 设置图片
        * `reloadData`
        * `图片填充模式`

### 下一步目标

* 实现转发微博
* 体会继承在开发中的作用
* 练习修改已经完成的自动布局代码

## 代码实现

### 数据模型准备

* 添加转发微博属性

```swift
/// 被转发的原微博信息字段
var retweeted_status: Status?
```

* 在 `setValue(value: AnyObject?, forKey key: String)` 函数中增加一下代码

```swift
// 2. 判断 key 是否等于 retweeted_status
if key == "retweeted_status" {
    if let dict = value as? [String: AnyObject] {
        retweeted_status = Status(dict: dict)
    }
    return
}
```

* 修改 `description`

```swift
override var description: String {
    let keys = ["id", "created_at", "text", "source", "user", "pic_urls", "retweeted_status"]
    
    return dictionaryWithValuesForKeys(keys).description
}
```

#### 修改视图模型的构造函数

* 利有只有被转发的原创微博中才允许拥有配图的特性

```swift
// 根据模型，来生成缩略图的数组
if let urls = status.retweeted_status?.pic_urls ?? status.pic_urls {
    // 创建缩略图数组
    thumbnailUrls = [NSURL]()
    
    // 遍历字典数组
    for dict in urls {
        guard let url = NSURL(string: dict["thumbnail_pic"]!) else {
            continue
        }
        
        thumbnailUrls?.append(url)
    }
}
```

> 运行测试，转发微博中图像会显示在原创微博中

### 新建 Cell

* 新建 `StatusRetweetedCell` 继承自 `StatusCell`

```swift
/// 转发微博 Cell
class StatusRetweetedCell: StatusCell {

    
}
```

* 在 `HomeTableViewController` 中定义可重用标识符

```swift
/// 原创微博 Cell 的可重用表示符号
let StatusNormalCellId = "StatusNormalCellId"
/// 转发微博 Cell 的可重用标识符号
let StatusRetweetedCellId = "StatusRetweetedCellId"
```

#### 替换成转发微博

* 注册可重用 Cell

```swift
// 注册可重用 cell
tableView.registerClass(StatusRetweetedCell.self, forCellReuseIdentifier: StatusRetweetedCellId)
```

* 数据源方法

```swift
let cell = tableView.dequeueReusableCellWithIdentifier(StatusRetweetedCellId, forIndexPath: indexPath) as! StatusCell
```

* 数据模型中的行高计算

```swift
let cell = StatusRetweetedCell(style: .Default, reuseIdentifier: StatusRetweetedCellId)
```

> 运行测试

#### 添加控件设置布局

* 添加控件

```swift
// MARK: - 懒加载控件
/// 背景图片
private lazy var backButton: UIButton = {
    let button = UIButton()
    
    button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    
    return button
}()
/// 转发微博标签
private lazy var retweetedLabel: UILabel = UILabel(
    title: "转发微博转发微博转发微博转发微博转发微博转发微博转发微博转发微博转发微博",
    fontSize: 14,
    color: UIColor.darkGrayColor(),
    screenInset: StatusCellMargin)
```

* 删除父类 函数 及属性的 `private` 修饰符
    * `setupUI`
    * `contentLabel`
    * `pictureView`
    * `bottomView`

* 重写 setupUI 函数，添加背景按钮

```swift
/// 设置界面
override func setupUI() {
    // 调用父类的 setupUI，设置父类控件位置
    super.setupUI()
    
    // 1. 添加控件
    contentView.insertSubview(backButton, belowSubview: pictureView)
    
    // 2. 自动布局
    backButton.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
        make.left.equalTo(contentView.snp_left)
        make.right.equalTo(contentView.snp_right)
        make.bottom.equalTo(bottomView.snp_top)
    }
}
```

* 添加转发文字

```swift
contentView.insertSubview(retweetedLabel, belowSubview: pictureView)
```

* 设置转发文字标签自动布局

```swift
retweetedLabel.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(backButton.snp_top).offset(StatusCellMargin)
    make.left.equalTo(backButton.snp_left).offset(StatusCellMargin)
}
```

* 注释父类中的 配图视图自动布局代码
* 调整自动布局代码

```swift
// 3> 配图视图
pictureView.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(retweetedLabel.snp_bottom).offset(StatusCellMargin)
    make.left.equalTo(contentView.snp_left).offset(StatusCellMargin)
    make.width.equalTo(300)
    make.height.equalTo(90)
}
```

> 运行测试，控制台报错，原因：设置数据的时候修改了顶部约束

* 注释 `StatusCell` 更新配图约束代码

* 在 `StatusRetweetedCell` 中增加 `视图模型` 并且修改配图视图的高度

```swift
/// 微博视图模型
override var viewModle: StatusViewModel? {
    didSet {
        // 修改配图视图顶部位置
        pictureView.snp_updateConstraints { (make) -> Void in
            // 根据配图数量修改配图视图顶部约束
            let offset = viewModle?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
            make.top.equalTo(retweetedLabel.snp_bottom).offset(offset)
        }
    }
}
```

> 重写 `属性` 不会影响父类属性的 `didSet` 中的代码执行

#### 设置数据

* 在 `StatusViewModel` 中增加 `retweetedText` 属性

```swift
/// 被转发原创微博的文字
var retweetedText: String? {
    guard let s = status.retweeted_status else {
        return nil
    }
    return "@" + (s.user?.screen_name ?? "") + ":" + (s.text ?? "")
}
```

* 设置转发信息

```swift

retweetedLabel.text = viewModel?.retweetedText
```

> 运行测试，可以发现原创微博和转发微博都可以显示了

### 原创微博

* 新建 `StatusNormalCell` 继承自 `StatusCell`
* 重写视图模型属性，将之前注释的代码复制到 `didSet` 中
* 将之前注释的代码复制到 `setupUI()` 函数中

```swift
/// 原创微博 Cell
class StatusNormalCell: StatusCell {

    /// 微博视图模型
    override var viewModle: StatusViewModel? {
        didSet {
            // 修改配图视图大小
            pictureView.snp_updateConstraints { (make) -> Void in
                // 根据配图数量修改配图视图顶部约束
                let offset = viewModle?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
                make.top.equalTo(contentLabel.snp_bottom).offset(offset)
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        // 3> 配图视图
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp_left).offset(StatusCellMargin)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
    }
}
```

#### 整合 Cell

* 注册单元格

```swift
// 注册可重用 cell
tableView.registerClass(StatusNormalCell.self, forCellReuseIdentifier: StatusNormalCellId)
tableView.registerClass(StatusRetweetedCell.self, forCellReuseIdentifier: StatusRetweetedCellId)
```

* 将可重用标识符复制到 `StatusViewModel` 中

```swift
/// 原创微博 Cell 的可重用表示符号
let StatusNormalCellId = "StatusNormalCellId"
/// 转发微博 Cell 的可重用表示符号
let StatusRetweetedCellId = "StatusRetweetedCellId"
```

* 增加计算型属性 `cellId`

```swift
/// 可重用标识符
var cellId: String {
    return status.retweeted_status != nil ? StatusRetweetedCellId : StatusNormalCellId
}
```

* 修改行高属性

```swift
/// 行高
lazy var rowHeight: CGFloat = {
    
    var cell: StatusCell
    
    // 实例化 cell
    if self.status.retweeted_status != nil {
        cell = StatusRetweetedCell(style: .Default, reuseIdentifier: StatusRetweetedCellId)
    } else {
        cell = StatusNormalCell(style: .Default, reuseIdentifier: StatusNormalCellId)
    }
    
    // 返回行高
    return cell.rowHeight(self)
}()
```

* 获取单元格

```swift
override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let vm = listViewModel.statusList[indexPath.row]
    
    let cell = tableView.dequeueReusableCellWithIdentifier(vm.cellId, forIndexPath: indexPath) as! StatusCell
    
    cell.viewModle = vm
    
    return cell
}
```

> 运行测试！

# 配图视图

## 目标

* 增加配图视图
* 动态修改行高
* 行高缓存
* 图片填充模式

## 代码实现

### 界面准备

* 新建 `StatusCellPictureView.swift` 继承自 `UICollectionView`
* 在 `StatusCell` 中定义懒加载属性，并且按照顺序调整控件顺序

```swift
/// 配图视图
private lazy var pictureView: StatusCellPictureView = StatusCellPictureView()
```

> 定义控件时，如果可能，最好按照从上至下，从左至右的顺序定义控件，这样方便后期的维护和扩展

* 在 `setupUI` 函数中添加配图视图

```swift
contentView.addSubview(pictureView)

...

// 3> 配图视图
pictureView.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
    make.left.equalTo(contentView.snp_left).offset(StatusCellMargin)
    make.width.equalTo(300)
    make.height.equalTo(90)
}
// 4> 底部视图
bottomView.snp_makeConstraints { (make) -> Void in
    make.top.equalTo(pictureView.snp_bottom).offset(StatusCellMargin)
    make.left.equalTo(contentView.snp_left)
    make.right.equalTo(contentView.snp_right)
    make.height.equalTo(44)
    
    // 指定向下的约束
    make.bottom.equalTo(contentView.snp_bottom)
}
```

> 运行测试，崩溃！

错误信息：`reason: 'UICollectionView must be initialized with a non-nil layout parameter'`

* 重写 `StatusPictureView` 的构造函数

```swift
/// 微博配图视图
class StatusCellPictureView: UICollectionView {

    // MARK: - 构造函数
    init() {
        let layout = UICollectionViewFlowLayout()
        
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

#### 修改配图视图宽高

* 在 `statusViewModel` 的 didSet 中测试修改高度

```swift
// 测试动态修改行高
pictureView.snp_updateConstraints { (make) -> Void in
    make.height.equalTo(random() % 4 * 90)
}
```

在表格滚动过程中，偶尔会在控制台 `po` 约束错误的情况！应该是 `Label` 行高动态计算的情况导致的

* `临时`修改控制器中表格行高的计算方法

```swift
// 预估行高
tableView.estimatedRowHeight = 300
// 自动计算行高
tableView.rowHeight = 300
```

* 取消 `bottomView` 相对底边的约束

> 在实际开发中，一定先要确认技术的可行性！


### 计算视图大小

* 定义常量

```swift
/// 配图视图格子间距
private let StatusCellPictureItemMargin: CGFloat = 8
```

* 在构造函数中设置布局属性

```swift
layout.minimumInteritemSpacing = StatusCellPictureItemMargin
layout.minimumLineSpacing = StatusCellPictureItemMargin
```

* 在配图视图中定义视图模型属性

```swift
/// 微博视图模型
var viewModle: StatusViewModel? {
    didSet {
        
    }
}
```

* 在 `StatusCell` 的 `statusViewModel` 的 `didSet` 中为配图视图设置视图模型

```swift
pictureView.viewModle = viewModle
// 修改配图视图大小
pictureView.snp_updateConstraints { (make) -> Void in
    make.width.equalTo(pictureView.bounds.width)
    make.height.equalTo(pictureView.bounds.height)
}
```

#### 计算视图大小函数实现

* 调用 `sizeToFit` 函数

```swift
/// 微博视图模型
var viewModle: StatusViewModel? {
    didSet {
        sizeToFit()
    }
}

override func sizeThatFits(size: CGSize) -> CGSize {
    return CGSize(width: 150, height: 120)
}
```

* 常量准备

```swift
// MARK: - 视图大小
extension StatusCellPictureView {
    
    /// 计算视图大小
    private func calcViewSize() -> CGSize {
        
        // 默认每行 3 张图片
        let rowCount: CGFloat = 3
        // collectionView 总宽度
        let maxWidth = UIScreen.mainScreen().bounds.width - 2 * StatusCellMargin
        let itemWidth = (maxWidth - 2 * StatusCellPictureItemMargin) / rowCount
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        // 设置itemSize
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        // 图片数量
        let count = viewModle?.thumbnailUrls?.count ?? 0
    }
}
```

* 一张图片返回该图片的实际大小

```swift
// 1. 单图
if count == 0 {
    return CGSizeZero
}

// 2. 单图
if count == 1 {
    // TODO: - 临时设置单图大小
    return CGSize(width: 150, height: 120)
}
```

* 4 张图片，返回 2 * 2 的大小

```swift
// 3. 四张图，返回 2 * 2
if count == 4 {
    let w = itemWidth * 2 + StatusCellPictureItemMargin
    return CGSize(width: w, height: w)
}
```

* 其他数量

```swift
// 行数
let row = CGFloat((count - 1) / Int(rowCount) + 1)
let w = rowCount * itemWidth + (rowCount - 1) * StatusCellPictureItemMargin
let h = row * itemWidth + (row - 1) * StatusCellPictureItemMargin

return CGSize(width: w, height: h)
```

* 通过设置数据计算视图大小

```swift
override func sizeThatFits(size: CGSize) -> CGSize {
    return calcViewSize()
}
```

### 计算行高

* 计算行高函数

```swift
/// 根据视图模型计算行高
///
/// - parameter viewModel: 视图模型
///
/// - returns: 行高
func rowHeight(vm: StatusViewModel) -> CGFloat {
    // 1. 设置视图模型
    viewModle = vm
    
    // 2. 更新约束
    layoutIfNeeded()
    
    // 3. 返回底部视图的最大高度
    return CGRectGetMaxY(bottomView.frame)
}
```

* 在控制器中实现行高代理方法

```swift
override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    // 1. 获得模型
    let vm = listViewModel.statusList[indexPath.row]
    
    // 2. 实例化 cell
    let cell = StatusCell(style: .Default, reuseIdentifier: StatusCellNormalId)
    
    // 3. 返回行高
    return cell.rowHeight(vm)
}
```

* 根据是否有配图调整顶部约束

```swift
// 根据配图数量修改配图视图顶部约束
let offset = viewModle?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
make.top.equalTo(contentLabel.snp_bottom).offset(offset)
```

#### 行高缓存

* 在 `StatusViewModel` 中添加属性

```swift
/// 行高
lazy var rowHeight: CGFloat = {
    print("计算缓存行高 \(self.status.text)")
    // 实例化 cell
    let cell = StatusCell(style: .Default, reuseIdentifier: StatusCellNormalId)
    
    // 返回行高
    return cell.rowHeight(self)
}()
```

* 修改行高函数

```swift
override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return listViewModel.statusList[indexPath.row].rowHeight
}
```

#### 行高小结

```swift
第一种情况：没有设置预估行高

* 行高方法调用次数，在不同 Xcode 版本中不一样
方法执行顺序
1. 数据行数
2. 行高 - 计算所有行高
3. cell，会再次调用当前行的行高，确认

提问：为什么要算所有行？
tableView 继承自 scrollView，要滚动，需要 contentSize

第一种情况：设置预估行高

1. 数据行数
2. cell，会调用当前行的行高
3. 行高

执行顺序
1. 数据行数 * 预估行高 -> contentSize -> 保证滚动
2. 当滚动时，如果一个 cell 要出现之前，会临时计算行高，并且调整 contentSize

* 补充：如果行高是固定的，坚决不要实现行高代理方法，会严重影响性能！

在开发中，如果动态计算行高，一定要缓存！

```

### 设置图片

* 定义可重用 Cell 标识符

```swift
/// 微博配图视图 Cell 可重用标识符
private let StatusCellPictureViewCellId = "StatusCellPictureViewCellId"
```

* 准备自定义 Cell

```swift
/// 微博配图 Cell
private class StatusCellPictureViewCell: UICollectionViewCell {
    
}
```

* 在构造函数中设置数据源属性 & 注册可重用 Cell

```swift
// MARK: - 构造函数
init() {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = StatusCellPictureItemMargin
    layout.minimumLineSpacing = StatusCellPictureItemMargin
    
    super.init(frame: CGRectZero, collectionViewLayout: layout)
    
    backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    // 注册可重用 cell
    registerClass(StatusCellPictureViewCell.self, forCellWithReuseIdentifier: StatusCellPictureViewCellId)
    // 设置数据源 - 自己重当自己的数据源
    dataSource = self
}
```

* 利用 extension 遵守协议并且实现方法

```swift
// MARK: - UICollectionViewDataSource
extension StatusCellPictureView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModle?.thumbnailUrls?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StatusCellPictureViewCellId, forIndexPath: indexPath) as! StatusCellPictureViewCell
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
}
```

* 刷新数据

```swift
/// 微博视图模型
var viewModle: StatusViewModel? {
    didSet {
        sizeToFit()
        
        reloadData()
    }
}
```

* Cell UI 准备

```swift
/// 微博配图 Cell
private class StatusCellPictureViewCell: UICollectionViewCell {
    
    var imageURL: NSURL? {
        didSet {
            iconView.sd_setImageWithURL(imageURL,
                placeholderImage: nil,
                options: [.RetryFailed, .LowPriority])
        }
    }
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconView)
        iconView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    private lazy var iconView = UIImageView()
}
```

* 返回 Cell，设置图像

```swift
cell.imageURL = viewModle!.thumbnailUrls![indexPath.item]
```

#### 图片填充模式

![](图片填充模式.png)

```swift
private lazy var iconView: UIImageView = {
    let iv = UIImageView()
    
    iv.contentMode = .ScaleAspectFill
    iv.clipsToBounds = true
    
    return iv
}()
```
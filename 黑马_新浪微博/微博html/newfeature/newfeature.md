# 新特性

## 目标

* `collectionView`的使用
* `collectionView`的布局技巧

## 准备文件

* 将新特性图片素材拖拽到 Images.xcsets 中
* 在 `Main` 下建立 `NewFeature` 目录
* 新建 `NewFeatureViewController.swift` 继承自 `UICollectionViewController`
* 在 `NewFeatureViewController.swift` 的末尾添加如下代码：

## 代码实现

### 实现 `init()` 函数简化外部调用

* 修改 `AppDelegate` 的根视图控制器

```swift
window?.rootViewController = NewFeatureViewController()
```

> 运行测试，崩溃！

```
reason: 'UICollectionView must be initialized with a non-nil layout parameter
```

* 原因：实例化 `CollectionViewController` 时必须指定布局参数

* 实现 `init()` 简化外部调用

```swift
// MARK: - 构造函数
init() {
    let layout = UICollectionViewFlowLayout()
    
    super.init(collectionViewLayout: layout)
}

required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
```

#### 小结

* 注意：在 OC 中，不是所有的对象的指定构造函数都是 `init()`
* `NSObject` 的指定构造函数是 `init()`
* `UIViewController` 的指定构造函数是 `initWithNibName`
* `UICollectionViewController` 的指定构造函数是 `initWithViewLayout...`
* `UIView` 的指定构造函数是 `initWithFrame`
* 在查阅头文件时，通常会有 `designated initializer` 标注
* 如果没有 `designated initializer`，可以考虑头文件中的第一个构造函数
* 注意 `layout` 不能写成懒加载

### 数据源

* 定义常量

```swift
/// 可重用标识符
private let WBNewFeatureViewCellID = "WBNewFeatureViewCellID"
/// 新特性图片数量
private let WBNewFeatureCount = 4
```

* 注册可重用 Cell

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    collectionView?.backgroundColor = UIColor.whiteColor()
    // 注册可重用 Cell
    collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: WBNewFeatureViewCellID)
}
```

* 数据源方法

```swift
// MARK: - 数据源方法
extension NewFeatureViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WBNewFeatureCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(WBNewFeatureViewCellID, forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
}
```

### 布局

* 定义布局

```swift
init() {
    let layout = UICollectionViewFlowLayout()

    layout.itemSize = UIScreen.mainScreen().bounds.size
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .Horizontal
    
    super.init(collectionViewLayout: layout)
}
```

* 设置 collectionView 属性

```swfit
override func viewDidLoad() {
    super.viewDidLoad()

    prepareCollectionView()
}

/// 准备 CollectionView
private func prepareCollectionView() {
    collectionView?.backgroundColor = UIColor.whiteColor()
    // 注册可重用 Cell
    collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: WBNewFeatureViewCellID)
    
    collectionView?.pagingEnabled = true
    collectionView?.showsHorizontalScrollIndicator = false
    collectionView?.bounces = false
}
```

#### 小结

* `UICollectionViewController` 中的 `view` 不是 `collectionView`
* 在构造函数之前，`collectionView` 还没有被实例化，因此无法设置属性

### 自定义 Cell

* 定义 `NewFeatureCell`

```swift
/// 新特性 Cell
private class NewFeatureCell: UICollectionViewCell {
    
}
```

#### 阶段性小结

* 在 Swift 和 OC 中都允许在同一个文件中定义多个类的情况
* 以前上课很少用原因时担心影响大家对代码结构的理解，但是实际开发中，这种情况还是比较普遍的
* 一个文件包含多个类的情景
    * 被包含类仅供当前类使用
    * 被包含类的代码很少

### 自定义 Cell 代码实现

* 定义 NewFeatureCell

```swift
// MARK: - 新特性 Cell
private class NewFeatureViewCell: UICollectionViewCell {
    
    var imageIndex: Int = 0 {
        didSet {
            
        }
    }
    
    // MARK: - 设置界面
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconView.frame = bounds
        addSubview(iconView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    private lazy var iconView = UIImageView()
}
```

* 在 Cell 中定义图像索引属性

```swift
/// 图像索引
var imageIndex: Int = 0 {
    didSet {
        iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
    }
}
```

* 修改数据源方法，设置图像

```swift
cell.imageIndex = indexPath.item
```

> 运行测试

* 定义按钮

```swift
/// 开始体验按钮
private lazy var startButton: UIButton = UIButton(title: "开始体验",
    color: UIColor.whiteColor(),
    imageName: "new_feature_finish_button")
```

* 设置按钮布局

```swift
private func setupUI() {
    iconView.frame = bounds
    addSubview(iconView)
    
    addSubview(startButton)
    
    startButton.layer.cornerRadius = 5
    startButton.layer.masksToBounds = true
        
    // 自动布局
    startButton.snp_makeConstraints { (make) -> Void in
        make.centerX.equalTo(snp_centerX)
        make.bottom.equalTo(snp_bottom).multipliedBy(0.7)
    }
}
```

#### 阶段性小结

* 在自定义 `tableViewCell` 和 `collectionViewCell` 时都应该将控件添加到 `contentView` 上
* `collectionViewCell` 的构造函数中的 `frame` 大小取决于 layout 的 itemSize
* 如 `iconView` 这样全屏的控件不需要指定自动布局

### 动画显示 `开始体验` 按钮

* 在 `NewFeatureCell` 中添加 `showStartButton` 函数

```swift
/// 动画显示开始按钮
private func showStartButton() {
    startButton.hidden = false
    startButton.transform = CGAffineTransformMakeScale(0, 0)
    startButton.userInteractionEnabled = false
    
    UIView.animateWithDuration(1.2,         // 动画时长
        delay: 0,
        usingSpringWithDamping: 0.8,        // 弹力系数
        initialSpringVelocity: 10,          // 初始速度
        options: [],                        // 动画选项
        animations: {
            
            self.startButton.transform = CGAffineTransformIdentity
        
        }) { (_)  in
            
            self.startButton.userInteractionEnabled = true
    }
}
```

* 在 `collectionView` 的 `scrollViewDidEndDecelerating` 代理方法中添加以下代码：

```swift
// 滚动视图停止滚动
override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    
    let offset = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    if offset != WBNewFeatureCount - 1 {
        return
    }
    
    // 播放动画
    (collectionView?.visibleCells().last as? NewFeatureViewCell)?.showStartButton()
}
```

### 添加按钮监听方法

* 实现按钮点击方法

```swift
/// 点击启动按钮
@objc private func clickStartButton() {
    print("开始体验")
}
```

* 添加按钮监听方法

```swift
// 添加监听方法
startButton.addTarget(self, action: "clickStartButton", forControlEvents: .TouchUpInside)
```

### 隐藏状态栏

```swift
override func prefersStatusBarHidden() -> Bool {
    return true
}
```

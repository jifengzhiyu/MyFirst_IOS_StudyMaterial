# 准备界面

## 新建表情键盘项目

* 新建 `Emoticon` 目录
* 新建 `EmoticonView.swift` 继承自 `UIView`
* 实现以下代码

```swift
/// 表情键盘视图
class EmoticonView: UIView {

}
```

* 在 `ViewController` 拖拽 `textView` 控件，并且实现以下函数

```swift
/// 表情键盘视图
private lazy var emoticonView: EmoticonView = EmoticonView()

@IBOutlet weak var textView: UITextView!

override func viewDidLoad() {
    super.viewDidLoad()

    textView.inputView = emoticonView
    textView.becomeFirstResponder()
}
```

> 运行测试键盘变化 - 标准键盘高度是 216 个点

## 键盘界面布局

* 将 `SnapKit` 的源代码直接拖拽到项目中

* 懒加载控件

```swift
// MARK: - 懒加载控件
/// 表情集合视图
private lazy var collectionView = UICollectionView(frame: CGRectZero,
    collectionViewLayout: UICollectionViewFlowLayout())
/// 工具栏
private lazy var toolbar = UIToolbar()
```

* 搭建界面

```swift
// MARK: - 设置界面
private extension EmoticonView {
    
    func setupUI() {
        backgroundColor = UIColor.whiteColor()
        
        // 1. 添加控件
        addSubview(collectionView)
        addSubview(toolbar)
        
        // 2. 自动布局
        toolbar.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(36)
        }
        collectionView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(toolbar.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
        }
    }
}
```

> 注意：iPhone 6+ 的屏幕宽度是 414，如果工具栏指定为44，会不方便后续按钮的布局

* 定义工具栏

```swift
/// 准备工具栏
func prepareToolbar() {
    tintColor = UIColor.darkGrayColor()
    
    var items = [UIBarButtonItem]()
    for s in ["最近", "默认", "emoji", "浪小花"] {
        let item = UIBarButtonItem(title: s, style: .Plain, target: self, action: "clickItem:")
        items.append(item)

        items.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil))
    }
    items.removeLast()
    
    toolbar.items = items
}
```

* 工具栏监听方法

```swift
// MARK: - 监听方法
/// 点击工具栏 item
@objc private func clickItem(item: UIBarButtonItem) {
    print(item.tag)
}
```

* 设置监听方法，并通过 `tag` 区分 `item`

```swift
var items = [UIBarButtonItem]()
var index = 0
for s in ["最近", "默认", "emoji", "浪小花"] {
    items.append(UIBarButtonItem(title: s, style: .Plain, target: self, action: "clickItem:"))
    items.last?.tag = index++
    
    items.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil))
}
items.removeLast()
```

### 测试 `collectionView` 的 cell 布局

* 可重用标识符

```swift
/// 可重用标识符号
private let EmoticonViewCellId = "EmoticonViewCellId"
```

* 设置数据源&注册原型 cell

```swift
/// 准备表情集合视图
func prepareCollectionView() {
    collectionView.backgroundColor = UIColor.lightGrayColor()
    
    // 注册 Cell
    collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: EmoticonViewCellId)
    // 指定数据源
    collectionView.dataSource = self
}
```

* 数据源方法实现

```swift
// MARK: - UICollectionViewDataSource
extension EmoticonView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmoticonViewCellId, forIndexPath: indexPath)
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.redColor() : UIColor.greenColor()

        return cell
    }
}
```

* 设置流水布局

```swift
/// 表情键盘视图布局
private class EmoticonViewLayout: UICollectionViewFlowLayout {
    
    private override func prepareLayout() {
        super.prepareLayout()
        
        let col: CGFloat = 7
        let row: CGFloat = 3
        
        let w = collectionView!.bounds.width / col
        let margin = CGFloat(Int((collectionView!.bounds.height - row * w) * 0.5))
        
        itemSize = CGSize(width: w, height: w)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        
        scrollDirection = .Horizontal
        collectionView?.pagingEnabled = true
        collectionView?.bounces = false
    }
}
```

* 修改 `collectionView` 的布局属性

```swift
/// 表情集合视图
private lazy var collectionView = UICollectionView(frame: CGRectZero,
    collectionViewLayout: EmoticonViewLayout())
```

### 确定思路

* 每一个 `cell` 上放置一个表情按钮
* 每个页面显示20个表情
* 最后一个 `cell` 显示删除按钮

### 自定义 Cell

```swift
// MARK: - 表情 Cell
private class EmoticonViewCell: UICollectionViewCell {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(emoticonButton)
        emoticonButton.backgroundColor = UIColor.whiteColor()
        emoticonButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        emoticonButton.frame = CGRectInset(bounds, 4, 4)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    /// 表情按钮
    private lazy var emoticonButton: UIButton = UIButton()
}
```

* 修改数据源方法

```swift
func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmoticonViewCellId, forIndexPath: indexPath) as! EmoticonViewCell
    
    cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.redColor() : UIColor.greenColor()
    cell.emoticonButton.setTitle("\(indexPath.item)", forState: .Normal)

    return cell
}
```

> 注意：当 `collectionView` 的滚动方向是水平时，流水布局的显示是从上到下，从左至右排列的




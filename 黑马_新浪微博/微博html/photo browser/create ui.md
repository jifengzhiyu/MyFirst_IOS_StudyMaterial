# 照片查看器界面搭建

## 准备工作

* 新建 `PhotoBrowser` 文件夹
* 新建 `PhotoBrowserViewController` 控制器 继承自 `UIViewController`

## 构造函数 - 接收数据

```swift
/// 照片查看视图控制器
class PhotoBrowserViewController: UIViewController {

    /// 图像 URL 数组
    var urls: [NSURL]
    /// 选中照片索引
    var selectedIndexPath: NSIndexPath
    
    // MARK: - 构造函数
    init(urls: [NSURL], indexPath: NSIndexPath) {
        self.urls = urls
        self.selectedIndexPath = indexPath
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

* 在 `HomeTableViewController` 加载照片查看视图控制器，并且传递数据

```swift
// 注册通知
NSNotificationCenter.defaultCenter().addObserverForName(WBStatusSelectedPhotoNotification,
    object: nil,
    queue: nil) { [weak self] (n) -> Void in
        
        guard let urls = n.userInfo?[WBStatusSelectedPhotoURLKey] as? [NSURL] else {
            return
        }
        guard let indexPath = n.userInfo?[WBStatusSelectedPhotoIndexPathKey] as? NSIndexPath else {
            return
        }
        
        let vc = PhotoBrowserViewController(urls: urls, indexPath: indexPath)
        self?.presentViewController(vc, animated: true, completion: nil)
}
```

> 此处需要注意循环引用！

## 搭建界面

* 在 `UIButton+Extension` 中扩展便利构造函数

```swift
/// 便利构造函数
///
/// - parameter title:     title
/// - parameter color:     color
/// - parameter fontSize:  字体大小
/// - parameter imageName: 图像名称
/// - parameter backColor: 背景颜色
///
/// - returns: UIButton
convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String?, backColor: UIColor? = nil) {
    self.init()
    
    setTitle(title, forState: .Normal)
    setTitleColor(color, forState: .Normal)
    
    if let imageName = imageName {
        setImage(UIImage(named: imageName), forState: .Normal)
    }
    
    titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    backgroundColor = backColor
    
    sizeToFit()
}
```

* 懒加载控件

```swift
// MARK: - 懒加载控件
/// collectionView
private var collectionView: UICollectionView = UICollectionView(frame: CGRectZero,
    collectionViewLayout: UICollectionViewFlowLayout())
/// 关闭按钮
private var closeButton: UIButton = UIButton(title: "关闭",
    fontSize: 14,
    color: UIColor.whiteColor(),
    imageName: nil,
    backColor: UIColor.darkGrayColor())
/// 保存按钮
private var saveButton: UIButton = UIButton(title: "保存",
    fontSize: 14,
    color: UIColor.whiteColor(),
    imageName: nil,
    backColor: UIColor.darkGrayColor())
```

* 设置界面

```swift
override func loadView() {
    let rect = UIScreen.mainScreen().bounds
    
    view = UIView(frame: rect)
    
    setupUI()
}
```

* 设置界面扩展

```swift
// MARK: - 设置界面
private extension PhotoBrowserViewController {
    
    private func setupUI() {
        // 1. 添加控件
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        
        // 2. 控件布局
        collectionView.frame = view.bounds
        
        closeButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-8)
            make.left.equalTo(view.snp_left).offset(8)
            make.size.equalTo(CGSize(width: 100, height: 36))
        }
        saveButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-8)
            make.right.equalTo(view.snp_right).offset(-8)
            make.size.equalTo(CGSize(width: 100, height: 36))
        }
    }
}
```

* 按钮监听方法

```swift
// MARK: - 监听方法
/// 关闭
@objc private func close() {
    dismissViewControllerAnimated(true, completion: nil)
}

/// 保存照片
@objc private func save() {
    print("保存照片")
}
```

* 添加按钮监听

```swift
// 3. 监听方法
closeButton.addTarget(self, action: "close", forControlEvents: .TouchUpInside)
saveButton.addTarget(self, action: "save", forControlEvents: .TouchUpInside)
```

## 数据源方法

* 定义可重用标识符号常量

```swift
/// 可重用标识符号
private let PhotoBrowserViewCellId = "PhotoBrowserViewCellId"
```

* 定义 照片查看 Cell

```swift
// MARK: - 照片查看 Cell
private class PhotoBrowserCell: UICollectionViewCell {
    
}
```

* 设置数据源

```swift
// 4. 准备控件
    prepareCollectionView()
}

/// 准备 CollectionView
private func prepareCollectionView() {
    // 1. 设置数据源
    collectionView.dataSource = self
    
    // 2. 注册可重用 cell
    collectionView.registerClass(PhotoBrowserCell.self, forCellWithReuseIdentifier: PhotoBrowserViewCellId)
}
```

* 利用 `extension` 扩展数据源方法

```swift
// MARK: - UICollectionViewDataSource
extension PhotoBrowserViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserViewCellId, forIndexPath: indexPath) as! PhotoBrowserCell
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
}
```

* 设置布局

```swift
// MARK: - 照片浏览视图布局
private class PhotoBrowserViewLayout: UICollectionViewFlowLayout {
    
    private override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = collectionView!.bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0

        scrollDirection = .Horizontal
        
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
    }
}
```

* 添加 `UIColor+Extension`

```swift
extension UIColor {
    
    /// 随机颜色
    class func randomColor() -> UIColor {
        
        let r = CGFloat(random() % 256) / 255
        let g = CGFloat(random() % 256) / 255
        let b = CGFloat(random() % 256) / 255
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
```

* 数据源方法

```swift
cell.backgroundColor = UIColor.randomColor()
```


# 选择照片

## 目标

* 在独立的项目中开发独立的功能
* 开发完毕后再整合到现有项目中
* 提高工作效率，专注开发品质 😄
* 选择照片
* 重建控件布局

## 项目准备

* 新建空白项目
* 删除无用文件
    * ViewController.swift
    * Main.storyboard
* 修改启动选项，删除 Main
* 新建文件夹 `PicturePicker`
* 新建 `PicturePickerController` 继承自 `UICollectionViewController`
* 在 `AppDelegate` 添加以下代码

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window?.backgroundColor = UIColor.whiteColor()
    window?.rootViewController = PictureSelectorViewController()

    window?.makeKeyAndVisible()
    
    return true
}
```

> 运行测试

## 代码实现

### 设置布局

* 添加控制器构造函数，简化外部调用

```swift
/// 可重用标识符
private let PicturePickerViewId = "PicturePickerViewId"

// MARK: - 照片选择控制器
class PicturePickerController: UICollectionViewController {

    // MARK: - 构造函数
    init() {
        let layout = UICollectionViewFlowLayout()
        
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 注册可重用 Cell
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: PicturePickerViewId)
    }
}
```

* 设置背景颜色

```swift
collectionView?.backgroundColor = UIColor.whiteColor()
```

> 注意在 `CollectionViewController` 中，`collectionView` 不是 `view`

* 修改数据源方法

```swift
// MARK: - 数据源方法
extension PicturePickerController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PicturePickerViewId, forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
}
```

* 设置 cell 尺寸

```swift
// 照片选择视图布局
private class PicturePickerLayout: UICollectionViewFlowLayout {
    private override func prepareLayout() {
        super.prepareLayout()
        
        let m: CGFloat = UIScreen.mainScreen().scale * 4
        let count: CGFloat = 4
        
        let w = (collectionView!.bounds.width - (count + 1) * m) / count
        
        itemSize = CGSize(width: w, height: w)
        minimumInteritemSpacing = 0
        minimumLineSpacing = m
        
        sectionInset = UIEdgeInsets(top: m, left: m, bottom: 0, right: m)
    }
}
```

* 修改 构造函数 

```swift
init() {
    super.init(collectionViewLayout: PicturePickerLayout())
}
```

### 自定义 Cell

* 添加素材
* 将 `Tools/Extension` 目录拖拽到项目中
* 将 `SnapKit` 的 `Source` 文件夹拖拽到项目中

* 自定义 Cell

```swift
// MARK: - 照片选择 Cell
private class PicturePickerCell: UICollectionViewCell {
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置界面
    private func setupUI() {
        // 1. 添加控件
        contentView.addSubview(addButton)
        contentView.addSubview(removeButton)
        
        // 2. 自动布局
        addButton.frame = bounds
        removeButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(snp_top)
            make.right.equalTo(snp_right)
        }
    }
    
    // MARK: - 懒加载控件
    /// 添加照片按钮
    private lazy var addButton = UIButton(imageName: "compose_pic_add", backImageName: nil)
    /// 删除照片啊扭
    private lazy var removeButton = UIButton(imageName: "compose_photo_close", backImageName: nil)
}
```

* 修改注册的 Cell

```swift
// 注册可重用 Cell
collectionView!.registerClass(PicturePickerCell.self, forCellWithReuseIdentifier: PicturePickerViewId)
```

* 修改数据源

```swift
let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PicturePickerViewId, forIndexPath: indexPath) as! PicturePickerCell
```

* 按钮监听方法

```swift
// MARK: - 监听方法
/// 添加照片
@objc private func addPhoto() {
    print("添加照片")
}

/// 删除照片
@objc private func removePhoto() {
    print("删除照片")
}
```

* 添加监听方法

```swift
// 3. 监听方法
addButton.addTarget(self, action: "addPhoto", forControlEvents: .TouchUpInside)
removeButton.addTarget(self, action: "removePhoto", forControlEvents: .TouchUpInside)
```

### 利用代理传递按钮点击事件

* 定义协议传递消息

```swift
// MARK: - 照片选择 Cell 代理方法
@objc
private protocol PicturePickerCellDelegate: NSObjectProtocol {
    /// 添加照片
    optional func picturePickerCellDidAdd(cell: PicturePickerCell)
    /// 删除照片
    optional func picturePickerCellDidRemove(cell: PicturePickerCell)
}
```

* 设置代理

```swift
/// 照片选择代理
weak var pictureDelegate: PicturePickerCellDelegate?
```

* 修改监听方法

```swift
// MARK: - 监听方法
/// 添加照片
@objc private func addPhoto() {
    pictureDelegate?.picturePickerCellDidAdd?(self)
}

/// 删除照片
@objc private func removePhoto() {
    pictureDelegate?.picturePickerCellDidRemove?(self)
}
```

* 在数据源方法中设置代理

```swift
cell.pictureDelegate = self
```

* 在 `extension` 中实现协议方法

```swift
// MARK: - PicturePickerCellDelegate
extension PicturePickerController: PicturePickerCellDelegate {
    // 添加照片
    @objc private func picturePickerCellDidAdd(cell: PicturePickerCell) {
        print("添加照片")
    }
    
    // 删除照片
    @objc private func picturePickerCellDidRemove(cell: PicturePickerCell) {
        print("删除照片")
    }
}
```

> 注意：如果协议是私有的，那么协议方法也必须是私有的

### 选择照片

* 判断是否支持访问相册

```swift
// 添加照片
@objc private func picturePickerCellDidAdd(cell: PicturePickerCell) {
    
    // 判断是否支持访问照片库
    if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
        print("不允许访问照片库")
        return
    }
    
}
```

* 访问相册

```swift
// 访问相册
let picker = UIImagePickerController()

presentViewController(picker, animated: true, completion: nil)
```

* 设置代理

```swift
// 设置代理
picker.delegate = self
```

* 遵守协议并实现方法

```swift
// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension PictureSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// 选中媒体代理方法
    ///
    /// - parameter picker: 照片选择器
    /// - parameter info:   信息字典 allowsEditing = true 适合选择头像
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print(info)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
```

> 注意：一旦实现了代理方法，则需要用代码 `dismiss` 控制器

#### 设置图片数据源

* 定义照片数组

```swift
/// 照片数组
lazy var pictures = [UIImage]()
```

* 在代理方法中插入照片

```swift
let image = info[UIImagePickerControllerOriginalImage] as! UIImage
pictures.append(image)

collectionView?.reloadData()

dismissViewControllerAnimated(true, completion: nil)
```

* 在 cell 中添加 `image` 属性

```swift
/// 照片图像
private var image: UIImage? {
    didSet {
        addButton.setImage(image, forState: .Normal)
    }
}
```

* 修改数据源中的图像数量函数

```swift
override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pictures.count + 1
}
```

> 保证末尾有一个加号按钮添加照片

* 在数据源方法中设置图像

```swift
cell.image = (indexPath.item < pictures.count) ? pictures[indexPath.item] : nil
```

* 扩展 `image` 属性的 `didSet` 函数

```swift
/// 照片
/// 照片图像
private var image: UIImage? {
    didSet {
        addButton.setImage(image ?? UIImage(named: "compose_pic_add"), forState: .Normal)
    }
}
```

### 细节处理

#### 记录用户点击按钮的索引

* 定义当前选中照片索引

```swift
/// 当前选中照片索引
private var currentIndex = 0
```

* 在代理方法中记录当前用户点击 cell 的索引

```swift
// 记录当前选中照片索引
currentIndex = collectionView!.indexPathForCell(cell)!.item
```

* 在照片选择控制器的代理方法中设置对应的图像

```swift
if currentIndex < pictures.count {
    pictures[currentIndex] = image
} else {
    pictures.append(image)
}

collectionView?.reloadData()
```

#### 设置照片填充模式

```swift
// 4. 照片按钮填充模式
addButton.imageView?.contentMode = .ScaleAspectFill
```

#### 删除照片

* 删除照片操作

```swift
// 删除照片
@objc private func picturePickerCellDidRemove(cell: PicturePickerCell) {
    
    let indexPath = collectionView!.indexPathForCell(cell)!
    
    if indexPath.item >= pictures.count {
        return
    }
    
    pictures.removeAtIndex(indexPath.item)
    collectionView?.deleteItemsAtIndexPaths([indexPath])
}
```

* 默认隐藏删除按钮

```swift
/// 照片图像
private var image: UIImage? {
    didSet {
        addButton.setImage(image ?? UIImage(named: "compose_pic_add"), forState: .Normal)
        
        removeButton.hidden = (image == nil)
    }
}
```

#### 设置最多选择照片数量

* 定义最多照片常量

```swift
/// 最大选择照片数量
private let PicturePickerMaxCount = 9
```

* 修改数据源方法

```swift
// MARK: 数据源
override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pictures.count + (pictures.count == PicturePickerMaxCount ? 0 : 1)
}
```

### 内存处理

* 缩放图片

```swift
extension UIImage {
    
    /// 将当前照片缩放到指定宽度
    ///
    /// - parameter width: 指定宽度 － 如果当前照片宽度已经小于指定宽度，直接返回
    /// - returns: 等比例缩放后的图像
    func scaleToWidth(width: CGFloat) -> UIImage {
        
        // 1. 判断宽度
        if size.width < width {
            return self
        }
        
        // 2. 计算比例
        let height = size.height * width / size.width
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        // 3. 绘制图像
        // 1> 开启上下文
        UIGraphicsBeginImageContext(rect.size)
        
        // 2> 绘制图像
        drawInRect(rect)
        
        // 3> 获得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        // 4> 关闭上下问
        UIGraphicsEndImageContext()
        
        // 5> 返回结果
        return result
    }
}
```

* 修改照片选择控制器代理方法

```swift
/// 选中媒体代理方法
///
/// - parameter picker: 照片选择器
/// - parameter info:   信息字典 allowsEditing = true 适合选择头像
func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    let scaleImage = image.scaleToWidth(600)

    if currentIndex < pictures.count {
        pictures[currentIndex] = scaleImage
    } else {
        pictures.append(scaleImage)
    }

    collectionView?.reloadData()

    dismissViewControllerAnimated(true, completion: nil)
}
```

## 整合照片选择控制器

### 准备 文件

* 将 `PicturePicker` 拖拽至项目
* 将 `UIImage+Extension.swift` 拖拽至项目

### 整合照片选择控制器

* 定义控制器属性

```swift
/// 照片选择控制器
private lazy var picturePickerController = PicturePickerController()
```

* 准备照片视图

```swift
/// 准备照片选择器
private func preparePicker() {
    // 1. 添加控制器视图
    view.addSubview(picturePickerController.view)
    
    // 2. 自动布局
    picturePickerController.view.snp_makeConstraints { (make) -> Void in
        make.bottom.equalTo(view.snp_bottom)
        make.left.equalTo(view.snp_left)
        make.right.equalTo(view.snp_right)
        make.height.equalTo(view.snp_height).multipliedBy(0.6)
    }
}
```

> 运行测试，发现选中照片结束后，提示错误：

Presenting view controllers on detached view controllers is discouraged 

* 添加子控制器

```swift
// 0. 添加子控制器
addChildViewController(picturePickerController)
```

* 修改照片选择视图层次

```swift
// 添加视图
view.insertSubview(pictureSelectorViewController.view, belowSubview: toolbar)
```

> 运行会发现照片选择视图跑到了 textView 和 toolBar 的后面

#### 重建控件布局

* 修改照片选择视图的高度

```swift
make.height.equalTo(0)
```

* 在选择照片监听方法中重建控件索引

```swift
/// 选择照片
@objc private func selectPicture() {
    textView.resignFirstResponder()
    
    // 1. 判断是否约束是否已经修改
    if picturePickerController.view.bounds.height > 0 {
        return
    }
    
    // 2. 修改照片视图约束
    picturePickerController.view.snp_updateConstraints { (make) -> Void in
        make.height.equalTo(view.bounds.height * 0.6)
    }
    // 3. 重建textView视图约束
    textView.snp_remakeConstraints { (make) -> Void in
        make.top.equalTo(self.snp_topLayoutGuideBottom)
        make.left.equalTo(view.snp_left)
        make.right.equalTo(view.snp_right)
        make.bottom.equalTo(picturePickerController.view.snp_top)
    }
    
    UIView.animateWithDuration(0.5) { () -> Void in
        self.view.layoutIfNeeded()
    }
}
```

* 关闭键盘

```swift
textView.resignFirstResponder()
```

* 在 `setupUI` 函数取消自动调整滚动视图缩紧

```swift
// 2. 取消滚动视图的自动缩进
automaticallyAdjustsScrollViewInsets = false
```

> 运行测试

* 调整 `viewDidAppear` 如果已经显示照片选择视图，则不再激活键盘

```swift
// 根据配图视图决定是否激活键盘
if picturePickerController.view.bounds.height == 0 {
    textView.becomeFirstResponder()
}
```

* 发布图片

```swift
/// 发布微博
@objc private func sendStatus() {

    // 1. 获取文本内容
    let text = textView.emoticonText
    
    // 2. 发布微博
    SVProgressHUD.show()
    NetworkTools.sharedTools.sendStatus(text, image: picturePickerController.pictures.last) { (result, error) -> () in
        
        if error != nil {
            print("出错了")
            SVProgressHUD.showInfoWithStatus("您的网络不给力")
            return
        }

        SVProgressHUD.showInfoWithStatus("发布成功")
        delay(0.25) {
            self.close()
        }
    }
}
```

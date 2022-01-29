# 下拉&上拉刷新

## 目标

* 自定义下拉控件
* 步骤
    * 测试原生的下拉控件
    * 通过头文件的线索，探索自定义控件的思路
    * 自定义控件

## 代码实现

### 测试原生下拉刷新控件

* 代码演示创建 `UIRefreshControl`

```swift
refreshControl = UIRefreshControl()
refreshControl?.backgroundColor = UIColor.redColor()
refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
printLog(refreshControl?.frame)
```

> 刷新控件的高度是 60

* 代码演示向 `UIRefreshControl` 添加视图

```swift
let v = UIView(frame: refreshControl!.bounds)
v.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
refreshControl?.addSubview(v)
```

* 隐藏转轮

```swift
refreshControl?.tintColor = UIColor.clearColor()
```

* 修改 `loadData` 函数，完成数据加载后，关闭刷新控件

```swift
/// 加载数据
@objc private func loadData() {
    
    self.refreshControl?.beginRefreshing()
    listViewModel.loadStatus { (error) -> () in
        self.refreshControl?.endRefreshing()
        
        if error != nil {
            SVProgressHUD.showInfoWithStatus("您的网路不给力")
            return
        }
        
        // 刷新表格
        self.tableView.reloadData()
    }
}
```

> 通过测试发现，自定义 `UIRefreshControl` 成为可能！

### 自定义刷新控件

* 新建 `WBRefreshControl` 继承自 `UIRefreshControl`

```swift
/// 下拉刷新控件
class WBRefreshControl: UIRefreshControl {

    // MARK: - 构造函数
    override init() {
        super.init()
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    private func setupUI() {
        
    }
}
```

* 导入素材 & 自定义 XIB
* 自定义刷新视图

```swift

/// 微博刷新视图 - 负责刷新动画显示
class WBRefreshView: UIView {
    
    /// 加载 XIB
    class func refreshView() -> WBRefreshView {
        
        let nib = UINib(nibName: "WBRefreshView", bundle: nil)
        
        return nib.instantiateWithOwner(nil, options: nil).last as! WBRefreshView
    }
}
```

* 设置刷新控件子视图

```swift
/// 设置界面
private func setupUI() {
    // 0. 清空转轮颜色
    tintColor = UIColor.clearColor()

    // 1. 添加控件
    addSubview(refreshView)
    
    // 2. 自动布局
    refreshView.snp_makeConstraints { (make) -> Void in
        make.centerX.equalTo(self.snp_centerX)
        make.centerY.equalTo(self.snp_centerY)
        make.size.equalTo(refreshView.bounds.size)
    }
}

// MARK: - 懒加载控件
private lazy var refreshView = WBRefreshView.refreshView()
```

> 注意：从 XIB 加载的视图默认大小就是在 XIB 中指定的大小，但是在设定自动布局的时候，需要使用这个 `size` 指定宽高约束

#### KVO 观察 frame

* 注册监听

```swift
// KVO 监听 frame 变化
addObserver(self, forKeyPath: "frame", options: [], context: nil)
```

* 注销监听

```swift
deinit {
    removeObserver(self, forKeyPath: "frame")
}
```

* 监听方法

```swift
// MARK: - KVO函数
override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    
    printLog(frame)
}
```

* 观察结果
    * 向下拉：y 值，逐渐变小
    * 当表格向上滚动，刷新控件是一只存在的，不会被销毁
    * 当 y 值足够小的时候，自动进入刷新状态

* 修改 KVO 监听方法，主线程异步执行

```swift
// 3. KVO 监听
dispatch_async(dispatch_get_main_queue()) {
    self.addObserver(self, forKeyPath: "frame", options: [], context: nil)
}
```

> 主队列的特点是：如果主线程有任务，就不会调度队列中的任务执行！

#### 提示箭头旋转动画

* 定义下拉刷新偏移量

```swift
/// 下拉刷新动画偏移量
private let WBRefreshControlOffset: CGFloat = -60
```

* 提示箭头旋转逻辑

```swift
/// 箭头旋转标记
private var rotateFlag = false
override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    
    if frame.origin.y > 0 { return }

    if frame.origin.y < WBRefreshControlOffset && !rotateFlag {
        print("翻过来")
        rotateFlag = true
    } else if frame.origin.y >= WBRefreshControlOffset && rotateFlag {
        print("转过去")
        rotateFlag = false
    }
}
```

* 代码连线

```swift
/// 旋转提示图标
@IBOutlet weak var tipIconView: UIImageView!
```

* 旋转刷新标记图片

```swift
/// 旋转提示图标
private func rotateTipIcon() {
    
    UIView.animateWithDuration(0.5) {
        self.tipIconView.transform = CGAffineTransformRotate(self.tipIconView.transform, CGFloat(M_PI))
    }
}
```

* 定义 `rotateFlag` 翻转标记属性

```swift
/// 旋转标记
private var rotateFlag = false {
    didSet {
        rotateTipIcon()
    }
}
```

* 调整 KVO 方法

```swift
if frame.origin.y < WBRefreshControlOffset && !refreshView.rotateFlag {
    print("翻过来")
    refreshView.rotateFlag = true
} else if frame.origin.y > WBRefreshControlOffset && refreshView.rotateFlag {
    print("转过去")
    refreshView.rotateFlag = false
}
```

> 运行测试，发现始终按照顺时针方向旋转，这是因为 iOS 的块代码旋转会按照就近原则处理

```swift
/// 旋转提示图标
private func rotateTipIcon() {
    
    var angle = CGFloat(M_PI)
    angle += rotateFlag ? -0.001 : 0.001
    
    UIView.animateWithDuration(0.5) {
        self.tipIconView.transform = CGAffineTransformRotate(self.tipIconView.transform, angle)
    }
}
```

#### 播放&停止加载动画

* 代码连线

```swift
/// 提示视图
@IBOutlet weak var tipView: UIView!
/// 加载图标
@IBOutlet weak var loadingIcon: UIImageView!
```

* 函数准备

```swift
/// 开始动画
private func startAnimation() {
    tipView.hidden = true
    
    let anim = CABasicAnimation(keyPath: "transform.rotation")
    
    anim.toValue = 2 * M_PI
    anim.repeatCount = MAXFLOAT
    anim.duration = 20
    
    loadingIcon.layer.addAnimation(anim, forKey: nil)
}

/// 停止动画
private func stopAnimation() {
    tipView.hidden = false
    
    loadingIcon.layer.removeAllAnimations()
}
```

* 条件判断

```swift
if refreshing {
    refreshView.startLoadingAnim()
    return
}
```

> 运行测试，会发现动画越来越快——只要滚动表格，就会调用 KVO 监听方法，导致旋转动画被重复添加到图标上

* 调整动画代码

```swift
/// 开始动画
private func startAnimation() {
    
    let keyPath = "transform.rotation"
    if let _ = loadingIcon.layer.animationForKey(keyPath) {
        return
    }
    
    tipView.hidden = true
    
    let anim = CABasicAnimation(keyPath: keyPath)
    
    anim.toValue = 2 * M_PI
    anim.repeatCount = MAXFLOAT
    anim.duration = 0.5
    anim.removedOnCompletion = false
    
    loadingIcon.layer.addAnimation(anim, forKey: keyPath)
}
```

* 重写 `endRefreshing` & `beginRefreshing` 函数

```swift
// MARK: - 重写结束刷新函数
override func endRefreshing() {
    super.endRefreshing()
    
    refreshView.stopAnimation()
}

override func beginRefreshing() {
    super.beginRefreshing()
    
    refreshView.startAnimation()
}
```

> beginRefreshing() 只会开启刷新控件的动作，但是不会主动触发监听方法


## 小结

如果工作中遇到自定义下拉刷新的情况，可以根据实际需求，修改 `WBRefreshView.xib` 以及相关动画方法即可

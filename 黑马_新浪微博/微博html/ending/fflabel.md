# FFLabel

## 安装

* 修改 `Podfile`

```
# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

pod 'Alamofire'
pod 'SDWebImage'
pod 'SVProgressHUD'
pod 'SnapKit'
pod 'FFLabel'
```

* 在终端升级 cocoapod

```bash
$ pod update --no-repo-update
```

## 使用

* 添加 FFLabel
* 修改 `StatusCell` 中的 `contentLabel`

```swift
/// 微博正文标签
lazy var contentLabel: FFLabel = FFLabel(title: "微博正文",
    fontSize: 15,
    color: UIColor.darkGrayColor(),
    screenInset: StatusCellMargin)
```

* 修改 `StatusRetweetedCell` 中的 `retweetedLabel`

```swift
/// 转发标签
private lazy var retweetedLabel: FFLabel = FFLabel(
    title: "转发微博",
    fontSize: 14,
    color: UIColor.darkGrayColor(),
    screenInset: StatusCellMargin)
```

> 运行测试

### 监听超链接点击

* 在 `setupUI` 函数中增加代理

```swift
// 3. 设置 label 的代理
contentLabel.labelDelegate = self
```

* 实现代理方法

```swift
// MARK: - FFLabelDelegate
extension StatusCell: FFLabelDelegate {
    
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        print(text)
    }
}
```

* 在 `StatusRetweetedCell` 的 `setupUI` 函数中增加代理

```swift
// 3. 设置代理
retweetedLabel.labelDelegate = self
```

> 运行测试

### 通过协议传递点击事件

* 定义协议

```swift
// MARK: - 微博 Cell 协议
protocol StatusCellDelegate: NSObjectProtocol {
    /// 微博 Cell 点击 url 链接
    func statusCellClickURL(url: NSURL)
}
```

* 定义代理属性

```swift
/// Cell 代理
weak var cellDelegate: StatusCellDelegate?
```

* 扩展代理方法

```swift
// MARK: - FFLabelDelegate
extension StatusCell: FFLabelDelegate {
    
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        print(text)
        
        if text.hasPrefix("http://") {
            guard let url = NSURL(string: text) else {
                return
            }
            cellDelegate?.statusCellDidClickUrl(url)
        }
    }
}
```

* 在首页实现代理方法

```swift
extension HomeTableViewController: StatusCellDelegate {
    
    func statusCellDidClickUrl(url: NSURL) {
        print(url)
    }
}
```

* 新建 `HomeWebViewController`

```swift
class HomeWebViewController: UIViewController {

    private var url: NSURL
    private lazy var webView = UIWebView()
    
    init(url: NSURL) {
        self.url = url
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = webView
        
        title = "网页"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(NSURLRequest(URL: url))
    }
}
```

* 扩展 `statusCellDidClickUrl` 函数

```swift
func statusCellClickURL(url: NSURL) {
    
    let vc = HomeWebViewController(url: url)
    vc.hidesBottomBarWhenPushed = true
    
    navigationController?.pushViewController(vc, animated: true)
}
```

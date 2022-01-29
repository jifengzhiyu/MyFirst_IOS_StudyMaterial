# 加载授权页面

## 目标

* 通过浏览器访问新浪授权页面，获取授权码

### 接口文档

http://open.weibo.com/wiki/Oauth2/authorize

* 测试授权 URL

https://api.weibo.com/oauth2/authorize?client_id=479651210&redirect_uri=http://itheima.com

> 注意：回调地址必须与注册应用程序保持一致

## 功能实现

### 准备工作

* 新建 `OAuth` 文件夹
* 新建 `OAuthViewController.swift` 继承自 `UIViewController`

#### 加载 OAuth 视图控制器

* 修改 `BaseTableViewController` 中用户登录部分代码

```swift
/// 用户登录
@objc private func visitorViewDidLogin() {
    let nav = UINavigationController(rootViewController: OAuthViewController())
    
    presentViewController(nav, animated: true, completion: nil)
}
```

* 在 `OAuthViewController` 中添加以下代码

```swift
/// OAuth 授权控制器
class OAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    // MARK: - 监听方法
    /// 关闭
    @objc private func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - 设置界面
    override func loadView() {
        view = webView
        
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "close")
    }
}
```

> 运行测试

### 加载授权页面

* 在 `NetworkTools` 中定义应用程序授权相关信息

```swift
// MARK: - 应用程序信息
/// 应用程序 ID
private let appKey      = "3995771732"
/// 应用程序秘钥
private let appSecret   = "c7b253a8381da34eb612a190fee5d100"
/// OAuth 重定向地址
private let redirectUri = "http://www.baidu.com"
```

* 新增 `extension` 分隔 `OAuth` 相关代码

```
// MARK: - OAuth 相关方法
extension NetworkTools {
    
    /// OAuth 授权地址
    /// - see: [http://open.weibo.com/wiki/Oauth2/authorize](http://open.weibo.com/wiki/Oauth2/authorize)
    var oauthUrl: NSURL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUri)"
        
        return NSURL(string: urlString)!
    }
}
```

* 在 `info.plist` 中增加 `ATS` 设置

```xml
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>
```

* 加载授权页面

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    // 加载授权页面
    webView.loadRequest(NSURLRequest(URL: NetworkTools.sharedTools.oauthURL))
}
```

### 自动填充

* 在 `loadView` 中添加`自动填充`按钮

```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .Plain, target: self, action: "autoFill")
```

* 实现自动填充代码

```swift
/// 自动填充
@objc private func autoFill() {
    let js = "document.getElementById('userId').value = 'daoge10000@sina.cn';" +
        "document.getElementById('passwd').value = 'qqq123';"
    
    webView.stringByEvaluatingJavaScriptFromString(js)
}
```

* 实现代理方法，跟踪重定向 URL

```swift
// MARK: - UIWebView 代理方法
/// 是否加载请求
///
/// - parameter webView:        webView
/// - parameter request:        要加载的请求
/// - parameter navigationType: 导航类型
///
/// - returns: 是否加载当前请求
func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    print(request)

    return true
}
```

* 结果分析
    * 如果 URL 以回调地址开始，需要检查查询参数
    * 其他 URL 均加载

* 修改代码

```swift
// 1. 判断请求地址是否是百度，如果不是，继续加载
guard let url = request.URL where url.host == "www.baidu.com" else {
    print("继续加载 \(request)")
    return true
}

// 2. 判断请求地址的查询参数中是否包含 code=
guard let query = url.query where query.hasPrefix("code=") else {
    print("取消")
    return false
}

// 3. 从查询字符串中取出授权码
let code = query.substringFromIndex("code=".endIndex)
print("授权码 - " + code)

return false
```

### 加载指示器

* 导入 `SVProgressHUD`

```swift
import SVProgressHUD
```

* WebView 代理方法

```swift
func webViewDidStartLoad(webView: UIWebView) {
    SVProgressHUD.show()
}

func webViewDidFinishLoad(webView: UIWebView) {
    SVProgressHUD.dismiss()
}

func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
    // 判断是否因为用户中断
    if error?.code == 102 {
        SVProgressHUD.dismiss()
    } else {
        SVProgressHUD.showInfoWithStatus("您的网络不给力")
    }
}
```


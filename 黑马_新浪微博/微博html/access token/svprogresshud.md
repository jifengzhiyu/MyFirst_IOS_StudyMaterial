# SVProgressHUD

## 目标

* 熟悉 SVProgressHUD 的使用
* 掌握 `dispatch_after` 在 Swift 中的写法

## 代码实现

* 在 `OAuthViewController` 中增加 `webView` 的代理方法实现

```swift
/// 开始加载
func webViewDidStartLoad(webView: UIWebView) {
    SVProgressHUD.show()
}

/// 加载结束
func webViewDidFinishLoad(webView: UIWebView) {
    SVProgressHUD.dismiss()
}
```

* 修改 `colse()` 函数，关闭指示器

```swift
// MARK: - 监听方法
@objc private func close() {
    SVProgressHUD.dismiss()
    dismissViewControllerAnimated(true, completion: nil)
}
```

* 在用户取消授权时，关闭控制器

```swift
// 2. 从百度地址的 url 中提取 `code=` 是否存在
guard let query = url.query where query.hasPrefix("code=") else {
    close()
    return false
}
```

* 登录失败后利用 dispatch_delay 提示并且关闭视图控制器

```swift
// 4. 加载 accessToken & 用户信息
UserAccountViewModel.sharedUserAccount.loadAccessToke(code) { (isSuccessed) -> () in
    
    if !isSuccessed {
        SVProgressHUD.showInfoWithStatus("登录失败")
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)), dispatch_get_main_queue()) {
            self.close()
        }
    } else {
        SVProgressHUD.showInfoWithStatus("登录成功")
        print("成功了")
    }
}
```

* 在 `Common.swift` 中增加 `dalay` 函数

```swift
/// 延迟执行函数
///
/// - parameter delta:    延迟描述
/// - parameter callFunc: 执行的函数
func delay(delta: NSTimeInterval, callFunc: ()->()) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delta * NSTimeInterval(NSEC_PER_SEC))), dispatch_get_main_queue()) {
        
        callFunc()
    }
}
```

* 修改 延迟操作调用

```swift
// 4. 加载 accessToken & 用户信息
UserAccountViewModel.sharedUserAccount.loadAccessToke(code) { (isSuccessed) -> () in
    
    if !isSuccessed {
        SVProgressHUD.showInfoWithStatus("登录失败")
        delay(1.0) {
            self.close()
        }
    } else {
        SVProgressHUD.showInfoWithStatus("登录成功")
        print("成功了")
    }
}
```
# 发布文本微博

## 文字输入处理

* 取消默认文本内容
* 设置 `textView` 代理

```swift
tv.delegate = self
```

* 实现代理方法

```swift
// MARK: - UITextViewDelegate
extension ComposeViewController: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        placeHolderLabel.hidden = textView.hasText()
    }
}
```

* 问题，如果选择表情符号，不会触发代理方法

* 在 `UITextView+Extension` 的 `insertEmoticon` 末尾主动调用代理方法

```swift
// 5. 调用代理方法
delegate?.textViewDidChange?(self)
```

## 发布文字微博

### 接口定义

#### 文档地址

http://open.weibo.com/wiki/2/statuses/update

#### 接口地址

https://api.weibo.com/2/statuses/update.json

#### HTTP 请求方式

* POST

#### 请求参数

| 参数 | 说明 |
| -- | -- |
| access_token | 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得 |
| status | 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字 |

> 连续两次发布的微博不可以重复

* 在 NetworkTools 中添加发布微博方法

```swift
// MARK: - 发布微博
extension NetworkTools {
    
    /// 发布微博
    ///
    /// - parameter status:   微博文字
    /// - parameter finished: 完成回调
    /// - see: [http://open.weibo.com/wiki/2/statuses/update](http://open.weibo.com/wiki/2/statuses/update)
    func sendStatus(status: String, finished: HMRequestCallBack) {
        
        // 1. 获取 token 字典
        guard var params = tokenDict else {
            
            // 如果字典为 nil，通知调用方，token 无效
            finished(result: nil, error: NSError(domain: "cn.itcast.error", code: -1001, userInfo: ["message": "token 为空"]))
            
            return
        }
        params["status"] = status

        // 2. 准备网络参数
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        
        // 3. 发起网络请求
        request(.POST, URLString: urlString, parameters: params, finished: finished)
    }
}
```

* 在 `ComposeViewController` 中测试发布微博

```swift
/// 发布微博
@objc private func sendStatus() {
    
    let text = textView.emoticonText
    
    NetworkTools.sharedTools.sendStatus(text) { (result, error) -> () in
        
        if error != nil {
            SVProgressHUD.showInfoWithStatus("您的网络不给力", maskType: .Gradient)
            return
        }
        
        print(result)
        self.close()
    }
}
```


# 发布微博

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

## 封装 token 

* 新建方法 `tokenRequest`

```swift
/// 使用 Token 发起网络请求
///
/// - parameter method:     method GET / POST
/// - parameter urlString:  urlString
/// - parameter parameters: 参数字典
/// - parameter finished:   完成回调
private func tokenRequest(method: RequestMethod, urlString: String, parameters: [String: AnyObject]?, finished: RequestFinishedCallBack) {
    
}
```

* 代码实现

```swift
private func tokenRequest(method: RequestMethod, urlString: String, var parameters: [String: AnyObject]?, finished: RequestFinishedCallBack) {
    
    // 1. 获取 token
    guard let token = UserAccountViewModel.sharedAccountViewModel.userAccount?.access_token else {
        finished(result: nil, error: NSError(domain: "cn.itcast.error", code: -1002, userInfo: ["message": "token 为 nil"]))
        return
    }
    
    // 2. 判断字典是否为空
    if parameters == nil {
        parameters = [String: AnyObject]()
    }
    parameters!["access_token"] = token
    
    // 3. 发起网络请求
    request(method, urlString: urlString, parameters: parameters, finished: finished)
}
```

* 删除 `tokenParams` 属性
* 修改 发布微博 方法

```swift
func postStatus(status: String, finished: RequestFinishedCallBack) {
    
    // 1. 参数字典
    var params = [String: AnyObject]()
    
    // 2. 微博
    params["status"] = status
    
    // 2. 发起网络请求
    tokenRequest(.POST, urlString: "https://api.weibo.com/2/statuses/update.json", parameters: params, finished: finished)
}
```

* 修改 加载微博 方法

```swift
func loadStatus(since_id since_id: Int, max_id: Int, finished: RequestFinishedCallBack) {

    // 1. 参数字典
    var params = [String: AnyObject]()

    // 2. 处理刷新参数
    if since_id > 0 {       // 下拉刷新
        params["since_id"] = since_id
    } else if max_id > 0 {  // 上拉刷新
        params["max_id"] = max_id - 1
    }
    
    // 3. 发起网络请求
    tokenRequest(.GET, urlString: "https://api.weibo.com/2/statuses/home_timeline.json", parameters: params, finished: finished)
}
```

* 修改 加载用户 方法

```swift
func loadUserInfo(uid: String, finished: RequestFinishedCallBack) {
    
    // 1. 建立 token 字典
    var params = [String: AnyObject]()
    
    // 2. 向字典中增加参数
    params["uid"] = uid
    
    // 2. 发起网络请求
    tokenRequest(.GET, urlString: "https://api.weibo.com/2/users/show.json", parameters: params, finished: finished)
}
```

> 运行测试！

## 发布图片微博

### 接口定义

#### 文档地址

http://open.weibo.com/wiki/2/statuses/upload

#### 接口地址

https://upload.api.weibo.com/2/statuses/upload.json

#### HTTP 请求方式

* POST

#### 请求参数

| 参数 | 说明 |
| -- | -- |
| access_token | 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得 |
| status | 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字 |
| pic | 要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M |

> 请求必须用POST方式提交，并且注意采用multipart/form-data编码方式

* 添加 `upload` 函数

```swift
/// 上传文件
///
/// - parameter urlString:  urlString
/// - parameter data:       图像
/// - parameter parameters: 参数字典
/// - parameter finished:   完成回调
private func upload(urlString: String, data: NSData, var parameters: [String: AnyObject]?, finished: RequestFinishedCallBack) {

    // 1. 获取 token
    guard let token = UserAccountViewModel.sharedAccountViewModel.userAccount?.access_token else {
        finished(result: nil, error: NSError(domain: "cn.itcast.error", code: -1002, userInfo: ["message": "token 为 nil"]))
        return
    }
    
    // 2. 判断字典是否为空
    if parameters == nil {
        parameters = [String: AnyObject]()
    }
    parameters!["access_token"] = token
    
    // 3. 上传文件
    POST(urlString, parameters: parameters, constructingBodyWithBlock: { (formData) -> Void in
        
        formData.appendPartWithFileData(data, name: "pic", fileName: "xxoo", mimeType: "application/octet-stream")
        
        }, success: { (_, result) in
            finished(result: result, error: nil)
        }) { (_, error) in
            print(error)
            finished(result: nil, error: error)
    }
}
```

* 修改发布微博函数

```swift
/// 发布微博
///
/// - parameter status:   微博文字
/// - parameter finished: 完成回调
/// - see: [发布文本微博](http://open.weibo.com/wiki/2/statuses/update)
/// - see: [发布图片微博](http://open.weibo.com/wiki/2/statuses/upload)
func postStatus(status: String, image: UIImage?, finished: RequestFinishedCallBack) {
    
    // 1. 参数字典
    var params = [String: AnyObject]()
    
    // 2. 微博
    params["status"] = status
    
    // 3. 发起网络请求
    // 1> 判断是否是文本微博
    if image == nil {
        tokenRequest(.POST, urlString: "https://api.weibo.com/2/statuses/update.json", parameters: params, finished: finished)
    } else {
        let data = UIImagePNGRepresentation(image!)!
        
        upload("https://upload.api.weibo.com/2/statuses/upload.json", data: data, parameters: params, finished: finished)
    }
}
```

* 修改控制器中的发布微博函数

```swift
/// 发布微博
@objc private func sendStatus() {
    
    let status = textView.text
    
    SVProgressHUD.show()
    NetworkTools.sharedTools.postStatus(status,
        image: pictureSelectorViewController.pictures.last) { (result, error) -> () in
        
        if error != nil {
            SVProgressHUD.showInfoWithStatus("您的网络不给力")
            return
        }
        
        SVProgressHUD.dismiss()
        print(result)
        self.close()
    }
}
```

## 文字长度处理

* 定义微博文字最大长度常量

```swift
/// 最大文本
private let WBStatusTextMaxLength = 10
```

* 发布微博前检查文字长度

```swift
// 检查文本长度
if status.characters.count > WBStatusTextMaxLength {
    SVProgressHUD.showInfoWithStatus("输入的文本过长", maskType: .Gradient)
    return
}
```

## 长度提示标签

* 定义长度提示标签

```swift
/// 长度提示标签
private lazy var lengthTipLabel: UILabel = UILabel(title: "0",
    color: UIColor.lightGrayColor(),
    fontSize: 12)
```

* 添加控件&设置布局

```swift
// 长度提示标签
view.addSubview(lengthTipLabel)
lengthTipLabel.snp_makeConstraints { (make) -> Void in
    make.right.equalTo(view.snp_right).offset(-WBStatusCellMargin)
    make.bottom.equalTo(textView.snp_bottom).offset(-WBStatusCellMargin)
}
```

* 在代理方法中设置提示标签内容

```swift
let len = WBStatusTextMaxLength - textView.text.characters.count
lengthTipLabel.text = String(len)
lengthTipLabel.textColor = len >= 0 ? UIColor.lightGrayColor() : UIColor.redColor()
```

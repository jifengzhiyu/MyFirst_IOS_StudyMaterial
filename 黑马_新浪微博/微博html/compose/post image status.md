# 发布图片微博

## 接口定义

### 文档地址

http://open.weibo.com/wiki/2/statuses/upload

### 接口地址

https://upload.api.weibo.com/2/statuses/upload.json

### HTTP 请求方式

* POST

### 请求参数

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
/// - parameter URLString:  URLString
/// - parameter data:       要上传的二进制数据
/// - parameter name:       服务器字段
/// - parameter parameters: 参数字典
/// - parameter finished:   完成回调
private func upload(URLString: String, data: NSData, name: String, var parameters: [String: AnyObject]?, finished: HMRequestCallBack) {
    
    // 1. 判断 token 是否有效
    if !appendToken(&parameters) {
        // 如果 token 为 nil，通知调用方，token 无效
        finished(result: nil, error: NSError(domain: "cn.itcast.error", code: -1001, userInfo: ["message": "token 为空"]))
        
        return
    }
    
    // 2. 发起网络请求
    POST(URLString, parameters: parameters, constructingBodyWithBlock: { (formData) -> Void in
        
        formData.appendPartWithFileData(data, name: name, fileName: "OMG", mimeType: "application/octet-stream")
        
        }, success: { (_, result) -> Void in
            finished(result: result, error: nil)
        }) { (_, error) -> Void in
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
/// - parameter image:    微博配图
/// - parameter finished: 完成回调
/// - see: [http://open.weibo.com/wiki/2/statuses/update](http://open.weibo.com/wiki/2/statuses/update)
/// - see: [http://open.weibo.com/wiki/2/statuses/upload](http://open.weibo.com/wiki/2/statuses/upload)
func sendStatus(status: String, image: UIImage?, finished: HMRequestCallBack) {
    
    // 1. 参数字典
    let params = ["status": status]

    if image == nil {
        // 2. 准备网络参数
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        
        // 3. 发起网络请求
        tokenRequest(.POST, URLString: urlString, parameters: params, finished: finished)
    } else {
        // 2. 准备网络参数
        let urlString = "https://upload.api.weibo.com/2/statuses/upload.json"
        let data = UIImagePNGRepresentation(image!)!
        
        // 3. 发起网络请求
        upload(urlString, data: data, name: "pic", parameters: params, finished: finished)
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


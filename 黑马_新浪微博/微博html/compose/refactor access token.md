# 抽取 access_token

* 新建方法 `tokenRequest`

```swift
/// 发起带 token 带网络请求
///
/// - parameter method:     GET / POST
/// - parameter URLString:  URLString
/// - parameter parameters: 参数字典
/// - parameter finished:   完成回调
private func tokenRequest(method: HMRequestMethod, URLString: String, parameters: [String: AnyObject]?, finished: HMRequestCallBack) {
    
}
```

* 代码实现

```swift
/// 发起带 token 带网络请求
///
/// - parameter method:     GET / POST
/// - parameter URLString:  URLString
/// - parameter parameters: 参数字典
/// - parameter finished:   完成回调
private func tokenRequest(method: HMRequestMethod, URLString: String, var parameters: [String: AnyObject]?, finished: HMRequestCallBack) {
    
    // 1. 判断 token 是否有效
    guard let token = UserAccountViewModel.sharedUserAccount.accessToken else {
        // 如果 token 为 nil，通知调用方，token 无效
        finished(result: nil, error: NSError(domain: "cn.itcast.error", code: -1001, userInfo: ["message": "token 为空"]))
        
        return
    }
    
    // 2. 判断参数字典
    if parameters == nil {
        parameters = [String: AnyObject]()
    }
    
    // 3. 设置 token
    parameters!["access_token"] = token
    
    // 4. 发起网络请求
    request(method, URLString: URLString, parameters: parameters, finished: finished)
}
```

## 进一步抽取 token 处理

* 实现 `appendToken` 函数

```swift
/// 生成并监测 token 字典
///
/// - parameter parameters: 参数字典
///
/// - returns: 是否成功
private func appendToken(inout parameters: [String: AnyObject]?) -> Bool {
    // 1. 判断 token 是否有效
    guard let token = UserAccountViewModel.sharedUserAccount.accessToken else {
        return false
    }
    
    // 2. 判断参数字典
    if parameters == nil {
        parameters = [String: AnyObject]()
    }
    
    // 3. 设置 token
    parameters!["access_token"] = token
    
    return true
}
```

* 修改 `tokenRequest` 函数

```swift
/// 发起带 token 带网络请求
///
/// - parameter method:     GET / POST
/// - parameter URLString:  URLString
/// - parameter parameters: 参数字典
/// - parameter finished:   完成回调
private func tokenRequest(method: HMRequestMethod, URLString: String, var parameters: [String: AnyObject]?, finished: HMRequestCallBack) {
    
    // 1. 判断 token 是否有效
    if !appendToken(&parameters) {
        // 如果 token 为 nil，通知调用方，token 无效
        finished(result: nil, error: NSError(domain: "cn.itcast.error", code: -1001, userInfo: ["message": "token 为空"]))
        
        return
    }
    
    // 2. 发起网络请求
    request(method, URLString: URLString, parameters: parameters, finished: finished)
}
```

* 删除 `tokenDict` 属性，哪里出错改哪里


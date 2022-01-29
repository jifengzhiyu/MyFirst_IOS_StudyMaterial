# 加载 Access Token

## 目标

* 使用请求码从网络加载 `AccessToken`

## 代码实现

* 在 `NetworkTools` 中增加函数加载 `AccessToken`

```swift
/// 加载 Token
/// - parameter code: 授权码
/// - see: [http://open.weibo.com/wiki/OAuth2/access_token](http://open.weibo.com/wiki/OAuth2/access_token)
func loadAccessToken(code: String, finished: RequestCallBack) {
    
    let urlString = "https://api.weibo.com/oauth2/access_token"
    
    let params = ["client_id": appKey,
        "client_secret": appSecret,
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": redirectUri]
    
    request(.POST, URLString: urlString, parameters: params, finished: finished)
}
```

* 在 `OAuthViewController` 中获取授权码成功后调用网络方法

```swift
print("授权码 - " + code)

NetworkTools.sharedTools.loadAccessToken(code) { (result, error) -> () in
    if error != nil {
        print("出错了")
        return
    }
    
    print(result)
}
```

> 运行测试

* 返回错误信息

```
Error Domain=com.alamofire.error.serialization.response Code=-1016 "Request failed: unacceptable content-type: text/plain"
```

* 在 `单例` 方法中增加反序列化格式

```swift
/// 网络工具单例
static let sharedTools: NetworkTools = {
    
    let tools = NetworkTools(baseURL: nil)
    
    // 设置反序列化数据格式
    tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
    
    return tools
}()
```

## 小结

* 使用 `typealias` 可以统一和简化闭包的定义和传递
* 使用 `baseURL` 能够简化网络访问方法中 URL 的传递
* AFN 访问方法最常见的错误
    * `status code == 200`，但是提示 `unacceptable content-type`，表示网络访问正常，但是无法对返回数据做反序列化
    * 解决办法：增加 反序列化数据 格式
* 另外一个常见错误
    * `status code == 405`，不支持的网络请求方法，检查 GET / POST 是否写错 
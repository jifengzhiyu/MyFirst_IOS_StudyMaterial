# 加载用户信息

## 目标

* 通过 `AccessToken` 获取用户信息，体会如何使用 `Token` 获取网络数据

## 接口定义

### 文档地址

http://open.weibo.com/wiki/2/users/show

### 接口地址

https://api.weibo.com/2/users/show.json

### HTTP 请求方式

* GET

### 请求参数

| 参数 | 描述 |
| -- | -- |
| access_token | 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得 |
| uid | 需要查询的用户ID |

### 返回数据

| 返回值字段 | 字段说明 |
| -- | -- |
| name | 友好显示名称 |
| avatar_large | 用户头像地址（大图），180×180像素 |

### 测试 URL

https://api.weibo.com/2/users/show.json?access_token=2.00ml8IrF0qLZ9W5bc20850c50w9hi9&uid=5365823342

## 代码实现

* 在 `NetworkTools` 中封装 GET 方法

```swift
// MARK: - 用户信息
extension NetworkTools {
    
    /// 加载用户信息
    ///
    /// - parameter uid:         uid
    /// - parameter accessToken: accessToken
    /// - parameter finished:    完成回调
    /// - see: [http://open.weibo.com/wiki/2/users/show](http://open.weibo.com/wiki/2/users/show)
    func loadUserInfo(uid: String, accessToken: String, finished: HMRequestCallBack) {
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        let params = ["uid": uid,
            "access_token": accessToken]
        
        request(.GET, URLString: urlString, parameters: params, finished: finished)
    }
}
```

* 在 `OAuthViewController` 中增加 `loadUserInfo` 函数加载用户信息

```swift
/// 加载用户信息
///
/// - parameter account: 用户账户
private func loadUserInfo(account: UserAccount) {
    
    NetworkTools.sharedTools.loadUserInfo(account.uid!, accessToken: account.access_token!) { (result, error) -> () in
        print(result)
    }
}
```

* 在 `OAuthViewController` 中修改网络代码

```swift
// 4. 加载 accessToken
NetworkTools.sharedTools.loadAccessToken(code) { (result, error) -> () in
    
    // 1> 判断错误
    if error != nil {
        print("出错了")
        return
    }
    
    // 2> 创建用户账户
    let account = UserAccount(dict: result as! [String: AnyObject])
    
    // 3> 加载账户信息
    self.loadUserInfo(account)
}
```

> 注意：在 Swift 中，闭包中输入代码的智能提示非常不好，因此新建一个函数单独处理加载用户功能

### 扩展用户模型 

* 在 `UserAccount` 中增加用户名和头像属性

```swift
/// 用户昵称
var screen_name: String?
/// 用户头像地址（大图），180×180像素
var avatar_large: String?
```

* 扩展 `description` 中的属性

```swift
override var description: String {
    let keys = ["access_token", "expires_in", "expiresDate", "uid", "screen_name", "avatar_large"]
    
    return dictionaryWithValuesForKeys(keys).description
}
```

* 修改加载用户模型网络方法

```swift
/// 加载用户信息
///
/// - parameter account: 用户账户
private func loadUserInfo(account: UserAccount) {
    
    NetworkTools.sharedTools.loadUserInfo(account.uid!, accessToken: account.access_token!) { (result, error) -> () in
        
        if error != nil {
            return
        }
        
        guard let dict = result as? [String: AnyObject] else {
            return
        }
        
        account.screen_name = dict["screen_name"] as? String
        account.avatar_large = dict["avatar_large"] as? String

        print(account)
    }
}
```

> 每一个令牌授权一个 `特定的网站` 在 `特定的时段内` 访问 `特定的资源`



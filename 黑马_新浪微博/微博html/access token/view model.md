# 视图模型

## 目标

* 管理当前登录用户的账户信息
* 加载归档保存的用户账户信息，避免重复从沙盒加载
* 用户登录判断
* 抽取网络请求代码
* 调整网络代码，简化 token 的调用

## 代码实现

### 视图模型单例

```swift
/// 用户账户视图模型
class UserAccountViewModel {
    /// 用户账户
    var userAccount: UserAccount?
}
```

* 在 Swift 中，新建类时，可以不继承 `NSObject`，这样类的量级更轻
* 不继承 `NSObject` 的对象不能使用 `KVC` 方法，因此模型数据不适合这种方法
* 但是对于封装业务逻辑的视图模型而言确实非常和事

### 加载用户账户信息

```swift
/// 归档保存路径
private var accountPath: String {
    let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
    return (path as NSString).stringByAppendingPathComponent("account.plist")
}

// MARK: - 构造函数
init() {
    // 从沙盒加载用户账户信息
    userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
}
```

* 在 `AppDelegate` 中输出用户账户信息

```swift
print(UserAccountViewModel().userAccount)
```

### token 过期处理

* 添加过期处理计算型属性

```swift
/// 是否过期
private var isExpired: Bool {
    if userAccount?.expiresDate?.compare(NSDate()) == NSComparisonResult.OrderedDescending {
        return false
    }
    return true
}
```

* 修改构造函数

```swift
// MARK: - 构造函数
init() {
    // 从沙盒加载用户账户信息
    userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
    
    // 如果帐号已经过期，清空帐号，要求用户重新登录
    if isExpired {
        userAccount = nil
    }
}
```

#### 小结

* `date.compare(NSDate())` 是指定日期与当前系统日期进行比较，如果晚于当前系统日期，比较结果为降序

### 判断用户是否登录

* 修改 `VisitorTableViewController` 中的用户登录标记

```swift
/// 用户登录标记
private var userLogon = (UserAccountViewModel().userAccount?.access_token != nil)
```

* 在 `视图模型` 中增加计算型属性

```swift
/// 用户登录标记
var userLogon: Bool {
    return (userAccount?.access_token != nil) && !isExpired
}
```

* 再次修改 `VisitorTableViewController` 中的用户登录标记

```swift
/// 用户登录标记
private var userLogon = UserAccountViewModel().userLogon
```

#### 小结

* 计算型属性类似与函数，区别如下：
    * 不能接参数
    * 必须有返回值
    * 代码的语义更加清晰，便于阅读

### 问题

如果每次都实例化用户账户视图模型，意味着每次都要从沙盒加载归档保存文件，而在计算机开发中，通常磁盘读写的效率相比内存读写要慢很多！如何提升性能？

解决思路：

* 建立用户账户视图模型的单例

#### 代码调整

* 在 `UserAccountViewModel` 中增加单例静态常量

```swift
/// 用户账户视图模型单例
static let sharedUserAccount = UserAccountViewModel()
```

* 修改构造函数 

```swift
// MARK: - 构造函数
private init() {
    // 从沙盒加载用户账户信息
    userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
    
    // 如果帐号已经过期，清空帐号，要求用户重新登录
    if isExpired {
        userAccount = nil
    }
}
```

> 在 init() 之前增加 `private` 会限制只允许通过单例访问对象

* 修改 `AppDelegate` 中的代码调用

```swift
print(UserAccountViewModel.sharedUserAccount.userAccount)
```

* 修改 `VisitorTableViewController` 中的代码调用

```swift
private var userLogon = UserAccountViewModel.sharedUserAccount.userLogon
```

### 抽取网络请求代码

* 抽取网络请求代码

```swift
// MARK: - 网络业务逻辑方法
extension UserAccountViewModel {
    
    /// 加载 AccessToken
    ///
    /// - parameter code: 授权码
    func loadAccessToke(code: String, fininsed: (isSuccessed: Bool) -> ()) {
        // 4. 加载 accessToken
        NetworkTools.sharedTools.loadAccessToken(code) { (result, error) -> () in
            
            // 1> 判断错误
            if error != nil {
                fininsed(isSuccessed: false)
                return
            }
            
            // 2> 记录用户账户属性
            self.userAccount = UserAccount(dict: result as! [String: AnyObject])
            
            // 3> 加载账户信息
            self.loadUserInfo(self.userAccount!, fininsed: fininsed)
        }
    }
    
    /// 加载用户信息
    ///
    /// - parameter account: 用户账户
    private func loadUserInfo(account: UserAccount, fininsed: (isSuccessed: Bool) -> ()) {
        
        NetworkTools.sharedTools.loadUserInfo(account.uid!, accessToken: account.access_token!) { (result, error) -> () in
            
            if error != nil {
                fininsed(isSuccessed: false)
                
                return
            }
            
            guard let dict = result as? [String: AnyObject] else {
                print("数据格式不正确")
                fininsed(isSuccessed: false)
                
                return
            }
            
            account.screen_name = dict["screen_name"] as? String
            account.avatar_large = dict["avatar_large"] as? String
            
            account.saveUserAccount()
            
            fininsed(isSuccessed: true)
        }
    }
}
```

* 修改 `OAuthViewController` 中的代码调用

```swift
// 4. 加载 accessToken & 用户信息
UserAccountViewModel.sharedUserAccount.loadAccessToke(code) { (isSuccessed) -> () in
    
    if !isSuccessed {
        print("出错了")
    } else {
        print("成功了")
    }
}
```

> 控制器的代码简单了！

## 调整网络代码，简化 token 的调用

* 在 `UserAccountViewModel` 增加 `tokenDict` 计算型属性，生成 token 字典

```swift
/// token 字典
var tokenDict: [String: AnyObject]? {
    return isExpired ? nil : ["access_token": userAccount!.access_token!]
}
```

* 在 网络工具 中修改 `loadUserInfo` 函数

```swift
/// 加载用户信息
///
/// - parameter uid:         uid
/// - parameter accessToken: accessToken
/// - parameter finished:    完成回调
/// - see: [http://open.weibo.com/wiki/2/users/show](http://open.weibo.com/wiki/2/users/show)
func loadUserInfo(uid: String, finished: HMRequestCallBack) {
    
    // 1. 检查 token 
    guard var params = UserAccountViewModel.sharedUserAccount.tokenDict else {
        finished(result: nil, error: NSError(domain: "cn.itheima.error", code: -1001, userInfo: ["message": "字典为空"]))
        return
    }
    
    // 2. 网络访问
    let urlString = "https://api.weibo.com/2/users/show.json"
    params["uid"] = uid
    
    request(.GET, URLString: urlString, parameters: params, finished: finished)
}
```

* 重新调整视图模型中的网络访问代码，删除 `token` 参数

```swift
/// 加载用户信息
///
/// - parameter account: 用户账户
private func loadUserInfo(account: UserAccount, fininsed: (isSuccessed: Bool) -> ()) {
    
    NetworkTools.sharedTools.loadUserInfo(account.uid!) { (result, error) -> () in
        
        if error != nil {
            fininsed(isSuccessed: false)
            
            return
        }
        
        guard let dict = result as? [String: AnyObject] else {
            print("数据格式不正确")
            fininsed(isSuccessed: false)
            
            return
        }
        
        account.screen_name = dict["screen_name"] as? String
        account.avatar_large = dict["avatar_large"] as? String
        
        NSKeyedArchiver.archiveRootObject(account, toFile: self.accountPath)
        
        fininsed(isSuccessed: true)
    }
}
```

* 删除 `UserAccount` 中的 `saveAccount` 函数

## 小结

* 视图模型能够封装网络代码，简化控制器中的代码逻辑
* 视图模型能够封装业务逻辑，控制器中直接调用业务逻辑结果


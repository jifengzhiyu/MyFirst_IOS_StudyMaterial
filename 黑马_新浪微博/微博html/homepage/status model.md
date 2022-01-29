# 微博数据模型

## 目标

* 加载微博数据模型
* 字典转模型

## 代码实现

* 在 `NetworkTools.swift` 中添加加载微博数据方法

```swift
// MARK: - 微博相关方法
extension NetworkTools {
    
    /// 加载微博数据
    ///
    /// - parameter finished: 完成回调
    /// - see: [http://open.weibo.com/wiki/2/statuses/home_timeline](http://open.weibo.com/wiki/2/statuses/home_timeline)
    func loadStatus(finished: HMRequestCallBack) {
        // 1. 获取 token 字典
        guard let params = tokenDict else {
            
            // 如果字典为 nil，通知调用方，token 无效
            finished(result: nil, error: NSError(domain: "cn.itcast.error", code: -1001, userInfo: ["message": "token 为空"]))
            
            return
        }
        
        // 2. 处理网络参数
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        // 3. 发起网路请求
        request(.GET, URLString: urlString, parameters: params, finished: finished)
    }
}
```

* 在 `HomeTableViewController` 中加载微博数据

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    if !UserAccountViewModel.sharedUserAccount.userLogon {
        visitorView?.setupInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
        return
    }
    
    loadData()
}

/// 加载数据
private func loadData() {
    NetworkTools.sharedTools.loadStatus { (result, error) -> () in
        
        if error != nil {
            SVProgressHUD.showInfoWithStatus("网络不给力")
            return
        }
        
        print(result)
    }
}
```

> 运行测试

### 定义微博模型

* 定义微博模型

```swift
/// 微博数据模型
class Status: NSObject {

    /// 微博创建时间
    var created_at: String?
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["created_at", "id", "text", "source"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
}
```

* 定义微博列表视图模型 `StatusListViewModel`

```swift
/// 微博数据列表视图模型
class StatusListViewModel {
    
    /// 微博数据数组
    lazy var statusList = [Status]()
    
    /// 加载微博数据
    ///
    /// - parameter finished: 完成回调
    func loadStatus(finished: (isSuccessed: Bool) -> ()) {
        
        NetworkTools.sharedTools.loadStatus { (result, error) -> () in
            
            // 1. 判断是否有错误
            if error != nil {
                finished(isSuccessed: false)
                return
            }
            
            // 2. 判断数据类型
            guard let array = result?["statuses"] as? [[String: AnyObject]] else {
                print("数据格式不正确")
                finished(isSuccessed: false)
                return
            }
            
            // 3. 遍历数组字典转模型
            var arrayM = [Status]()
            for dict in array {
                arrayM.append(Status(dict: dict))
            }
            
            // 4. 拼接数据
            self.statusList = arrayM + self.statusList
            
            // 5. 完成回调
            finished(isSuccessed: true)
        }
    }
}
```

* 在 `HomeTableViewController` 中增加微博视图模型属性

```swift
/// 微博列表视图模型
private var listViewModel = StatusListViewModel()
```

* 修改 `loadData` 函数

```swift
private func loadData() {
    
    listViewModel.loadStatus { (isSuccessed) -> () in
        
        if !isSuccessed {
            SVProgressHUD.showInfoWithStatus("您的网络不给力")
            return
        }
     
        print(self.listViewModel.statusList)
        // 刷新数据
        self.tableView.reloadData()
    }
}
```

> 运行测试，印象：由视图模型负责数据处理


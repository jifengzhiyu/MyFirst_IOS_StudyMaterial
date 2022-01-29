# 刷新数据

## 目标

* 下拉数据刷新
* 上拉数据刷新
* 视图模型加载数据体验

## 代码实现

* 修改网络方法

```swift
/// 加载微博数据
///
/// - parameter since_id:   若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
/// - parameter max_id:     若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
/// - parameter finished:   完成回调
/// - see: [http://open.weibo.com/wiki/2/statuses/home_timeline](http://open.weibo.com/wiki/2/statuses/home_timeline)
func loadStatus(since_id: Int, max_id: Int, finished: HMRequestCallBack) {
    
    // 1. 获取 token 字典
    guard var params = tokenDict else {
        
        // 如果字典为 nil，通知调用方，token 无效
        finished(result: nil, error: NSError(domain: "cn.itcast.error", code: -1001, userInfo: ["message": "token 为空"]))
        
        return
    }
    if since_id > 0 {
        params["since_id"] = since_id
    } else if max_id > 0 {
        params["max_id"] = max_id
    }

    // 2. 准备网络参数
    let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
    
    // 3. 发起网络请求
    request(.GET, URLString: urlString, parameters: params, finished: finished)
}
```

* 修改视图模型中 `loadStatus` 的数据加载函数

```swift
NetworkTools.sharedTools.loadStatus(since_id: since_id, max_id: 0) {
```

* 修改位置
    * 增加 `since_id` & `max_id` 参数，默认值为0

> 增加外部参数名，可以方便函数参数的录入

### 下拉刷新实现

* 从数组中第一项获得 `since_id`

```swift
// 下拉刷新 id
let since_id = statusList.first?.status.id ?? 0
```

> 运行测试

### 上拉刷新实现

* 增加上拉刷新参数

```swift
func loadStatus(isPullup isPullup: Bool, finished: (isSuccessed: Bool)->()) {
    
    // 下拉刷新 id
    let since_id = isPullup ? 0 : (statusList.first?.status.id ?? 0)
    // 上拉刷新 id
    let max_id = isPullup ? (statusList.last?.status.id ?? 0) : 0
    
    NetworkTools.sharedTools.loadStatus(since_id: since_id, max_id: max_id) {
```

* 在 `HomeTableViewController` 以上拉视图的动画状态作为参数传递

```swift
listViewModel.loadStatus(isPullup: pullupView.isAnimating()) { (isSuccessed) -> () in
```

* 在 `HomeTableViewController` 的数据源方法中，检测到上拉刷新后，调用 `loadData` 函数

```swift
// 判断是否需要上拉刷新
if indexPath.row == listViewModel.statuses.count - 1 && !pullupView.isAnimating() {
    print("开始上拉刷新")
    pullupView.startAnimating()
    loadData()
}
```

* 数据拼接

```swift
print("加载了 \(dataList.count) 条微博")

// 3. 拼接数据
if max_id > 0 {             // 上拉刷新，将新数据拼接在当前数组的末尾
    self.statusList += dataList
} else {                    // 下拉或默认刷新，将新数据追加在当前数组的前面
    self.statusList = dataList + self.statusList
}
```

> 运行测试

* 在 `HomeTableViewController` 的 `loadData` 函数的完成回调中关闭上拉刷新的动画

```swift
self.refreshControl?.beginRefreshing()

listViewModel.loadStatus(isPullup: pullupView.isAnimating()) { (isSuccessed) -> () in
    // 关闭刷新控件
    self.refreshControl?.endRefreshing()
    self.pullupView.stopAnimating()
    
    if !isSuccessed {
        SVProgressHUD.showInfoWithStatus("加载数据错误，请稍后再试")
        return
    }
    
    // 刷新数据
    self.tableView.reloadData()
}
```

### 修改网络工具中的 `max_id` 处理

```swift
// 2. 上/下刷新参数
if since_id > 0 {
    params["since_id"] = since_id
} else if max_id > 0 {
    params["max_id"] = max_id - 1
}
```


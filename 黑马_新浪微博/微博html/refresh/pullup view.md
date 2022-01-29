# 上拉刷新视图

* 定义上拉刷新视图

```swift
// MARK: - 懒加载控件
/// 上拉刷新视图
private lazy var pullupView: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    indicator.color = UIColor.lightGrayColor()
    
    return indicator
}()
```

* 将上拉刷新视图添加到 `tableFooterView`

```swift
// 上拉刷新控件
tableView.tableFooterView = pullupView
```

* 上拉刷新逻辑，在表格数据源函数中增加以下代码

```swift
// 判断是否需要上拉刷新
if indexPath.row == listViewModel.statusList.count - 1 && !pullupView.isAnimating() {
    print("应该上拉刷新了")
    pullupView.startAnimating()
}
```

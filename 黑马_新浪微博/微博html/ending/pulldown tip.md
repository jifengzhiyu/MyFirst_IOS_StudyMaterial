# 下拉刷新提示

* 在 `StatusListViewModel` 添加属性记录下拉刷新数字

```swift
/// 下拉刷新计数
var pulldownCount: Int?
```

* 在刷新完成后，记录下拉刷新数量

```swift
QL2Info("刷新到 \(dataList.count) 条数据")            
// 记录刷新数量
self.pulldownCount = since_id > 0 ? dataList.count : nil
```

* 在 `HomeTableViewController` 中定义函数显示下拉刷新提示

```swift
/// 显示下拉刷新提示
private func showPulldownTip() {
    
}
```

* 在 `loadData` 函数中增加函数显示刷新数量

```swift
self.showPulldownTip()
// 刷新数据
self.tableView.reloadData()
```

* 实现 `showPulldownTip` 函数

```swift
/// 显示下拉刷新提示
private func showPulldownTip() {
    guard let count = listViewModel.pulldownCount else {
        return
    }
    let message = (count == 0) ? "没有新微博" : "刷新到 \(count) 条微博"
    
    let label = UILabel(title: message, fontSize: 18, color: UIColor.whiteColor())
    label.backgroundColor = UIColor.orangeColor()
    
    let height: CGFloat = 44
    let rect = CGRect(x: 0, y: -2 * height, width: view.bounds.width, height: height)
    label.frame = rect
    
    navigationController?.navigationBar.insertSubview(label, atIndex: 0)
}
```

* 定义懒加载属性

```swift
/// 下拉提示标签
private lazy var pulldownLabel: UILabel = {
    let label = UILabel(title: "", fontSize: 18, color: UIColor.whiteColor())
    label.backgroundColor = UIColor.orangeColor()
    
    self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
    
    return label
}()
```

* 调整函数，增加动画

```swift
/// 显示下拉刷新提示
private func showPulldownTip() {
    guard let count = listViewModel.pulldownCount else {
        return
    }
    pulldownLabel.text = (count == 0) ? "没有新微博" : "刷新到 \(count) 条微博"
    
    let height: CGFloat = 44
    let rect = CGRect(x: 0, y: -2 * height, width: view.bounds.width, height: height)
    pulldownLabel.frame = rect
    
    UIView.animateWithDuration(1, animations: {
        self.pulldownLabel.frame = CGRectOffset(rect, 0, 3 * height)
        }) { _ in
            UIView.animateWithDuration(1) { self.pulldownLabel.frame = rect }
    }
}
```


# 下拉刷新数据提示

## 目标

* 添加下拉提示标签及动画

## 代码实现

* 在 `StatusListViewModel` 中增加可选属性

```swift
/// 下拉刷新数据行数
var pulldownCount: Int?
```

* 修改 `loadStatuses` 函数，记录下拉刷新数据行数

```swift
// 3> 记录下拉刷新数据行数
self.pulldownCount = since_id > 0 ? dataList.count : nil
```

* 在 `HomeTableViewController` 的数据刷新完成回调中调用 `showPulldownTips` 函数

```swift
if !isSuccessed {
    SVProgressHUD.showInfoWithStatus("加载数据错误，请稍后再试")
    return
}

// 显示下拉刷新提示
self.showPulldownTip()

// 刷新数据
self.tableView.reloadData()
```

* 增加 `showPulldownTips` 函数，测试 提示标签的添加位置

```swift
/// 显示下拉刷新提示
private func showPulldownTip() {
    
    // 判断是否下拉刷新
    guard let count = listViewModel.pulldownCount else {
        return
    }
    
    let message = count > 0 ? "刷新到了 \(count) 条微博" : "没有刷新到数据"
    print(message)
    
    let height:CGFloat = 44
    let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: height)
    let label = UILabel(title: message, fontSize: 18, color: UIColor.whiteColor())
    label.backgroundColor = UIColor.orangeColor()
    label.frame = CGRectOffset(rect, 0, height)

    navigationController?.navigationBar.insertSubview(label, atIndex: 0)
}
```

* 抽取下拉提示标签的懒加载属性

```swift
/// 下拉提示标签
private lazy var pulldownTipLabel: UILabel = {
    
    let label = UILabel(title: "", fontSize: 18, color: UIColor.whiteColor())
    label.backgroundColor = UIColor.orangeColor()
    
    self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
    
    return label
}()
```

* 实现动画提示代码

```swift
/// 显示下拉刷新提示
private func showPulldownTip() {
    
    // 判断是否下拉刷新
    guard let count = listViewModel.pulldownCount else {
        return
    }
    
    let message = count > 0 ? "刷新到了 \(count) 条微博" : "没有刷新到数据"
    print(message)
    
    let height:CGFloat = 44
    let rect = CGRect(x: 0, y: -2 * height, width: view.bounds.width, height: height)

    pulldownTipLabel.text = message
    pulldownTipLabel.frame = rect
    
    UIView.animateWithDuration(1.0, animations: { () -> Void in
        self.pulldownTipLabel.frame = CGRectOffset(rect, 0, 3 * height)
        }) { _ in
            UIView.animateWithDuration(1.0) { self.pulldownTipLabel.frame = rect }
    }
}
```

## 小结

* 在实际开发中可以利用 `navigationBar` 添加辅助视图
* `navigationBar` / `tabBar` / `toolBar` 内部控件都是系统自动计算的，不能使用自动布局

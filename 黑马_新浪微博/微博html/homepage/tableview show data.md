# 显示表格数据

* 定义可重用标识符

```swift
/// 可重用 Cell 表示符号
private let StatusCellNormalId = "StatusCellNormalId"
```

* 在 `viewDidLoad` 中注册可重用 `Cell`

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    if !UserAccountViewModel.sharedUserAccount.userLogon {
        visitorView?.setupInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
        return
    }
    
    prepareTableView()
    loadData()
}

/// 准备表格
private func prepareTableView() {
    // 注册 cell
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: StatusCellNormalId)
}
```

* 实现数据源函数

```swift
// MARK: - 数据源方法
extension HomeTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StatusCellNormalId, forIndexPath: indexPath)
        
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        
        return cell
    }
}
```

## 小结

* 由于 `HomeTableViewController` 继承自 `UITableViewController`，而 `UITableViewController` 已经实现了 `UITableViewDataSource`，因此在 extension 不需要再遵守 `UITableViewDataSource`
* 纯代码开发时，最好将表格的可重用标识符号定义成私有常量，以便注册和查询共用




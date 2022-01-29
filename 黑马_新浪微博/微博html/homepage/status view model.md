# 微博视图模型

## 目标

* 建立视图模型
* 在 `view`/`viewController` 中不能直接引用模型
* 将 MVC 架构调整之 MVVM 架构的简单演练

## 代码实现

* 建立微博视图模型

```swift
/// 微博视图模型
class StatusViewModel {
    /// 微博模型
    var status: Status
    
    /// 构造函数
    init(status: Status) {
        self.status = status
    }
}
```

* 修改 `StatusListViewModel` 中的 `微博数据数组` 定义

```swift
/// 微博数据数组
lazy var statuses = [StatusViewModel]()
```

* 修改 `StatusListViewModel` 中的网络代码中字典转模型部分

```swift
// 3. 遍历数组字典转模型
var arrayM = [StatusViewModel]()
for dict in array {
    arrayM.append(StatusViewModel(status: Status(dict: dict)))
}
```

* 修改 `HomeTableViewController` 中的数据源方法

```swift
cell.textLabel?.text = listViewModel.statusList[indexPath.row].status.user?.screen_name
```

### 调试信息

* 遵守协议

```swift
class StatusViewModel: CustomStringConvertible
```

* `description` 属性

```swift
/// 描述信息
var description: String {
    return status.description
}
```

## 小结

* MVVM 设计模式的一个很重要的目的就是将 `Controller` 瘦身
* 一个控制器可以引用多个视图模型
* 在工作中如果遇到量级非常重的控制器，可以针对实际的业务，将一组业务逻辑相关的代码抽取到一个独立的视图模型中处理

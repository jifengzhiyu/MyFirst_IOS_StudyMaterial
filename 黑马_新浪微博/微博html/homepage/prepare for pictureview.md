# 配图微博数据准备

## 目标

* 扩展视图模型，以简化配图视图的 UI 搭建

## 代码实现

### 增加视图模型的描述信息

* 让 `StatusViewModel` 遵守协议 `CustomStringConvertible`

```swift
class StatusViewModel: CustomStringConvertible
```

* 实现 `CustomStringConvertible` 中的计算型属性 `description`

```swift
/// 描述信息
var description: String {
    return status.description
}
```

### 扩展模型

* 在 `Status` 模型中增加配图数组模型

```swift
/// 缩略图片字典数组地址
var pic_urls: [[String: String]]?
```

* 扩展 `description`

```swift
override var description: String {
    let keys = ["created_at", "id", "text", "source", "user", "pic_urls"]
    
    return dictionaryWithValuesForKeys(keys).description
}
```

### 缩略图 URL 数组属性

* 定义缩略图 URL 数组

```swift
/// 配图 URL 数组
var thumbnailUrls: [NSURL]?
```

* 扩展构造函数创建缩略图数组

```swift
/// 构造函数
init(status: Status) {
    self.status = status
    
    // 创建配图 URL 数组
    if status.pic_urls?.count >= 0 {
        thumbnailUrls = [NSURL]()
        
        for dict in status.pic_urls! {
            let url = NSURL(string: dict["thumbnail_pic"]!)
            
            thumbnailUrls?.append(url!)
        }
    }
}
```

* 调整视图模型 `description`

```swift
/// 描述信息
var description: String {
    return status.description + "\n配图数组 \((thumbnailUrls ?? []) as NSArray)"
}
```



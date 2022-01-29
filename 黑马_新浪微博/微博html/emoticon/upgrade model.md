# 提升数据模型

* 遗留问题

    1. 没有默认分组
    2. 每隔20个按钮需要一个删除按钮
    3. 页面表情不足21个需要补足
    4. 点击分组跳转到指定分组起始位置

## 添加默认分组

* 在 `EmoticonManager` 的 `构造函数` 中增加 `最近` 分组记录

```swift
private init() {
    // 0. 添加最近分组
    packages.append(EmoticonPackage(dict: ["group_name_cn": "最近"]))
```

* 修改 `EmoticonView` 的 `prepareToolbar` 准备工具栏中的遍历

```swift
for p in packages {
    let item = UIBarButtonItem(title: p.group_name_cn, style: .Plain, target: self, action: "clickItem:")
```

## 每隔20个按钮需要一个删除按钮

* 在 `Emoticon` 中增加是否删除标记

```swift
/// 是否删除按钮
var isRemoved = false

// MARK: - 构造函数
init(isRemoved: Bool) {
    self.isRemoved = isRemoved
}
```

* 修改 `EmoticonPackage` 的 构造函数，每隔20个按钮添加一个删除按钮

```swift
var index = 0

for var d in array {
    if let png = d["png"], let dir = id {
        d["png"] = dir + "/" + png
    }
    
    emoticons.append(Emoticon(dict: d))
    
    // 追加删除按钮
    if ++index == 20 {
        emoticons.append(Emoticon(isRemoved: true))
        index = 0
    }
}
```

* 添加删除按钮图片素材
* 显示删除按钮

```swift
// 是否删除按钮
if emoticon!.isRemoved {
    emoticonButton.setImage(UIImage(named: "compose_emotion_delete"), forState: .Normal)
}
```

## 页面表情不足21个需要补足

* 在 `Emoticon` 表情中增加 `isEmpty` 属性

```swift
/// 是否空白按钮
var isEmpty = false

// MARK: - 构造函数
init(isEmpty: Bool) {
    self.isEmpty = isEmpty
}
```

* 在 `EmoticonPackage` 中增加追加空白表情函数，并且在 构造函数 最后调用

```swift
/// 追加空白按钮
private func appendEmptyButton() {
    let count = emoticons.count % 21
    
    print("数组剩余按钮 \(count)")
    
    if emoticons.count > 0 && count == 0 {
        return
    }
    
    for _ in count..<20 {
        emoticons.append(Emoticon(isEmpty: true))
    }
    // 末尾追加删除按钮
    emoticons.append(Emoticon(isRemoved: true))
}
```

## 点击分组跳转到指定分组起始位置

* 实现 `clickItem` 监听方法

```
// MARK: - 监听方法
/// 点击工具栏 item
@objc private func clickItem(item: UIBarButtonItem) {
    let indexPath = NSIndexPath(forItem: 0, inSection: item.tag)
    
    collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: true)
}
```

## 如果没有最近表情直接跳转到默认分组

```swift
// 跳转到默认分组
let indexPath = NSIndexPath(forItem: 0, inSection: 1)
dispatch_async(dispatch_get_main_queue()) {
    self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
}
```

> 主队列在主线程有任务执行时，不会调度队列中到任务

* 修改 collectionView 的背景颜色

```swift
collectionView.backgroundColor = UIColor.whiteColor()
```

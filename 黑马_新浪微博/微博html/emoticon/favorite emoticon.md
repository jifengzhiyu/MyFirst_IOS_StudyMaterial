# 内存表情排序

* 在 `Emoticon` 模型中增加使用次数的属性

```swift
/// 使用次数
var times = 0
```

* 在 `EmoticonViewModel` 视图模型中增加 `favorite` 函数

```swift
/// 添加最近表情符号
func addFavorite(em: Emoticon) {

}
```

* 在 `EmoticonView` 的 `collection:didSelectItemAtIndexPath` 代理方法中调用 `addFavorite` 函数

```swift
// 添加最近使用表情
EmoticonManager.sharedManager.addFavorite(em)
```

* 添加表情并且排序

```swift
/// 添加最近表情符号
func addFavorite(em: Emoticon) {
    em.times++
    
    // 判断是否在最近分组
    if !packages[0].emoticons.contains(em) {
        packages[0].emoticons.insert(em, atIndex: 0)
        // 删除倒数第二个表情
        packages[0].emoticons.removeAtIndex(packages[0].emoticons.count - 2)
    }
    
    // 排序
    packages[0].emoticons.sortInPlace { (em1, em2) -> Bool in
        em1.times > em2.times
    }
    
    print(packages[0].emoticons as NSArray)
}

```

> sortInPlace 函数能够直接排序当前数组

* 简写排序代码

```swift
packages[0].emoticons.sortInPlace { $0.times > $1.times }
```

* 修改 `EmoticonView`，最近分组的表情不参加排序

```swift
// 添加最近使用的表情
if indexPath.section > 0 {
    EmoticonManager.sharedManager.addFavorite(em)
}
```

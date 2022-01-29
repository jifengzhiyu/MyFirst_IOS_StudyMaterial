# 设置全局外观

* 修改 `AppDelegate` 代码

```swift
/// 设置全局外观
private func setupAppearance() {
    UITabBar.appearance().tintColor = UIColor.orangeColor()
    UINavigationBar.appearance().tintColor = UIColor.orangeColor()
}
```

* 在 `Common.swift` 增加全局外观颜色变量

```swift
/// 全局外观渲染颜色
let HMAppearanceTintColor = UIColor.orangeColor()
```

* 修改 `AppDelegate` 代码

```swift
/// 设置全局外观
private func setupAppearance() {
    UITabBar.appearance().tintColor = HMAppearanceTintColor
    UINavigationBar.appearance().tintColor = HMAppearanceTintColor
}
```

## 小结

1. 应用程序外观一经设置，全局有效，通常在 `AppDelegate` 中设置
2. `AppDelegate` 是应用程序的入口，是快速阅读程序的入口，整理文件夹的时候不要把 `AppDelegate` 藏起来

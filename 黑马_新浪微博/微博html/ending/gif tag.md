# GIF标记

* 在 `StatusPictureViewCell` 中定义懒加载属性 `gifIconView`

```swift
/// GIF 标记图片
private lazy var gifIconView: UIImageView = UIImageView(imageName: "timeline_image_gif")
```

* 修改 `setupUI` 设置控件位置

```swift
private func setupUI() {
    // 1. 添加控件
    contentView.addSubview(iconView)
    iconView.addSubview(gifIconView)
    
    // 2. 设置布局 - 提示因为 cell 会变化，另外，不同的 cell 大小可能不一样
    iconView.snp_makeConstraints { (make) -> Void in
        make.edges.equalTo(contentView.snp_edges)
    }
    gifIconView.snp_makeConstraints { (make) -> Void in
        make.right.equalTo(iconView.snp_right)
        make.bottom.equalTo(iconView.snp_bottom)
    }
}
```

* 根据扩展名设置 gif 标记的显示

```swift
gifIconView.hidden = (imageURL?.absoluteString ?? "" as NSString).pathExtension.lowercaseString != "gif"
```

# iPhone 6+ 多图布局处理

* 修改 `StatusPictureView` 的 `calcViewSize` 函数中多图的计算

```swift
let h = row * itemWidth + (row - 1) * StatusPictureViewItemMargin + 1
let w = rowCount * itemWidth + (rowCount - 1) * StatusPictureViewItemMargin + 1
```


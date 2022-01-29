# 照片间距

* 修改 `PhotoBrowserViewController` 使其根视图宽度比屏幕宽度 > 20 

```swift
override func loadView() {
    var rect = UIScreen.mainScreen().bounds
    rect.size.width += 20
    
    view = UIView(frame: rect)
    
    setupUI()
}
```

* 修改 `PhotoBrowserCell` 使其 scrollView 的大小比 cell 的宽度 < 20

```swift
// 2. 设置位置
var rect = bounds
rect.size.width -= 20
scrollView.frame = rect
```

* 取消背景颜色

```swift
func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserViewCellId, forIndexPath: indexPath) as! PhotoBrowserCell
    
    cell.imageURL = urls[indexPath.item]
    
    return cell
}
```


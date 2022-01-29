# 保存照片

* 保存图片

```swift
/// 保存照片
@objc private func save() {
    guard let image = (collectionView.visibleCells().last as? PhotoBrowserCell)?.imageView.image else {
        print("没有图像")
        return
    }
    
    UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
}

//  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
@objc private func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject?) {
    let message = error != nil ? "保存失败" : "保存成功"
    
    SVProgressHUD.showInfoWithStatus(message)
}
```

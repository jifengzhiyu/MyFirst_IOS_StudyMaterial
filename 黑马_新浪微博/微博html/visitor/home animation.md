# 首页动画

## 目标

* 首页控制器的图片播放旋转动画

## 代码实现

* 添加动画代码

```swift
/// 开始动画
private func startAnimation() {
    let anim = CABasicAnimation(keyPath: "transform.rotation")
    
    anim.toValue = 2 * M_PI
    anim.repeatCount = MAXFLOAT
    anim.duration = 20
    
    iconView.layer.addAnimation(anim, forKey: nil)
}
```

* 调整 `setupInfo` 函数

```swift
guard let imageName = imageName else {
    startAnimation()
    return
}
```

> 运行测试，发现切换控制器后动画会被释放，另外在首页退出到桌面再次进入，动画同样会被释放

* 设置动画属性

```swift
anim.removedOnCompletion = false
```

## 小结

* 设置动画的 `removedOnCompletion = false` 经常用在循环播放的动画上，该动画会绑定在动画图层上，循环执行
* 当控件被销毁时，动画会一起被销毁

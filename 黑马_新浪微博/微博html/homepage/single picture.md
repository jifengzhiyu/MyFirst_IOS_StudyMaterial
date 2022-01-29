# 单张图片

## 目标

* 将单张图片提前缓存到本地，以便判断大小
* 复习 gcd 的 `dispatch_group`
* 熟悉 SDWebImage 的其他函数应用

### 预先加载图片说明

* 新浪微博的数据接口并没有返回每一张图片的尺寸
* 而对于保存在远程服务器的图片而言，客户端是无法获知服务器上的图片大小的
* 因此要实现单图都效果，需要先将图片缓存到本地

## 代码实现

### 缓存单张图片

* 在 `StatusListViewModel` 中增加 `cacheSingleImage` 函数
* 调整 `loadStatus` 函数，调用 `cacheSingleImage` 函数缓存单张图片

```swift
// 2. 遍历数组
for dict in array {
    dataList.append(StatusViewModel(status: Status(dict: dict)))
}

// 3. 拼接数据
self.statusList = dataList + self.statusList

// 4. 缓存图片
self.cacheSingleImage(dataList)
```

* 缓存图片并且回调

```swift
private func cacheSingleImage(array: [StatusViewModel]) {
    
    // 1. 遍历数组
    for vm in array {
        // 1> 只缓存单张图片
        if vm.thumbnailUrls?.count != 1 {
            continue
        }
        
        // 2> 获取 url
        let url = vm.thumbnailUrls![0]
        
        print("要缓存的 \(url)")
        
        // 3> 下载图片
        SDWebImageManager.sharedManager().downloadImageWithURL(
            url,                                // URL
            options: [SDWebImageOptions.RetryFailed, SDWebImageOptions.RefreshCached],  // 选项
            progress: nil)                      // 进度
            { (image, error, _, _, _)  in       // 完成回调
                
                if let img = image,
                    data = UIImagePNGRepresentation(img) {
                        print(data.length)
                }
        }
    }
}
```

* 添加 `dispatch_group` 和数据长度

```swift
// 0. 调度组
let group = dispatch_group_create()
// 缓存数据长度
var dataLength = 0
```

* 下载图像之前入组，下载图像最后一行出组

```swift
// 3> 下载图片
dispatch_group_enter(group)
SDWebImageManager.sharedManager().downloadImageWithURL(
    url,                                // URL
    options: [SDWebImageOptions.RetryFailed, SDWebImageOptions.RefreshCached],  // 选项
    progress: nil)                      // 进度
    { (image, error, _, _, _)  in       // 完成回调
        
        // 不是每次图像都能下载成功
        if let img = image,
            data = UIImagePNGRepresentation(img) {
                
                // 累加长度
                dataLength += data.length
        }
        
        // 出组
        dispatch_group_leave(group)
}
```

* 修改函数定义，增加完成回调参数

```swift
private func cacheSingleImage(array: [StatusViewModel], finished: (isSuccessed: Bool)->()) {
```

* 完成回调

```swift
// 2. 监听调度组完成
dispatch_group_notify(group, dispatch_get_main_queue()) {
    print("缓存图像大小 \(dataLength / 1024) K")
    finished(isSuccessed: true)
}
```

* 修改函数调用

```swift
// 3. 拼接数据
self.statusList = dataList + self.statusList

// 4. 缓存图片
self.cacheSingleImage(dataList, finished: finished)
```

### 修改单张图片显示

* 修改 `calcViewSize` 函数

```swift
// 2. 单图
if count == 1 {
    // 临时设置单图大小
    var size = CGSize(width: 150, height: 120)
    
    // 提取单图
    if let key = viewModle?.thumbnailUrls?.first?.absoluteString {
        size = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key).size
    }
    
    layout.itemSize = size
    return size
}
```

* 细节处理，防止图片过窄或者太宽

```swift
// 图像过窄处理
size.width = size.width < 40 ? 40 : size.width

// 图像过宽处理，等比例缩放
if size.width > 300 {
    let w: CGFloat = 300
    let h = size.height * w / size.width
        
    size = CGSize(width: w, height: h)
}
```

## 小结

* `dispatch_group`
    * `dispatch_group_enter` 后续的 block 执行会受 `group` 监听
    * `block` 的最后一句必须是 `dispatch_group_leave`，通知 `group` 该任务完成
    * `dispatch_group_enter` 和 `dispatch_group_leave` 无比成对出现

* `SDWebImage`
    * 下载图像时一定注意图像不一定都会被正确下载
    * `SDWebImageManager.sharedManager().downloadImageWithURL` 是 SDWebImage 的核心下载函数
    * `SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey` 使用图像完整的 `URL字符串` 检查是否存在图像的磁盘缓存
    * `SDWebImage` 使用 `MD5` 对 `URL 字符串`编码并作为缓存图像的文件名


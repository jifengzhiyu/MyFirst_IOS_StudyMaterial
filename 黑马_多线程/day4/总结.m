//访问网络
//<key>NSAppTransportSecurity</key>
//<dict>
//<key>NSAllowsArbitraryLoads</key>
//<true/>
//</dict>



//1 SDWebImage
    //介绍
    //下载  github
    //看文档  readme
    //演示 使用


//模拟SDWebImage
//2 自定义Operation：封装下载操作
    //重写main方法 添加autoreleasepool
    //传递要下载图片的地址，和下载完成的回调
    //封装了一个类方法，快速初始化对象
    //取消操作
//3 封装下载操作，测试
    //下载操作缓存池
//4 下载操作的管理类
    //管理全局的下载操作
    //管理全局的缓存操作(内存和沙盒缓存)


  UIImageView的分类 --> SDWebImageManager  -->  SDWebIMageDownloader  -> SDWebIMageDownloaderOperation
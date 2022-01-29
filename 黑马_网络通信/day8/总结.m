//图片轮播器、tableView加载新闻、新闻横向滚动

//1 创建项目  cocoaPods 管理第三方框架
//2 创建了操作网络的工具类 HMNetworkTools
//----------------3 图片轮播器 -----------
//3.1 创建模型类型，加载网络数据, 测试
//3.2 设置collectionView数据源方法， 横向滚动
//3.3 自定义cell，显示图片和标题
//3.4 无限轮播的思路
//3.5 当collectionView的数据加载完毕，滚动到第二个cell
//3.6 返回cell之前，计算当前要显示的图片的索引
    //滚动的时候，能正常显示下一个cell的图片
//3.7 当滚动结束之后，计算currentIndex当前图片的索引，滚动到第二个cell


//4 containerView加载图片轮播器的控制器，在viewDidLayoutSubviews中设置cell的大小，否则collectionView的大小不合适
//5 设置网络加载指示符和缓存
//--------------6  新闻列表------------
//6.1 异步加载新闻数据，测试，解决问题
//6.2 自定义cell
//6.3 大图cell
//6.4 三个图片的cell


//-------------7 左右滑动新闻列表，加载不同分类的新闻------------
//7.1 homeController --》scrollView  和 collectionView
//7.2 加载新闻分类的数据
//7.3 显示新闻分类的数据，自定义label
//7.4 自定义cell中加载另一个控制器的controller中的view
    //在homecontroller中在合适的方法中设置cell的大小
    //在cell中把controller设置成属性
    //在cell的合适的方法中设置 加载的另一个控制器的view


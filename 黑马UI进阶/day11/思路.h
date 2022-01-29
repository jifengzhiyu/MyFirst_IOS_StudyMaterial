// ----- 转盘
//1.设置背景图片
//2.设置顶部三个按钮
//3.根据图片通过xib描述控件
//4.xib背景透明
//5.转盘背景图片 锯齿图片 选号按钮
//6.创建12个btn添加在锯齿图片的中心
//7.anchorPoint
//8.散开
//9.切图
//10.设置图片 选中图片 选中背景图片
//11.通过transform旋转锯齿图片(通过旋转的btn确定角度)
//12.开始选号快速旋转锯齿图片
//13.动画结束后 移除动画

// ----- 彩票基本框架
//1.启动图片
//2.应用图标
//3.分模块
//4.关横竖屏

// ----- 自定义tabbar
//1.加载五个storyboard的箭头控制器
//2.使用UIView
//3.使用按钮touch down
//4.设置按钮的默认和选中的背景图片
//5.取消按钮高亮状态

// ----- 自定义nav
//1.设置navBar的图片
//2.文字标题统一设置成白色
//3.设置状态栏为白色
//4.设置tint

// ----- 购彩大厅
//1.左上角活动图片
//2.设置图片不使用的渲染的方式
//3.活动按钮的点击事件
//4.cover->imageView->closebtn
//5.关闭按钮动画remove控件

// ----- 竞技场
//1.单独设置导航栏图片
//2.控制器view设置为图片
//3.获取titleView
//4.设置默认和选中的背景图片
//5.设置默认和选中的文字为白色

// ----- 发现
//1.静态单元格
//2.自定义cell设置子控件

// ----- 发现 - 合买
//1.隐藏自定义的tabbar
//2.自定义btn
//3.在layoutsubviews中交换位置
//4.UIView+Frame分类
//5.按钮点击事件
//6.三角旋转
//7.view弹出和收起

// ----- 发现 - 幸运选号
//1.背景图片
//2.多个hide自定义bar需要重写push方法
//3.彩灯切换(Tom cat)
//4.四个按钮

// ----- 开奖信息
//1.开奖推送按钮使用button
//2.更改图片和文字的距离
//3.改字的大小或者宽度

// ----- 我的彩票
//1.左上角客服按钮距离问题
//2.右上角图片
//3.拉伸图片问题
//0.25 	0.25 	0.5 	0.5
//0.5 	0.5 	0 		0

// 设置界面
// 1.plist
// 2.封装cell

// 使用兑换码
// 1.多加个跳转目标的key

// 推动和提醒
// 1.同样跳转到setting
// 2.为setting增加一个plistName属性
// 3.增加一个plist文件

// 推送01
// 1.header
// 2.subtitle

// 推送02
// 1.footer
// 2.非setting页面 继承
// 3.toolbar+datepicker
// 4.时间
// 5.完成时 先获取cell再赋值给subtitle
// 6.cell重用问题

// 推送03

// 推送04

// 保存开关状态

// 关于页面
// 1.继承setting
// 2.xib添加header

// collectionView的简单使用
// 1.item左右间距
// 2.item上下间距
// 3.每个组的四周的间距
// 4.注册cell的含义
// 5.使用xib

// json的简单使用
// 1.什么是json
// 2.json的解析

// 产品推荐
// 组距离上面16
// item大小80 80
// 左右间距 0
// 上下间距 16
// 图片处理成圆角

// 检查新版本
// 1.弹框
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//
//#pragma clang diagnostic pop

// 判断是不是第一次运行或更新
// 1.获取版本号
// 2.AppDelegate写代码
// 3.启动以后记录
// 4.启动之前查

// 新特性页面 - 背景图片
// 1.collectionView
// 2.不能使用xib
// 3.懒加载控件

// 新特性页面 - 介绍图片
// 1.viewDidLoad加载四张图片
// 2.滚动完毕以后 图片的x变为偏移量
// 3.计算换第几张图片 换图片
// 4.动画

// 新特性页面 - 判断方向
// 1.1判断offsetx和当前随便一张图片的x
// 1.2记录上一次的offsetx 判断offsetx和上一次的offsetx
// 1.3记录page 判断page和上一次的page
// 2.让image的x+屏幕的宽度

// 新特性页面 - 进入按钮
// 1.size to fit
// 2.更改按钮的x y
// 3.点击切换root view controller

// 常见问题
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//
//#pragma clang diagnostic pop
// 1.普通的tableViewController
// 2.loadview中设置webview
// 3.加载url
// 4.加载本地url
// *5.js相关

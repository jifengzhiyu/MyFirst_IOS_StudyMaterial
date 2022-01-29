一、UI进阶介绍：
    * 介绍UI进阶与UI基础的区别
    * 简单介绍UI进阶要学习的内容

二、介绍数据选择控件UIPickerView和日期选择控件UIDatePicker控件
    * UIPickerView的案例
        * 点餐系统
        * 城市选择
        * 国旗选择
    * UIDatePicker的案例
        * UIToolbar的介绍和基本使用
        * UIBarButtonItem的介绍和演示
        * 将日期或时间数据设置到文本框上

三、项目配置文件介绍
    * 应用头像
    * 应用加载图片的设置
    * info.plist文件介绍：
        * 常用的key
        * Xcode 6以前都是以“项目名称-info.plist”命名，Xcode 6以后就只有info.plist
// 现在历史版本Xcode的网址
// https://developer.apple.com/downloads/
        * 通过open as source code查看info.plist中完整的key
        * 通过代码去获取info.plist中的信息
    * pch文件介绍
        * 创建pch文件
        * 配置基本信息
        * 打印宏的演示
            #ifdef DEBUG

            #define CZLog(...) NSLog(__VA_ARGS__)

            #else

            #define CZLog(...)

            #endif
        * 对于C与OC相关宏的区分
            #ifdef __OBJC__

            // OC相关的内容

            #endif

四、UIApplication对象的介绍
    * 查看UIApplication头文件，了解应用对象里面的常用的属性和方法
    * 演示UIApplication的使用
        * 获取UIApplication对象
        * 设置应用图标的数字
        * 联网指示器
        * 状态栏的管理：通过application对象来管理状态栏。


五、UIApplicationDelegate对象介绍
    * 主要用来监听应用程序的状态等信息
    * 常用的几个方法介绍



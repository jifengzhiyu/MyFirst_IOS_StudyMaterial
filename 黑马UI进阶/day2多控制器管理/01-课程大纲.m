一、复习
    * 数据选择控件 UIPickerView
    * 日期选择控件 UIDatePicker

    * 项目配置文件介绍
        * info.plist
        * pch文件

    * UIApplication对象
    * UIApplicationDelegate

二、常用的应用方法
    * 默认有6个方法
        * 当应用程序启动完毕
        * 应用程序即将失去焦点，非激活状态
        * 已经进入后台
        * 即将进入前台时执行
        * 已经变为激活状态
        * 应用程序将会被销毁

三、应用程序启动过程
    * main函数介绍
    * main.storyboard内控制器的加载过程
    * 加载自定义控制器的演示

四、应用程序启动过程补充
    * UIApplication、AppDelegate、UIWindow、UIViewController之间的关系
        * UIApplication 里面有个delegate属性。
        * appDelegate 里面有个window属性
        * 通过创建window，指定窗口的肯控制器即可显示界面。

    * 模拟内存警告
        * 选中模拟器 -> Hardware ->  Simulate Memory Warning
        * 调用私有API实现：[[UIApplication sharedApplication] performSelector:@(_performMemoryWarning)]

五、UIWindow介绍
    * 介绍UIWindow
    * 手动创建UIWidow

六、3种创建控制器的方式
    * 纯代码的方式直接创建控制器 alloc + init
    * 通过storyboard创建 2种情况
    * 通过xib文件创建控制器 3种情况

七、控制器的view是懒加载
    * 如果是第一次调用self.view就会调用对应的loadView方法创建一个view，如果前面设置过self.view的
    * 重写loadView方法，如果在窗口显示之前如果没有用到控制器的view就不会调用loadView方法，在窗口显示的时候就会调用loadView方法。
    * 如果在窗口显示之前用到了控制器的view，就会直接调用loadView方法。

八、多控制器管理_导航控制器的使用
    * 介绍
    * 基本使用演示
    * 出栈、入栈的演示
    * 设置导航栏上的一些内容
    * 通过storyboard使用导航控制器
    * 导航控制器的传值演示






















# 复习
* UIPickerView及UIDatePicker
    * 都是关于数据选择的。
    * 通常都是作为文本框的键盘的方式显示的。设置为文本框的inputView
* UIToolbar
    * 如果文本框键盘上面需要工具栏，可以通过设置为文本框的inputAccessoryView。
* 项目文件结构介绍
    * plist文件
        * 整体可以存储为一个字典、或数组。
        * 内部就可以存储NSArray、NSDictionary、BOOL、NSString、NSNumber
        * 但是一个自定义类的对象是不能保存到plist文件中
    * plist文件
        * 应用名称
        * 应用要求的手机系统版本
        * 应用的版本号
        * 修改状态栏的管理权限
* pch文件
    * 是一个头文件，里面所有的头文件都可以自动去包含，省得去手动包含。
* UIApplication对象
    * 可以通过类方法获取，是个单例对象
    * 可以执行打电话、发邮件等功能
* UIApplicationDelegate应用程序代理对象
    * 应用程序已经启动，即将启动等信息

# 常见的应用代理方法
* 默认有6个方法
    * 当应用程序启动完毕
    * 应用程序即将失去焦点，非激活状态
    * 已经进入后台
    * 即将进入前台时执行
    * 已经变为激活状态
    * 应用程序将会被销毁

# 应用程序启动过程
* 已经知道应用程序对象及应用程序代理对象
* iOS应用程序的入口也是一个main函数启动，@autoreleasepool：应用程序的释放池。

* 在main行数中，调用UIApplicationMain(参数1，参数2，参数3，参数4)函数
    * 参数3：需要传一个类的名字（这个类应该是UIApplication或者是UIApplication类的子类），如果为nil，那么默认就是UIApplication
    * 参数4：需要传递一个"应用程序代理"类的名字，内部会根据这个类名，来创建对象，并且把这个对象作为应用程序代理对象。
* 为什么一运行就会加载main.storyboard控制器？
    * 在调用应用程序代理方法didFinishLaunchingWithOptions之前加载main.storyboard文件，创建里面的"初始化控制器"，然后创建这个控制器中的view。
* 不使用系统提供的main.storyboard，自己手动写代码来加载自己的控制器，设置view的背景色方便查看。
    * 创建窗口对象
    * 创建自定义的控制器
    * 设置窗口的根控制器器为自定义控制器
    * 将窗口作为主窗口并且显示出来。

# 应用程序启动过程补充
* UIApplication、AppDelegate、UIWindow、UIViewController之间的关系
    * UIApplication 里面有个delegate属性。
    * appDelegate 里面有个window属性
    * 通过创建window，指定窗口的肯控制器即可显示界面。

* 模拟内存警告
    * 选中模拟器 -> Hardware ->  Simulate Memory Warning
    * 调用私有API实现：[[UIApplication sharedApplication] performSelector:@(_performMemoryWarning)]


# UIWindow
* UIWindow是一种特殊的UIView,通常在一个app中只有一个UIWindow
* iOS程序启动完毕后，创建的第一个视图控件就是UIWindow，接着创建控制器的view，最后将控制器的view添加到UIWindow上，于是控制器的view就显示在屏幕上了。
* -个iOS程序之所以能显示在屏幕上，完全是因为他有UIWindow的存在,也就是说，没有UIWindow,就看不见任何UI界面。
* 可以自己手动创建UIWindow

# 3种创建控制器的方式
* 纯代码的方式直接创建控制器 alloc + init
* 通过storyboard创建
    * 加载storyboard文件
    * 然后作为初始化控制器
* 通过xib文件创建控制器
    * 说明那个控制器要用这个xib，需要修改filesOwner的类型
    * 然后将fileOwner右键里面的view执行这个xib文件，才能去加载xib文件作为控制器的view。

# 通过xib文件创建控制器补充
* 创建一个同名去掉controller后缀的xib文件，并且修改filesOwner的类型，然后拖线
* 即使不去加载对应xib文件的名称，创建的控制器界面与xib文件的界面是一样的。

* 创建一个同名的xib文件的xib，修改fileOwner，并且通过拖线
* 加载起来就是这个同名的xib文件了。

# 控制器的view是懒加载的，在用到时才创建这个view
* 如何确定控制器的view是否创建？
    * 如果是第一次调用self.view就会调用对应的loadView方法创建一个view，如果前面设置过self.view的话就不会调用loadView方法了。
* 重写loadView方法，如果在窗口显示之前如果没有用到控制器的view就不会调用loadView方法，在窗口显示的时候就会调用loadView方法。
* 如果在窗口显示之前用到了控制器的view，就会直接调用loadView方法。

# 控制器view的生命周期
* view的加载过程 loadView -> viewDidLoad
* viewWillAppear -> viewDidAppear -> viewWillDisappear -> viewDidDisappear

# 多控制器管理_导航控制器的使用
* 多控制器的管理：什么时候跳转到哪个控制器，什么时候再回到哪个控制器
* 两种管理办法：
    * 通过导航控制器管理
    * 通过tabBar控制器(标签控制器)管理
* 控制器之间的父子关系：
    * 不是继承关系，而已一个控制器里面可以装着其他几个控制器
    * 导航控制器管理的演示
    * 创建3个测试控制器演示导航控制器的基本使用

# 多控制器的管理_导航控制器的使用2
* 在创建导航控制器的同时指定它的根控制器
    * 然后在进行操作时跳转到其他控制器
    * 先进后出、后进先出的原则。
    * 导航控制器入栈、弹栈的演示。

# 设置导航栏按钮
* 一个导航控制器只有一个导航栏。
* 每个界面所显示的导航栏不是去直接修改导航控制器的导航栏来设置的。
* 而是通过对应的控制器内部区设置它自己希望显示的按钮效果。
    * self.navigationItem.title来进行设置标题
    * self.navigationItem.titleView来设置控件
    * self.navigationItem.leftNavigationItem设置左侧按钮
    * self.navigationItem.rightNavigationItem设置左侧按钮

# 通过storyboard使用导航控制器
* 拖一个导航控制器进去，默认有个一UITableViewController的根控制器
* 可以删掉，拖一个UIViewController作为导航控制器的根控制器
* 设置左右两侧按钮
* 两个控制器跳转之间的连线叫做segue：过渡
* 只有导航控制器的根控制器才有navigationItem，其他的跳转过去的控制器是没有navigationItem的，需要自己去拖一个进去。






















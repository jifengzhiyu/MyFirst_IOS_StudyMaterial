//1. 应用程序名称的国际化
//* 案例: 微信、微博等案例
//- "微信"、"WeChat"
//- "微博"、"Weibo"
//
//* 演示步骤:
//1> 选中项目, 添加对中文、英文的支持。选中项目在Localization下选择Language。
//2> 在 info.plist 中添加一个Bundle Display Name 的项, 然后查看对应的原生的键的名称.
//3> 在 Supporting Files 下面添加一个 InfoPlist.strings 的文件
//4> 选中 InfoPlist.strings, 点击右侧的 Localize 按钮, 然后点击 Localize
//5> 然后勾选 English、Chinese, 在 InfoPlist.strings 下会出现多个文件。
//6> 在每个文件中编写对应的键值对, 如下:
//English:
//"CFBundleDisplayName" = "WeChat";
//Chinese:
//"CFBundleDisplayName" = "微信";
//7> 这时, 直接切换模拟器（或真机）的语言（中文、英文）的时候, 应用程序名字会自动发生变化。
//
//
//
//
//2. storyboard 文件中, 控件的国际化(在模拟器上调试可能是有问题的)
//1> 布局一个登录界面
//2> 默认的文字都用中文
//3> 布局好了以后, 选中该 storyboard 文件, 在右侧的工具箱中, 选择"文件审查器", localization, 勾选中文、英文。
//4> 然后会出现多个 storyboard 文件, 在对应的文件中修改语言则可。
//• 注意, 这个在模拟器上运行有问题, 需要在真机上运行。
//
//
//
//
//3. 演示弹出的 UIAlertView 的国际化(Localizable.strings也依赖系统的语言)
//* 思路: 通过配置多个不同的.strings文件, 来指定在不同情况下的显示不同的语言
//1> 创建一个名字为Localizable.strings的文件
//2> 选中该文件, 在右侧的"文件审查器"中, 点击 Localize 按钮, 勾选中文、英文。
//3> 在对应的中文、英文文件中, 添加一些需要国际化的键值对
//4> 在代码中通过NSLocalizedString(@"key", nil);的方式获取对应的键值.这个方法内部会根据系统的语言, 去读取对应的键值。
//
//
//4. 实现类似"新浪微博"、"微信"切换语言的效果(点击切换语言后立刻切换, 无需设置手机的语言)
//* 思路:
//1> 自定义多个不同的.strings 文件
//- language_CN.strings
//- language_EN.strings
//
//2> 通过下面的代码手动加载对应的.strings 文件
//NSLocalizedStringFromTable(<#key#>, @"language_CN", nil);
//NSLocalizedStringFromTable(<#key#>, @"language_EN", nil);
//
//3> 放两个按钮, 点击中问按钮, 读取中文的strings 文件, 点击英文读取英文的 strings 文件, 然后当前使用的是哪种语言, 就把这种语言保存到"偏好设置中", 下次 viewDidLoad 的时候直接读取偏好设置中的语言配置。

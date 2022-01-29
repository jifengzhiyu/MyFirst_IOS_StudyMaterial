我的彩票实现步骤：
1. 新建项目。
* 按照 MVC的方式来分项目的 Group
- 六大模块 + 一个主框架模块
1> 启动向导模块
2> 购彩大厅模块
3> 竞技场模块
4> 发现模块
5> 开奖信息模块
6> 我的彩票模块
7> 主框架模块
** 注意这里介绍创建 Group 的快捷方式, 直接在项目目录下, 创建文件夹, 然后复制, 最后把所有文件夹拖拽到项目中, 选则创建 Group即可。当程序发布的时候不会将 Group 生成文件夹, 所以这样做仅仅是管理项目方便, 不会影响将来的发布程序。（另外: 发布程序的时候记得, 选择 release 后在生成发布）

* 拷贝图片素材

* 设置AppIcon、LaunchImage
- 在设置LaunchImage的时候, 按住 option 键, 为4 inch 的 ios7和 ios8系统下拖拽一个启动图片

* 设置项目允许运行在 iOS7.1下

* 说明, 这个项目并不是真正的适配 iPhone6 和 iPhone6 Plus, 因为没有提供对应的启动图片, 实际上还是把屏幕分成了宽320个点, 高568个点（4 inch）。

* 设置显示启动图片的时候不显示状态栏(选中项目, 勾选 Hide Status Bar, 这样就在启动时不显示状态栏了)
- 注意: 
1> 当通过 UIApplication 对象统一设置状态栏为白色文字的时候, 勾选 Hide Stauts Bar会导致, 程序启动完毕也不显示状态栏
2> 解决: 需要通过 UIApplication 对象再把状态栏显示出来,参考代码如下:
/** 参考代码:
	// 显示状态栏
    application.statusBarHidden = NO;
    // 设置所有的状态栏的文字颜色为白色
    application.statusBarStyle = UIStatusBarStyleLightContent;
*/


* 去掉Landscape Left 、LandScapeRight, 不支持横屏







2. 分析整体的架构
- 主框架使用代码来搭建, 在AppDelegate.m通过代码创建UITabBarController
- 6个模块分别使用6个不同的 storyboard 文件来描述, 每个 storyboard 文件中的初始化控制器都是一个导航控制器
- 先创建出了"导航模块"以外的其他5个模块
- 在主UITabBarController控制器中动态加载5个storyboard文件, 把每个storyboard文件中的导航控制器加到主UITabBarController控制器中。








3. 封装一个自定义的UITabBarController控制器: HMTabBarController
- 在 HMTabBarController 控制器创建好的同时, 内部就已经自动加载好5个导航控制器了



4. 演示, 使用系统 TabBarButton 时, 设置图片的问题
- 新建一个项目, 演示设置 TabBarButton 的图片尺寸不正常问题, 所以要自定义 TabBar
- 同时设置每个导航控制器的 TabBarbutton








5. 自定义 UITabBarController 下的 TabBar 菜单(最下面的菜单)
1> 创建一个自定义的UIView, HMBottomBarView
2> 在该HMBottomBarView下动态创建5个按钮, 分别设置每个按钮的背景图片为 TabBar 的素材图片
- 通过重写HMBottomBarView的 initWithFrame:方法创建内部的按钮, 设置按钮背景图片
- 通过重写- (void)layoutSubviews方法设置每个按钮的 frame
- 介绍按钮的几种状态:"Normal"、 "Highlighted"、"Selected"、"Disabled"
3> 然后在viewDidLoad 中, 把自定义的HMBottomBarView添加到self.view 中, 并移除系统的 tabBar







6. 实现被点击的按钮变成"高亮图片"
* 思路: 当点击按钮的时候把当前被点击的按钮状态改为 selected 状态。
- 注意: 这里要使用UIControlEventTouchDown事件, 不要使用UIControlEventTouchUpInside事件
- UIControlEventTouchDown事件一按下就会触发, 而UIControlEventTouchUpInside事件在弹起来的时候才会触发



* 问题: 所有被点击过后的按钮都变成高亮状态了?
* 解决: 通过一个属性, 记录当前被点击的按钮, 当点击下一个按钮的时候, 把上一个按钮的状态改回去。



7. 解决按钮按下时, 高亮显示问题
* 问题: 当长按某个按钮的时候, 依然显示的是高亮的图片, 不会显示默认的(黑色图片)。
* 思路: 
- 重写按钮的setHighlighted方法, 什么都不做。那么按钮就不存在高亮状态了。
- 自定义一个按钮类, 重写按钮的 setHighlighted 方法, 里面什么都不做。
* 其他:
- 注意: 同时设置按钮的 highlighted 状态图片与 selected 状态图片有问题, 所以这里不要设置 highlighted 状态的图片, 只设置 selected 状态的图片.
- 所以也无法通过设置button.adjustsImageWhenHighlighted = NO;来实现



8. 实现点击TabBar按钮, 切换控制器。
* 问题1: 如何在TabBarController中切换控制器?
- 解决 : 设置TabBar控制器的selectedIndex属性。 self.selectedIndex

* 问题2: 如何在自定义的BottomView中获取TabBar控制器。
- 解决 : 通过代理。参考方法名: - (void)bottomBarViewDidClickBottomButton:(HMBottomBarView *)bottomBarView withIndex:(NSInteger)index




9. 设置默认第一个控制器的按钮为 selected 状态。（第一个控制器的按钮被选中）
* 思路: 在循环中判断，如果是第一个那么，手动调用一下点击事件，把当前按钮传递进去
- 相当于, 设置按钮的 selected 为 YES, 同时将该按钮设置给 self.selectedButton。




10. 代码重构
* 问题: 底部 HMBottomBarView中到底有多少个按钮, 取决于向 TabBarController 中添加了多少个子控制器, 而不是固定死的就是5个按钮
- 解决: 
1> 在HMBottomBarView中添加一个对象方法, 这个方法的功能就是向HMBottomBarView中添加一个按钮
2> 在每次向 TabBarController 中添加一个子控制器的时候, 顺便向HMBottomBarView中添加一个按钮
3> 参考方法名:
- (void)addBottomBarButtonWithImageName:(NSString *)name selectedImageName:(NSString *)selectedName tagId:(NSInteger)tag selected:(BOOL)selected;
4> 参考代码:
/** 参考代码

- (void)addBottomBarButtonWithImageName:(NSString *)name selectedImageName:(NSString *)selectedName tagId:(NSInteger)tag selected:(BOOL)selected
{
    HMBottomBarButton *button = [[HMBottomBarButton alloc] init];
    
    button.tag = tag;
    button.selected = selected;
    if (button.selected) {
        self.selectedButton = button;
    }
    // 设置按钮的背景图片
    [button setBackgroundImage:[UIImage imageNamed: name] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
    
    
    // 为按钮注册单击事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 把按钮添加到父控件中
    [self addSubview:button];
}

*/


11. 设置导航栏的红色图片背景和白色文字
* 思路:
1> 可以单独设置每个导航控制器的导航栏背景图片和文字颜色
/** 参考代码:
UINavigationController *navHall = [self loadControllerWithStoryboardName:@"Hall"];
    
[navHall.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
*/

2> 统一设置
- 获取所有导航控制器的导航栏的外观代理对象, 然后通过外观代理对象统一修改导航栏的外观
/** 参考代码:
	// 1. 获取导航栏的"外观"代理对象
    UINavigationBar *navBarProxy = [UINavigationBar appearance];
    // 2. 统一设置背景图片
     [navBarProxy setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    // 3. 统一设置所有导航栏上的 title 的文字样式
    NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBarProxy setTitleTextAttributes:attrs];
*/



12. 设置所有的状态栏文字为白色
* 思路1: 通过在控制器中实现- (UIStatusBarStyle)preferredStatusBarStyle方法来控制状态栏。
** 注意: 实现preferredStatusBarStyle方法需写在导航控制器中, 不能写在TabBar控制器中。

* 思路2: 通过UIApplication统一设置状态栏。
1> 先修改info.plist文件, 增加一个项: View controller-based status bar appearance = NO
2> [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
** 注意: 如果勾选了Hide Status Bar, 那么当设置了上面的白色状态栏后，就看不到状态栏了。在代理方法的程序启动完毕的方法中执行: application.statusBarHidden = NO;




13. 设置每个模块的导航栏具体内容, 在不同的 storyboard 中设置
1> 购彩大厅左上角的"活动"按钮
- 思路1: 直接放一个 UIBarButtonItem, 但是这样的话设置完图片后, 图片模式是渲染成了蓝色, 需要手动修改图片的渲染模式。
/** 参考代码:
	UIImage *img = [UIImage imageNamed:@"CS50_activity_image"];
    [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
*/
- 思路2: 
• 直接在左上角放一个 UIButton
• 然后设置 UIButton 的Image图片属性, 不要设置背景图片(不会自动根据图片调整按钮大小)
• 设置按钮高亮不调整图片Highlighted Adjusts Image


2> 设置"竞技场"
- 设置竞技场的导航栏背景图片
• 单独为竞技场导航控制器创建一个自定义导航控制器类
/** 参考代码:
// 设置导航栏背景
[self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NLArenaNavBar64"] forBarMetrics:UIBarMetricsDefault];
*/

- 设置竞技场的控制器背景图片
• 创建一个自定义 view, 重写该自定义 view 的 drawRect:方法, 把背景图片绘制上去
/** 参考代码:
- (void)drawRect:(CGRect)rect {
    UIImage *bgImg = [UIImage imageNamed:@"NLArenaBackground"];
    [bgImg drawInRect:rect];
}
*/

- 设置竞技场的 titleView控件的外观
• 设置 Segmented Control的 背景色 tintColor 值为: R:25, G:158, B:159  (setTintColor:)
• 设置 Segmented Control的 选中项的文字颜色（setTitleTextAttributes:）, 为竞技场自定义一个控制器类, 在控制器类中设置
/** 参考代码:
	// 设置 segmented control 的选中项的文字颜色
    NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.scTitle setTitleTextAttributes:attrs forState:UIControlStateSelected];
*/


- 设置Segmented Control 的宽度为150(提示, 如果是使用 storyboard 文件创建的 Segmented Controll, 那么要在 storyboard 文件中修改宽度, 在代码中修改可能无效)
• 修改方式: 选中 storyboard 文件, 右键, open as source code
/** 参考代码:
关键代码: width="150"

<segmentedControl key="titleView" opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="top" segmentControlStyle="bar" selectedSegmentIndex="0" id="02s-S5-ohk">
                            <rect key="frame" x="219.5" y="7" width="150" height="30"/>
                            <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                            <segments>
                                <segment title="足球"/>
                                <segment title="篮球"/>
                            </segments>
                            <color key="tintColor" red="0.098039215686274508" green="0.61960784313725492" blue="0.62352941176470589" alpha="1" colorSpace="calibratedRGB"/>
                        </segmentedControl>
*/


3> "发现界面", 设置标题为"发现"即可。


4> "开奖信息"界面
- 设置导航栏右侧"开奖推送"按钮
• 由于 UIBarButtonItem 不能同时设置"图片"和"文字", 所以这里依然使用 UIButton
• 图片名称: Historyawards_pushSettings
• 设置"开奖推送"按钮的文字大小为16



5> "我的彩票"界面
- 左上角是"客服"按钮, 采用 UIButton (图片名称: FBMM_Barbutton)
• 设置按钮图片与按钮文字之间的间距为10
• 设置按钮文字大小为16

- 右上角是"设置"按钮, 采用 UIBarButtonItem (图片名称: Mylottery_config)
• 设置按钮的图片为白色
• 思路: 通过获取 UIBarButtonItem 的外观代理对象, 统一设置为白色 
/** 参考代码:
	// 设置所有拖拽到导航栏上的 UIBarButtonItem 的文字颜色
	UIBarButtonItem *barButtonItemProxy = [UIBarButtonItem appearance];
	[barButtonItemProxy setTintColor:[UIColor whiteColor]];

	// 或者, 直接设置导航栏的 tintColor
	// 设置所有导航栏 Item的颜色和 BarButtonItem的颜色
    [navBarProxy setTintColor:[UIColor whiteColor]];
	
*/




14. 完成"购彩大厅"模块。
* 需求: 点击活动按钮弹出一个新的 UIView。
* 思路: 
- 为"活动"按钮注册单击事件
- 单击"活动"按钮后执行的步骤:
• 创建一个"遮罩"的 UIView, 与屏幕一样大小, 添加到 UIWindow 中
• 再创建一个图片框, 添加到 UIWindow 中, 通过约束设置图片框水平、垂直居中显示
• 在图片框中创建一个"关闭"按钮UIButton, 设置背景图片、约束
•• 注意: 添加到 UIImageView 中的按钮, 默认监听点击事件是无效的, 需要设置父容器(UIImageView)的userInteractionEnabled = YES;

/** 参考代码:
// 点击活动按钮
- (IBAction)btnShowActivity {
    // 1. 弹出一个 UIView 遮罩
    UIView *viewCover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    viewCover.backgroundColor = [UIColor blackColor];
    viewCover.alpha = 0.5;
    [[[UIApplication sharedApplication] keyWindow] addSubview:viewCover];
    viewCover.translatesAutoresizingMaskIntoConstraints = NO;
    self.coverView = viewCover;
    
    
    
    // 2. 创建一个图片框
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"showActivity"];
    [imgView sizeToFit];
    [[[UIApplication sharedApplication] keyWindow] addSubview:imgView];
    imgView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 设置图片框的约束（水平、垂直居中对齐）
    NSLayoutConstraint *hCon = [NSLayoutConstraint constraintWithItem:imgView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imgView.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [imgView.superview addConstraint:hCon];
    
    NSLayoutConstraint *vCon = [NSLayoutConstraint constraintWithItem:imgView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imgView.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [imgView.superview addConstraint:vCon];
    self.popImageView = imgView;
    
    
    
    // 3. 在图片框内部创建一个关闭按钮
    UIButton *btnClose = [[UIButton alloc] init];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"alphaClose"] forState:UIControlStateNormal];
    [btnClose sizeToFit];
    [imgView addSubview:btnClose];
    //[imgView bringSubviewToFront:btnClose];
    // 因为按钮是在图片框中, 所以如果图片框不能点击, 那么按钮也不能点击，所以要设置图片框允许与用户交互
    imgView.userInteractionEnabled = YES;
    
    [btnClose addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
    
    btnClose.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 通过约束显示在右上角
    NSLayoutConstraint *closeTopCon = [NSLayoutConstraint constraintWithItem:btnClose attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:btnClose.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [btnClose.superview addConstraint:closeTopCon];
    
    NSLayoutConstraint *closeRightCon = [NSLayoutConstraint constraintWithItem:btnClose attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:btnClose.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [btnClose.superview addConstraint:closeRightCon];
}
*/




15. 完成"竞技场"模块。
- 这个模块没有功能


16. 完成"发现"模块
1> 完成基本内容的显示, 使用"静态单元格"
- 注意1: 在 storyboard 中, 选中 TableView, 去掉水平、垂直滚动条
- 注意2: 自定义一个UITableViewController 类, 通过实现计算 header view 和 footer view 高度的代理方法, 来控制每组之间的间距

2> 完成每次重新运行后, "发现"界面从右向左通过动画的方式显示出来的效果。



3> 完成"合买"模块中的"全部彩种"按钮效果
- 调整返回按钮的文字颜色
* 思路: 获取所有导航栏的代理对象, 设置 tintColor
/** 参考代码:
	// 设置所有导航栏 Item的颜色和 BarButtonItem的颜色
    [navBarProxy setTintColor:[UIColor whiteColor]];
*/

- 设置"全部彩种"按钮效果
* 思路: 
• 默认按钮是图片在左边, 这里的图片要在右边, 那么思路就是重写, 所以就需要自定义一个按钮类
• 自定义按钮类, 通过重写- (CGRect)titleRectForContentRect: 方法和 - (CGRect)imageRectForContentRect:方法实现交换 titleLabel 和 imageView 的位置。
• 介绍 initWithCoder: 和 initWithFrame:方法, 在这两个方法中设置 titleLabel的字体 和 imageView 的图片显示模式


4> 实现"幸运选号"模块


5> 实现"返回"按钮都用 NavBack 图片替代。


6> 跳转到"合买"或者"幸运选号"的模块时, 不显示底部的 TabBar 菜单
* 思路设置被 push的控制器的Hide Bottom Bar On Push
* 但是由于这里使用的是自定义的 TabBar 所以不会被隐藏
- 解决: 把自定义的 TabBar 放到系统的 TabBar 里面, 不要删除系统的 TabBar

* 如果有很多的子控制器, 那么需要在每个控制器中都设置Hide Bottom Bar On Push属性, 比较麻烦, 所以抽取一个控制器的父类
- 重写导航控制器的- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated方法




17. 开奖信息中的"开奖推送", 这个稍后再实现, 与"我的彩票"中的"设置模块"一起实现。


18. 实现"我的彩票"模块
1> 实现"登录"界面
- 介绍图片框对图片的拉伸方式
- 介绍按钮无法直接在 storyboard 中设置对按钮的背景图片的拉伸, 所以需要通过代码来实现。



2> 实现"设置模块"
* 分析:
一、 使用静态单元格
二、 使用动态单元格
• 直接在数据源方法中通过 if-else 来判断
• 通过读取 plist 文件的数据来编写数据源方法
• 通过自定义模型的方式来编写数据源方法

三、创建模型
- 创建一个 Cell 对应的模型 HMSettingItem
• 该模型中包含的属性:icon、title、target(目标控制器)
• 分析: 最右侧的 accessoryType 是否有也要写一个属性到HMSettingItem中?
• 结论: 不要, 而要通过子类来实现。原因:1> 通过子类更面向对象(开放封闭原则) 2>可能不同的 accessoryType 对应的类中有不同过的代码, 不简简单单是一个 accessoryType 不同。所以要通过继承来实现。
• 通过模型的方式实现"设置"模块的首页功能


- 封装一个组模型 HMSettingGroup
• 里面包含3个属性, 头部标题、尾部标题、所有的 HMSettingItem 模型
• 使用HMSettingItem + HMSettingGroup实现功能


- 封装一个自定义 Cell, 把模型传递进去, 然后 cell 内部解析模型数据, 并设置给子控件
• cell 的 selectionStyle = UITableViewCellSelectionStyleNone;这样就选中行的时候没有灰色背景了。

- 实现检察新版本












• 设置模块的 TableView 不采用静态单元格：
• 原因:
	1> ios7和ios6下效果差距很大
	2> 静态单元格在storyboard中设置，很多东西不灵活。
	3> 不利于后期扩展, 当系统的静态单元格功能不够时，扩展不方便。

- 设置返回按钮为NavBack 图片

- 

- 设置导航栏最右侧"常见问题"按钮


- 产品推荐模块
1> 加载more_project.json到模型数组
• 思路: 
- 先把 json 文件读取到 NSData 对象中
- 再把NSData 对象转换成字典的NSArray 对象
- 在把字典的 NSArray 转换成模型的 NSArray
/** 参考代码:
        // 加载 json 文件, 把 json 文件转换为二进制数据
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        
        // 把二进制的 json 数据转换为数组对象
        NSArray *arrayDicts = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
*/

2> 初始化 UICollectionViewController 的时候指定布局
/** 参考代码
- (instancetype)init
{
    // 瀑布流一般用来展示一些图片的
    // 我们这里使用流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 通过布局对象控制每个格子的大小、间距等
    // 设置每个格子的大小
    flowLayout.itemSize = CGSizeMake(80, 80);
    // 设置组内每个 cell 的垂直间距与水平间距
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    
    // 设置整个组的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 0, 0);
    return [super initWithCollectionViewLayout:flowLayout];
}

*/

3> 通过 xib 和代码创建单元格的两种不同方式来注册单元格类
/**
	// 通过 xib 创建Cell的注册方式
    UINib *nib = [UINib nibWithNibName:@"SteveZProductCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    
    // 通过代码创建Cell 的注册方式
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
*/



4> 为 UICollectionView 实现数据源方法、代理方法
/** 参考代码:
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取模型数据
    SteveZProduct *product = self.products[indexPath.row];
    
    
    // 创建 Cell
    SteveZProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor blueColor];
    
    // 设置数据
    cell.product = product;
    
    // 返回 cell
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld---%ld", (long)indexPath.section, (long)indexPath.row);
}
*/


5> 在自定义 Cell 中, 设置图片为圆角
/** 参考代码:
- (void)awakeFromNib {
    // Initialization code
    // 设置图片都是圆角
    self.imgViewIcon.layer.cornerRadius = 10;
    self.imgViewIcon.layer.masksToBounds = YES;
}

*/



- "常见问题"模块（帮助）模块

1> 加载@"help.json"到模型数组
/** 参考代码:
NSData *jsonData = [NSData dataWithContentsOfFile:path];
        NSArray *arrayDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
*/

2> 根据 html模型创建 item 模型, 并添加到 group 中
/** 参考代码:
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arrayItems = [NSMutableArray array];
    for (SteveZHelp *model in self.htmls) {
         SteveZSettingItem *item1 = [SteveZSettingItemArrow settingItemWithIcon:nil title:model.title];
        [arrayItems addObject:item1];
    }
    
    SteveZSettingGroup *group1 = [[SteveZSettingGroup alloc] init];
    group1.items = arrayItems;
    
    [self.groups addObject:group1];
}

*/

3> 实现 didSelectRowAtIndexPath:方法当选中某行的时候跳转到 html 页面
- 重写 didSelectRowAtIndexPath 方法, 采用 modal 的方式跳转
/** 参考代码:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SteveZHTMLViewController *destVc = [[SteveZHTMLViewController alloc] init];
    destVc.html = self.htmls[indexPath.row];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:destVc];
    
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}
*/
- 在控制器中显示网页思路:
1> 创建一个继承自 UIViewController 的控制器
2> 重写 loadView 方法, 将 self.view 替换成 UIWebView 对象
/** 参考代码:
- (void)loadView
{
    self.view = [[UIWebView alloc] init];
}
*/
3> 在 viewDidLoad 中加载对应的网页
• 获取网页的 url
• 创建 request 对象 [NSURLRequest requestWithURL:url];
• 让 webView 加载 request 对象[webView loadRequest:request];
/** 参考代码:
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 获取 WebView
    UIWebView *webView = (UIWebView *)self.view;
    
    // 设置 webView的代理
    webView.delegate = self;
    
    
    // 2. 通过 WebView 加载网页
    // 2.1 创建引用某个 html 文件的 url 对象
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.html.html withExtension:nil];
    // 2.2 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 2.3 发送请求, 加载网页
    [webView loadRequest:request];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style: UIBarButtonItemStylePlain target:self action:@selector(closeHelp)];
}

*/

4> 实现加载完毕某个网页后, 自动跳转到对应的"锚标记"处。
/** 参考代码:
// webView 加载完毕后执行
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 执行一段 js 代码
    NSString *jsCode = [NSString stringWithFormat:@"window.location.href = '#%@';", self.html.ID];
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
}

*/



- 关于界面
1> 关于界面下面的"打电话"的单元格需要在创建单元格的时候指定样式为 value1
2> 把电话指定成 subTitle





- 引导页（新特性界面）
1> 什么时候显示引导页
• 每次应用程序启动完毕后, 读取存储在 info.plist 中的软件版本, 与自己保存在"偏好设置"中的软件版本比较, 如果不一致, 证明有更新, 那么显示"引导页"
• 在应用程序启动完毕的代理方法中实现
/** 参考代码:
// 获取当前app的版本号
    NSString *ver = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 从偏好设置中读取上一次的版本号
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSString *lastVer = [usrDefault objectForKey:@"last_version"];
    if ([ver isEqualToString:lastVer]) {
        // 没有新版本
        SteveZMainTabBarController *mainController = [[SteveZMainTabBarController alloc] init];
        
        self.window.rootViewController = mainController;
    } else {
        
        SteveZGuideCollectionViewController *guideVc = [[SteveZGuideCollectionViewController alloc] init];
        self.window.rootViewController = guideVc;
    }
    
    [usrDefault setObject:ver forKey:@"last_version"];
    [usrDefault synchronize];
*/
2> 新建一个 UICollectionViewController作为引导页的主控制器
3> UICollectionViewController中的 self.view 和 self.collectionView 不是一个控件。
4> 初始化控制器的时候, 设置布局, 设置 cell 的大小等于屏幕大小
/** 参考代码 :
 - (instancetype)init
 {
     UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
     flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
     flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     flowLayout.minimumLineSpacing = 0;
     
     return [super initWithCollectionViewLayout:flowLayout];
 }
 */
5> 在 viewDidLoad中添加那些能"带动画"的内容
/**
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 
 [self.collectionView registerClass:[SteveZGuideCell class] forCellWithReuseIdentifier:reuseIdentifier];
 
 // 设置滚动条
 self.collectionView.showsHorizontalScrollIndicator = NO;
 self.collectionView.showsVerticalScrollIndicator = NO;
 self.collectionView.bounces = NO;
 self.collectionView.pagingEnabled = YES;
 
 
 // 添加导航页面上的图片控件。
 // 1. 添加大图片
 UIImageView *imgPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
 [self.collectionView addSubview:imgPicture];
 self.imgPicture = imgPicture;
 
 
 // 2. 添加大文字图片
 UIImageView *imgLargeText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
 imgLargeText.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.7, imgLargeText.frame.size.width, imgLargeText.frame.size.height);
 [self.collectionView addSubview:imgLargeText];
 self.imgLargeText = imgLargeText;
 
 // 3. 添加小文字图片
 
 UIImageView *imgSmallText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
 imgSmallText.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.8, imgSmallText.frame.size.width, imgSmallText.frame.size.height);
 [self.collectionView addSubview:imgSmallText];
 self.imgSmallText = imgSmallText;
 
 
 // 4. 添加波浪线
 UIImageView *imgWave = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
 imgWave.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width * 0.63, 0, imgWave.frame.size.width, imgWave.frame.size.height);
 [self.collectionView addSubview:imgWave];
 self.imgWavePic = imgWave;
 }
 */

6> 设置数据源方法, 整体分1组, 4个单元格, 同时编写一个自定义的 collectionView的 Cell,在里面放一个大图片框。
/**
 
 - (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 return 1;
 }
 
 
 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 return 4;
 }
 
 - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 
 SteveZGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
 
 // Configure the cell
 NSString *imgName = [NSString stringWithFormat:@"guide%dBackground", indexPath.row + 1];
 cell.guideImage = [UIImage imageNamed:imgName];
 
 [cell setCurrentPage:indexPath.row totalPages:4];
 
 return cell;
 }

 
 */















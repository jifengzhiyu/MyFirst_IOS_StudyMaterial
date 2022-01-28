1. 介绍按照MVC的方式分项目文件夹





2. 介绍UITableViewController
** 问题：为什么要使用 UITableViewController控制器
原因：更方便。

** UIViewController 控制器
self.view 是一个UIView 对象
复习UITableView的使用的方式 (UITableView + UIViewController实现)

** UITableViewController 控制器
注意: self.view 与 self.tableView 指的都是默认的那个 UITableView
UITableView 控件中默认的那个单元格是一个模板，功能类似于通过 xib自定义 Cell。






3. 自定义Cell (今天的主要知识点)
    3.1 通过xib自定义cell
    * 添加tableView
    * 加载团购数据
    * 新建xib，获取子控件
    * 封装
    * 最后引入headerView和footerView（插入广告，加载更多）

    3.2 通过代码自定义cell
    * 引入UITableViewController
    * 加载模型数据SteveZWeibo，用自带的cell展示基本数据
    * 新建一个SteveZWeiboCell，封装模型数据
    * 在init方法中添加4个子控件
    * 在set方法中给子控件设置数据
    * 在set方法中给子控件计算frame
    * 说明cell的高度无法计算
    * 设计SteveZWeiboFrame
    * 建立SteveZWeibo、SteveZWeiboFrame、SteveZWeiboCell的关系(提醒属性名不能叫做frame)
    * 性能优化



==================================================================================

一、 团购案例
1. 运行示例程序并分析
1> 整体是一个UITableView
2> 上面的UIScrollView是在tableHeaderView中
3> 下面的加载更多是在tableFooterView中
4> 整体只有一个Section
5> 团购案例还是采用普通的UIViewController + UITableView的方式实现


步骤:
0. 为项目分Models、Views、Controllers、Others"文件夹", 把不同的类放到不同的"文件夹"下
** 注意1: 此处的"文件夹"是虚拟的, 新建的时候叫做"New Group", 也就是说在实际磁盘上并不存在这些"文件夹"
** 注意2: 使用这种方式就保证了所有的文件都在mainBundle下


1. 拖拽一个UITableView到界面, 设置数据源

2. 设置控制器遵守数据源协议

3. 把图片素材与plist素材拖拽到项目中

4. 加载tgs.plist文件数据。使用模型数据。为了操作方便, 把模型的属性类型都变成字符串。
4.1> 创建模型类
4.2> 在控制器中通过"懒加载"的方式加载数据


5. 完成数据源代理的3个方法。
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

** 注意: 在下面的这个方法中, 先通过使用系统自带的Cell(使用SubTitle样式)把数据显示到界面上
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath



6. 系统自带的Cell不好用，那么使用"自定义Cell"


7. 自定义cell的两中实现方式:
7.1> 通过Xib实现
* 每个Cell中的内容是固定的, 控件个数、位置、尺寸等都一样的时候(团购案例)。

7.2> 通过自己写代码的方式来实现
* 每个Cell的结构不一样, 每个Cell中的控件的个数、样式都不一样的时候(微博案例)。





8. 通过xib方式实现自定义cell
8.1> 创建一个SteveZTGCell.xib文件。

8.2> 在xib中拖一个UITableViewCell, 设置高度为80, 宽度为屏幕宽度

8.3> 向UITableViewCell中拖子控件
* 拖一个UIImageView到Cell中, 设置里面的图片框的大小为80 * 60。X = 10 , y = 10
* 拖一个标题Label
* 拖一个价格Label
* 拖一个已购买人数Label
** 注意: 向Cell中拖控件, 默认就放在了ContentView中。
** 验证: 输出textLable的superView, detailLable的superViwe和cell的contentView的地址看是否一样。

8.4> 新建一个自定义的UITableViewCell类与xib中的这个Cell相关联
* 新建一个SteveZTGCell类继承自UITableViewCell
* 通过拖线的方式将Cell中的子控件拖线到SteveZTGCell的的属于性上, 方便将来使用


9. 改造数据源方法:cellForRowAtIndex中的创建cell的代码, 通过加载xib的方式来创建cell
9.1> 通过xib创建cell
UITableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SteveZTGCell" owner:nil options:nil] lastObject];

9.2> 为了可以重用xib中的Cell, 所以要设置xib中的cell的identifier。这个identifier, 就是将来的重用ID


10. 设置cell中的子控件的数据
10.1> 在外部访问不到cell中的子控件的内容, 解决办法: 把模型数据传递给cell对象, 由cell对象内部自己来解析模型数据, 并把数据设置到对应的子控件中
10.2> 在自定义Cell的类中创建一个模型类型的属性, 重写该属性的set方法，在set方法中将数据赋值给控件。


11. 至此完成数据列表的显示, 运行看效果


12. 把根据xib创建cell的代码封装到自定义的cell类中

13. 设置tableView.rowHeight = xib中的cell的高度。如果没有为tableView指定行高, 运行起来的时候会有警告。

** 注意: 按照mvc的方式分不同文件夹来存储数据


================================================================================
14. 实现"加载更多"按钮
** 思路: 在viewDidLoad方法中, 设置tableView的tableFooterView即可
** 为tableFooterView中增加一个按钮, 设置按钮背景色, 不设置按钮的frame, 查看效果
** 注意:
        1> footerView的宽度永远是与tableView的宽度一致, 不能修改
        2> y值永远是0, 不能修改
        3> 只能修改x和height的值

14.1> "加载更多"分析
* 距离两边有"间隙"
* 点击"加载更多"后, 会显示一个Label"正在努力加载"、等待指示器, 并且背景色变成了白色
* 结论: 底部的"加载更多"是由多个控件组成的, 所以可以考虑使用xib来实现


14.2> 实现"加载更多"功能
1. 新建一个xib
2. 在xib中拖拽一个UIView, 设置高度为44
3. 在UIView中拖拽一个UIButton, 设置按钮的背景色为"橘黄色"、x = 10, y = 2, height = 40, width = 355, 设置按钮上的文字为"加载更多"
4. 编写一个自定义的UIView类与xib中的UIView相关联
5. 为"加载更多"按钮设置单击事件
6. 封装一个"创建View"的类方法, 在控制器的viewDidLoad方法中创建该view, 并设置tableFooterView



***** 加载xib文件的另外一种办法 *****
1) UINib *nib = [UINib nibWithNIbName:@"" bundle:nil], nil表示使用mainBundle。根据xib文件创建nib对象。
2) UIView *vw = [[nib instantiateWithOwner:nil options:nil] lastObject]。获取xib中的某个view对象（控件）
***** 加载xib文件的另外一种办法 *****



7.  监听xib中的UIView中的按钮的点击事件。模拟点击时的"等待"效果。
** 分析: 点击"加载更多"的时候, "拼命加载"的Label和"等待指示器"同时显示或消失, 所以可以把这两个控件再放到一个UIView中。
1) 拖一个UIView到Cell中, 设置width = 200, height = 40, x = 85, y = 2
2) 再拖一个"等待指示器"和Label到该UIView中
3) 设置"等待指示器"的Animating属性和Hides When Stopped
4) 通过拖线使用一个属性来引用这个UIView, 通过这个属性就可以控制这个UIView显示或隐藏
5) 完成点击"加载更多"按钮的操作
具体步骤:
    * 隐藏"加载更多"按钮

    * 显示"等待指示器"所在的UIView

    * 向模型数组中增加一个新的模型数据(既然要向数据模型中动态添加数据, 那么模型数组需要使用可变数组)
    ** 分析: 通过代理实现.
    1> 如何找代理, 自己想做某件事, 但是无法做, 看谁能做, 那么谁就可以拉过来做代理。
    2> 要做什么事? 那么代理协议中就要编写对应的方法声明
    3> 在自定义的FooterView类中, 增加一个代理协议
    ** 注意: 因为现在是要为某个UIView(会加到界面)上的一个控件来编写代理, 所以代理属性delegate要使用weak关键字来修饰


    * 刷新UITableView
    ** 注意: reloadRowsAtIndexPaths:方法只能用于在tableView总行数不变的情况下刷新数据(删除原来某行, 在替换成某行), 对于原来就没有的行, 在删除的时候就报错了。
    ** 解决: 使用reloadData方法或者使用insertRowsAtIndexPaths:@[idxPath] withRowAnimation:
    ** 注意: 通过[self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];方法, 设置将某行滚动到view的最上方

    * 显示"加载更多"按钮, 隐藏"等待指示器"所在的UIView

    * 把"加载数据"和显示"加载更多"按钮、隐藏"等待指示器"的UIView放到一个延迟方法中执行
    /** 参考代码:
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
     });
     
     dispathch  + GCD 来记忆
     
     */





15. 实现头部的图片轮播器
** 分析: 头部的所有内容都是放到了tableHeaderView中, 直接设置tableview的tableHeaderview属性
** 头部内容包含:
1) 图片轮播器
2) 分割线（通过UIView来实现）可以改变透明度，使线变得更浅色
3) 猜你喜欢，UILabel
4) 在自定义View的awakeFromNib中操作UIScrollView。添加图片轮播器。

** 结论: 通过一个xib来实现headerView
** 步骤:
1> 创建一个xib文件
2> 拖一个UIView到xib中, width = 375, height = 200
3> 创建两根分割线、一个"猜你喜欢"Label、一个UIScrollView

** 问题: 因为UIScrollView是放在自定义的xib的UIView中, 所以编写操作UIScrollView的代码不能写到控制器中, 一定是放在对应的自定义view的类中。如果UIScrollView放在控制器的view中, 那么操作UIScrollView的代码可以写在viewDidLoad中, 但是现在这些操作UIScrollView的代码该写在哪里呢?
** 分析1: 要获取UIScrollView控件对象, 需要等到这个控件加载完毕以后才能获取, 那么在什么时候这个控件才会加载完毕呢?以前都是在控制器的viewDidLoad方法中操作UIScrollView, 因为当控制器的view加载完毕后, 就表示view中的所有子控件都创建(加载)好了
** 分析2: viewDidLoad表示控制器的view加载完毕以后执行, 那么在自定义view类中, 那个方法(事件)表示是当前view加载完毕后执行呢？
** - (void)awakeFromNib表示对象已经从xib中加载好了。这个方法是NSObject类的。

** 答: 在自定义View的awakeFromNib中编写操作UIScrollView的代码, 添加图片轮播器。





=========================================================================================
一、微博案例
** 微博案例中的难点:
1> 自定义cell, 这个案例中的自定义cell不是通过xib创建的, 而是通过完全自己写代码来创建的自定义cell。
2> 每个cell中的控件的个数、位置都不一定一样, 所以每个cell都需要手动写代码来根据不同情况, 创建不同的cell


0. 按照MVC的方式分目录、拷贝素材


1. 使用UITableViewController
* 如果使用了UITableViewController，那么控制器内部的view就是UITableViewController
* 并且自动设置了数据源、代理为当前控制器
* 并且UITableViewController已经遵守了数据源协议与代理协议


2. 新建一个自定义的控制器类, 继承自UITableViewController


3. 编写微博模型类(5个属性)
** 注意: 如果CGRect不能使用, 那么导入#import <CoreGraphics/CoreGraphics.h>

4. 懒加载数据

5. 实现3个数据源方法
* 只有1个section
* 数据条数就是微博模型的个数
* 实现- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath方法

6. 创建一个自定义Cell类SteveZWeiboCell继承自UITableViewCell


7. 重写该类的initWithStyle方法, 在创建好cell后，同时动态生成里面的控件和内容。
* 将所有可能显示的控件都加到cell中（数据、frame都不需要设置）
* 注意: 主要要把cell的子控件加到cell的contentView中
* 在自定义cell中, 通过属性来引用Cell中的子控件, 方便其他方法中使用这些子控件



8. 为自定义cell类增加一个模型(数据模型)属性, 重写该属性的set方法, 在set方法中设置控件的数据（内容）、位置（frame）等
* 封装setttingData、setttingFrame方法

* 实现setttingData, 根据模型设置子控件的数据
** 注意: 配图如果有再设置, 如果模型中的配图为nil, 则不需要设置UIImageView.image的值
** 注意: CUICatalog: Invalid asset name supplied: (null)原因：imageNamed:参数是空则报错。


* 实现settingFrame方法, 设置子控件的frame
1> 假设每个控件的间距都是固定的margin = 10
2> 计算头像图片的frame
iconW = 30;
iconH = 30;
iconX = margin;
iconY = margin;

3> 计算昵称的frame
* 根据昵称的文字计算昵称label的宽和高
** 影响昵称Label的高和宽的因素: 字体大小、文字多少、高度取决于是否固定了宽度（是否限制了最大的宽度和高度）
** [字符串对象 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil]
** 保证这里计算的时候使用的字体大小和创建Label时设置的字体大小一致, 使用一个宏来统一设置
** 根据昵称Label的宽和高, 计算x和y


4> 计算vip头像的Frame
vipW =15
vipH = 15


5> 计算正文的Label的frame
* 封装一个根据字符串计算size的方法
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
** 注意: 限制正文的宽度为355, 高度不限制
** 现在viewDidLoad中暂时修改行高300, 然后查看效果
** 设置Label中的文字可以换行(numberOfLines = 0 表示允许换行显示)


6> 计算配图的frame
pictureW = 100
pictureH = 100


7> 动态计算每个行的行高
* 根据是否有配图, 来决定单元格的高度是配图的最大的Y值 + margin, 还是正文的Label的最大的Y值 + margin




9. 通过UITableView的代理方法来指定每行的高度
** 注意:
代理方法- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
会先于数据源方法tableView:(UITableView *)tableView cellForRowAtIndexPath:被调用。

** 解决: 在model中不仅包含每个控件的数据, 也包含每个控件的frame值。


10. 新建一个模型类, 这个模型中包含7个属性
* 1个数据模型属性
* 5个子控件的frame（都设置为只读的, 都是内部算出来的不是别人赋值的）
* 1个行高的属性（都设置为只读的, 都是内部算出来的不是别人赋值的）


11. 把设置vip图标的代码放到initWithStyle方法中, 因为只需要执行一次, 每条数据的这个图标都一样


12. 在settingData方法中, 判断当前的用户是否是会员
* 如果是则设置vip图标显示, 并且昵称文字为红色
* 如果不是则设置vip图标隐藏, 并且设置昵称文字为黑色



13. 解决cell重用时, 配图显示不正常问题
** 解决: 在设置数据的时候, 判断是否有配图
* 如果有配图, 则设置配图图片, 显示配图UIImageView
* 如果没有配图, 则设置配图图片隐藏











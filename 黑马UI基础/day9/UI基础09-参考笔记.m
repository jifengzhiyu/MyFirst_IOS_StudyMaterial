0. 当需要监听事件或进行对象间的通信的时候, 选择通知还是代理?

* 共同点
利用通知和代理都能完成对象之间的通信
(比如A对象告诉D对象发生了什么事情, A对象传递数据给D对象)

* 不同点
代理 : 一对一关系(1个对象只能告诉另1个对象发生了什么事情)
** 试想: 能同时设置某个对象的代理对象为其他10个对象吗？代理只能是1对1的。

通知 : 多对多关系(1个对象能告诉N个对象发生了什么事情, 1个对象能得知N个对象发生了什么事情)









** 问题: 如何监听设备旋转、电池电量改变、贴近脸部（近距离传感器）等事件?
** 答: 通过通知。

UIDevice类提供了一个单例对象，它代表着设备，通过它可以获得一些设备相关的信息，比如电池电量值(batteryLevel)、电池状态(batteryState)、设备的类型(model，比如iPod、iPhone等)、设备的系统(systemVersion)
通过[UIDevice currentDevice]可以获取这个单例对象

UIDevice对象会不间断地发布一些通知，下列是UIDevice对象所发布通知的名称常量：
UIDeviceOrientationDidChangeNotification // 设备旋转
UIDeviceBatteryStateDidChangeNotification // 电池状态改变
UIDeviceBatteryLevelDidChangeNotification // 电池电量改变
UIDeviceProximityStateDidChangeNotification // 近距离传感器(比如设备贴近了使用者的脸部)



UIDevice *dev = [UIDevice currentDevice];
NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
[center addObserver:self selector:@selector(m1:) name:UIDeviceOrientationDidChangeNotification object:dev];







1. 使用UITableView的"静态单元格"。
(注意: 使用静态单元格, 必须使用UITableViewController控制器)
    * 什么是静态单元格? 什么是动态单元格？
    1> 静态单元格不会随着数据的改变而改变, 当在storyboard中设计的时候是什么样子, 最后运行效果就是什么样子, 并且不会随着数据的变化而变化。如果要想改变静态单元格内容, 必须重新修改代码。
    2> 动态单元格在设计的时候只是将单元格的"框架（壳子）"设计好了, 设置好了位置、大小、背景色等基本信息, 里面的具体数据内容, 需要在程序运行时, 通过动态获取数据再显示到单元格中。优点: 只要修改了数据模型, 那么对应的单元格内容就发生变化了。


    * 什么情况下使用静态单元格？什么情况下使用动态单元格？
    1> 静态单元格使用场景: 有些界面的内容是固定的, 并且基本上不会发生任何改变, 此时使用"静态单元格"来创建该界面, 非常方便。
    2> 动态单元格使用场景: 有些界面的内容会随着数据的变化而不断变化, 这些界面都需要使用"动态单元格", 随时根据相应的数据而变化。


    ** 演示:通过数据源方法来实现"QQ动态"界面效果。(使用UITableViewController)
    1> 分析如果要把动态内容的数据使用plist文件来保存, 那么如何设计该plist文件。


    ** 演示:通过使用"静态单元格"的方式来实现"QQ动态"界面效果。
    /********************************************************************************************/
    (注意: 使用静态单元格, 必须使用UITableViewController控制器)
    /********************************************************************************************/


    * 静态单元格使用建议:
    1> 先保留1个Section, 1个Cell。
    2> 设置好这个Cell以后, 在设置section的个数以及每个section中行的个数。

    * 静态单元格设置大致步骤:
    1> 选中TableView设置Content为static cell（静态单元格）

    2> 删除静态单元格, 只保留一个。

    3> 选中TableView设置style为grouped

    4> 选中单元格, 设置设置style为basic、设置Accessory为Disclosure Indicator。

    5> 双击"Title"设置文字.

    6> 选中单元格设置Image属性为: found_icons_qzone
    6.1> 选中 UITableView设置 style 为 Grouped

    7> 选中tableView设置Section为 3。

    8> 选中第二个Section设置Rows为 2

    9> 选中第三个Section设置Rows为 3


    ** 注意: 当设置了数据源对象, 并且实现了数据源方法的时候, 即便有静态单元格也优先调用数据源方法来生成数据。







2. 动态加载"QQ好友列表"。

    ** 步骤:
    1> 创建Group模型对象、Friend模型对象
    ** 注意, 加载数据时, 要把friends属性由"字典"集合转为"模型"集合。

    2> 懒加载数据


    3> 实现数据源方法, 显示好友列表数据(虽然可以使用系统默认的Cell, 但还是建议封装一个自定义Cell。)。
    ** 自定义一个Cell类继承自UITableViewCell类, 实现封装创建可重用单元格的代码以及一个模型属性。
    ** 这个自定义Cell中只使用到了Friend模型数据, 没有用到Group模型的相关内容, 所以只传递一个Friend模型到Cell中即可


    4> 设置分组的Header内容。
    * 演示: 先演示通过Storyboard的方式操作按钮的现实效果（左对齐、内边距等。）
    ** 注意: 虽然这里的每一组的子元素样子是一样的, 但是不能使用 xib 来实现, 因为 在 xib 中无法拖拽一个UITableViewHeaderFooterView控件, 所以依然需要完全自定义一个UITableViewHeaderFooterView类
    /**
        由于此时的Header View不再是普通文字了, 所以使用如下代理方法设置Header View
     
        (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
     */


    ** 注意, 设置按钮内容水平左对齐
        // nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    ** 注意, 设置按钮内容的内边距
        // btnGroupName.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    ** 注意, 设置标题文字与按钮中的ImageView之间的间距
        // btnGroupName.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    ** 注意, 设置按钮文字大小(加粗，18号)
        // btnGroupName.titleLabel.font = [UIFont boldSystemFontOfSize:18];

    ** 注意, 设置label文字右对齐
    // lblCount.textAlignment = NSTextAlignmentRight;

    ** 注意, 设置label文字为灰色
    // lblCount.textColor = [UIColor grayColor];

    ** 注意, 在viewDidLoad中统一设置Section的行高:
    // self.tableView.sectionHeaderHeight = 44;


    5> 自定义UITableViewHeaderFooterViewe类。
    * 虽然这里的每一组的子元素样子是一样的, 但是不能使用 xib 来实现, 因为 在 xib 中无法拖拽一个UITableViewHeaderFooterView控件, 所以依然需要完全自定义一个UITableViewHeaderFooterView类
    * 在 viewDidLoad 方法中统一设置所有组的高度self.tableView.sectionHeaderHeight = 44;

    * 通过设置每一个UITableViewHeaderFooterViewe的 contentView 的背景色来观察每一个 header view。



    6> 点击展开、闭合分组
    * 思路:在TableView的数据源方法tableView:numberOfRowsInSection:中返回0, 则表示关闭。
        1> 为Group Header中的按钮注册单击事件
        2> 在Group模型中, 增加一个BOOL类型属性isVisible, 表示当前分组是否可见。（默认为NO）
        3> 在用户单击事件中修改该属性的值为原来值得反面。isVisible = !isVisible
        4> 同时要想执行tableView:numberOfRowsInSection:方法, 必须重新reloadData。
    ** 注意: 如果全都设置了，但是点击就是没有效果，那么检查一下是不是忘记在set方法中为模型对象赋值了, 所以isVisible永远都是NO。
        5> 局部刷新某组: 通过调用 tableView 的 reloadSections:方法来实现, 在 headerView 的 Tag中记录当前组的索引。

    /** 实现点击按钮, 打开\闭合组
        1. 为按钮注册单击事件
     
        2. 重写数据源方法中返回每个section的行个数的方法.
     
        3. 重新调用tableView的reloadData方法,(就会重新执行数据源方法, 就可以重新获取每个section的组的个数)
            ** 当这个section的组返回的个数是0的时候, 那么这个组看起来就"闭合"了.
     
        4. 在返回每个section的行的数据源方法中, 需要通过一个标记来判断当前应该返回0行还是实际的行数.
     
        5. 在headerView中无法直接刷新tableView, 需要通过代理来实现.
     */


    7> 旋转分组名称旁边的"三角图片"
    * 思路: 设置按钮中的ImageView旋转90度。通过transform
        1> 在按钮的单击事件中执行旋转:
        // self.btnGroupName.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);

        2> 旋转无效？原因: 当tableView重新reloadData的时候, Header View被替换了, 变成了新的Header View。也就是说已经旋转了, 但是当reloadData的时候, 又产生了一个新的Header View, 所以看不到效果了。【解决: 在reloadData以后, 在新的Header View 加进来以后, 再执行旋转, 使用UIView的】
        **注意: 不能重用Header View的原因是调用了reloadData方法了。”重用Cell”、”重用headerView”指的是在滚动的时候重用。
        /** 参考代码:
         - (void)didMoveToSuperview
         {
             // 旋转
             if (self.group.isVisible) {
                self.btnGroupName.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
             } else {
                self.btnGroupName.imageView.transform = CGAffineTransformMakeRotation(0);
             }
         }
         
         */

        3> 旋转变形？原因: 按钮中的ImageView本身并没有发生大小改变, 当旋转的时候ImageView中的内容（图片）发生了旋转, 同时为了适应ImageView, 被拉伸了, 所以变形。【解决: 设置按钮中的ImageView的内容模式为"居中显示", 不拉伸】
        // btnGroupName.imageView.contentMode = UIViewContentModeCenter;

        4> 图片旋转后被裁减了? 原因: 当图片旋转后, 如果不自动缩放、拉伸, 会有部分内容超出ImageView, 那么此时imageView会自动不显示这部分内容。【解决: 设置ImageView不自动裁减】
        // btnGroupName.imageView.clipsToBounds = NO;



    8> 会员名字变成红色。


    9> 解决 header view 重用的时候, 按钮的三角图片显示不正常问题
    ** 在 setGroup 方法中重置单元格的图片旋转
    // 解决单元格重用的时候"小三角"图片旋转不正常的问题
    if (self.group.isVisible) {
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(0);
    }



3. "App管理"案例。
** 知识点:
    1> 使用UITableView中的Cell来代替xib。(使用storyboard 中的 UITableView的 Cell 模板, 代替 xib)
    2> 循环利用Cell时的一个问题。(注意点: 在重用Cell之前，需要重新设置Cell的数据和状态。)
    3> 复习代理。(点击自定义Cell中的按钮, 在控制器中显示一个对话框)

** 步骤:
    1> 使用UITableViewController。
    2> 创建一个自定义个Tabe View 控制器类, 与控制器关联。
    3> 创建model
    4> 懒加载apps_full.plist数据。
    5> 实现数据源方法
    6> 系统默认Cell不足以显示app单元格, 每个行的Cell样子一样, 所以想到了用xib。但是这里使用另外一个东西来代替xib。就是UITableView中的cell.
    7> 创建一个自定义的cell类与storyboard中的Cell相关联。
    8> 修改TableView的行高为60.
    9> 为storyboard中的Cell指定一个identifier(重用ID)
    10> 在数据源方法中, 调用HMAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appcell"];来创建Cell。该方法首先从缓存池中查找对应的可重用Cell,如果没有则去storyboard中查找与identifier相同的Cell。
    11> 演示创建不同的Cell模板（需要为每个CEll指定不同的identifier）,加载的时候根据不同的identifier来加载不同的Cell。

    /*** 参考代码: 加载storyboard中的cell的方式:
     - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
         // 这个方法会先尝试从队列中查找，找不到则取storyboard中找identifier的值为@“appcell”的单元格。
         HMAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@“appcell”]；
         
         cell.app = self.apps[indexPath.row];
         
         cell.delegate = self;
         
         return cell;
     }
     
     */

    12> 为自定义Cell类传递数据。
    13> 点击下载:
        1. 禁用下载按钮
        2. 显示"已下载"。通过代码或者设置Disabled状态下显示文字为"已下载"
        3. 弹出提示对话框。
    14> 解决循环利用Cell的时候"下载"按钮的状态问题。
        ** 注意: 当循环利用Cell的时候, 每次使用Cell前不仅要修改Cell的数据, 还要修改Cell状态。
        ** 在模型中增加一个BOOL类型属性donwloaded, 用来标记是否已经下载, 如果是, 则在设置数据的时候禁用该按钮，否则启用。



    /** 参考代码:
     在解决循环利用cell的那里补充:
     - (void)setApp:(HMApp *)app
     {
         _app = app;
         
         self.lblTitle.text = app.name;
         self.imgViewIcon.image = [UIImage imageNamed:app.icon];
         self.lblDownload.text = [NSString stringWithFormat:@"大小:%@ | 下载量:%@", app.size, app.download];
         
         if (app.isDownloaded) {
             [self.btnDownload setTitle:@"已下载" forState:UIControlStateNormal];
             self.btnDownload.enabled = NO;
         } else {
             [self.btnDownload setTitle:@"下载" forState:UIControlStateNormal];
             self.btnDownload.enabled = YES;
         }
     }

     */


4. 作业: 新闻列表。演示功能




================================== 其他需要注意点 ==================================
* 某个控件显示不出来可能的原因：
1. frame属性，是否为0，位置不对
2. hidden = YES
3. 是否添加到了父控件中
4. Alpha < 0.01
5. 被其他控件挡住了。
6. 检查父控件的上面这5种情况。


* 注意: 在重写layoutSubviews方法的时候, 不要忘记调用父类的layoutSubviews方法, 否则按钮点击无效果、不会切换normal与highlighted效果等。
// [super layoutSubviews];
* 注意: layoutSubviews方法在当某个控件的frame发生改变时, 会自动调用。在这个方法中可以重新布局子控件。

* 提示: - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 设置每个Section的高度。

* 注意: 大多数UIView的子控件在执行init方法的时候或者刚执行完毕init方法的时候frame的值都是0, 需要我们手动来设置, 或者系统在某个时候自动设置。

/************************************************************************/
补充: 解释一个问题：为什么每次懒加载数据的时候都要创建一个新的NSMutableArray数组？原因是一开始属性是nil。
/************************************************************************/





/************************************************************************/
发课表!!
/************************************************************************/



kvc补充:（Key Value Coding）
** 思路:
1> 创建一个 Person 类, Dog 类, 让 Person 类拥有 Dog属性。
2> 通过普通写代码的方式为对象赋值。
3> 创建一个字典对象, 通过 setValuesForKeys方法为对象赋值
NSDictionary *bz = @{
                      @"name" : @"任智超",
                      @"age" : @28,
                      @"email" : @"rzc0714@163.com",
                      @"dog" : @{@"name" : @"加肥猫"}
                      };

* 设置完毕后验证设置效果

4> 通过 valueForKeyPath获取每个属性的值。

5> 通过setValueForKeyPath设置某个属性的值。

6> 通过 dictionaryWithValuesForKeys: 把对象转换成字典。(参数是要把对象的哪些属性转换成字典)

------------------------
1. setValuesForKeys方法
2. setValueForKeyPath
3. valueForKeyPath
4. 把对象转字典: dictionaryWithValuesForKeys
5. 把数组中的每个属性的值返回, 拿到一个新的数组. 调用数组的valueForKeyPath方法
6. 通过KeyPath访问嵌套的属性valueForKeyPath



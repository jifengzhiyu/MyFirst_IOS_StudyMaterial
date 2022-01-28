1. 介绍QQ聊天的基本功能
注意点:
* 下面文本框不是footerView,因为不会随着UITableView一起滚动
* 不能使用UITableViewController,因为UITableViewController中的view默认就是UITableView
* 实际做法:
1> 使用普通UIViewController,上面拽一个UITableView, 然后下面留出44高度
2> 底部放一个UIView，然后设置背景图，向其中添加子控件
* 为什么底部不用imageview，因为在xib或者storyboard中，直接拖控件无法成为imageview的子控件。通过代码可
* 小图片设置按钮的image属性，不要设置背景，会自动拉伸
* 设置聊天文本框的背景图片，为了保证在ios6,7下效果都一样



2. 搭建界面


3. 创建数据模型类(type使用枚举)、 创建frame模型类

/************************ 定义一个枚举 ****************************/
typedef enum {
    SteveZMessageTypeMe = 1, // 表示自己发的消息
    SteveZMessageTypeOther = 1 // 表示对方发的消息
    
} SteveZMessageType;
/************************ 定义一个枚举 ****************************/



4. 懒加载数据, 数组使用NSMutableArray, 因为聊天内容会不断增多



5. 设置UITableView的数据源对象, 实现3个数据源方法



6. 编写frame model 中的set方法, 在该方法中根据数据模型计算坐标


7. 编写自定义的Cell。重写initWithStyle方法, 在该方法中动态创建子控件
* 显示时间的Label、头像UIImageView、正文Label


8. 计算坐标


9. 封装"根据字符串"计算大小。 封装到字符串的分类中。


10. 计算行高


11. 美化外观, 取消行与行之间的分割线


12. 取消UITableView的行的选中高亮显示(tableView.allowsSelection = NO)


13. 设置tableView的背景色, 设置cell的背景色为clearColor


14. 在设置数据的时候, 根据时间间隔是否小于1分钟, 控制"时间Label"是否显示
* 关键如何获取上一条记录的"时间"
* 在懒加载的时候判断当前model和上一条（也就是模型数组中当前的最后一条）model的时间是否一致, 然后为frame model 增加一个是否需要显示时间的属性（needTime）


15. 设置正文的背景图
* 根据模型中数据的类型来设置背景图, 判断消息类型, 加载不同的图片

16. 拉伸背景图片
* 采用平铺的方式拉伸

* 使用UIImage对象的stretchableImageWithLeftCapWidth:<#(NSInteger)#> topCapHeight:<#(NSInteger)#>方法来拉伸


* 设置按钮中titleLable距离按钮的内边距的距离
1> 按钮宽度加大40, 高度加高30
2> 设置titleLabel距离按钮的内边距


17. 根据消息类型, 设置消息的文字颜色


18. 设置发消息的文本框的内容左边的空白
* 设置文本框的leftView属性, 添加一个新的UIView设置宽为10, 高为1
* 设置leftViewMode属性为always



19. 实现键盘的弹出效果
* 当键盘弹出的时候写代码
* 通过通知中心来监听键盘弹出事件
* 监听事件的3中方式:1> addTarget  2> 代理   3> 通过通知中心



20.通知中心
* 发布
* 监听
* 移除






21.
* NSNotificationCenter, 用来发布、监听通知
* NSNotification, 用来封装一个通知内容



22.
* 在控制器的viewDidLoad方法中让控制器监听键盘的UIKeyboardWillChangeFrameNotification通知（谁发的这个通知并不重要, 所以可以传递nil）。
* 滚动到最后一行
// 滚动到最后
NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
[self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];



* 在控制器的dealloc中移除监听


23.在UITableView的- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView事件中让键盘收回去




24. 把return键变成send键
* 选中文本框, 设置Return Key 属性的值为send




25. 监听Return Key的点击事件
1> 设置文本框的代理

2> 实现- (BOOL)textFieldShouldReturn:(UITextField *)textField方法。
* 在该方法中实现发送消息功能:
** 获取文本框的输入
** 新建数据模型、frame模型
** 将frame模型添加到模型数组中
** 刷新tableView
** 将tableView滚动到最后一行



26. 封装一个sendMessage:(NSString *)msg type:(HMMessageType)type方法, 实现自动回复功能















------------------------------------------------------------------------------------------------------
	7. 设置tableView数据源
	8. 加载数据，数组使用NSMutableArray，因为聊天内容会不断增多
	9. 封装一个message数据模型
		a. type使用枚举
	10. 封装一个frame模型
	11. 创建自定义cell
	12. 创建子控件的时候， 先用一个强指针指向，再用@property弱指针引用。
	13. 在setframe方法中可以将，数据、frame一起设置
	14. 计算坐标，先算最左边、最上边的控件的坐标
		a. 时间
			i. 宽度：整个屏幕
			ii. X,y = 0
			iii. 文字居中
		b. 头像

去掉tableview的分割线
设置Tableview背景色，清空cell的背景色。224/255.0
设置cell不能被选中tableview.allowsSelection = no



监听键盘的弹出事件，工具条向上移动的距离就是键盘的高度
通过通知机制监听键盘的弹出事件

通知的作用：多个对象之间进行通信。

1。通知的发布
2.通知的监听
3.通知的移除

一个应用程序只有一个通知对象。
	参考ppt
	代理，1对1的。
	通知，多对多。
	
	监听键盘中按钮的点击事件就是通过文本框的代理实现的。
	
	
	
	
	
	====================
	1. 拖一个tableView
	2. 设置底部工具条
	3. 懒加载数据（该数组数据，随着不断的聊天， 里面的数据会不断增加，所以使用NSMutableArray）
	4. 设置tableView数据源，让控制器遵守数据源协议。
	5. 自定义一个Cell类。重写initWithStyel方法，创建3个子控件，并添加到cell中。
	6. 在数据源方法的返回cell方法中，创建Cell。
	7. 不显示正文文字可能是因为按钮的文字颜色是白色。通过setTitleColor来改变。
	8. 去掉分割线
	9.     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	10. 设置tabelView背景色，为灰色。同时设置cell的背景色为clearColor(在自定义cell的initWithStyle方法中设置cell的背景色。)
	11.   self.tableView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
	12. 禁止Cell被选中。self.tableView.allowsSelection = NO;
	13. 计算行高
	14. 设置多个相同时间的Cell只显示最上面一个。
		a. 思路：获取当前模型的时间与上一个模型的时间比较，如果相同则不显示这个模型的时间
		b. 在frame中增加一个@property (nonatomic, assign) BOOL needTime;属性,如果为YES,则显示时间，否则不显示时间。
		c. 在懒加载数据的时候，就把该属性的值设置为YES或NO。
			i. 在新的模型即将添加之前，通过lastObject获取该模型对象。然后判断两个消息的时间是否一致。
			ii. =================================================================================
	15. 设置消息的背景图片，因为根据消息类型的不同，所以每次显示的图片背景不同，不是一次性初始化好的。
		a. 在设置数据与Frame的方法中设置背景。
		b. 按钮中的titleLable不能再小了。已经是极限了。
			i. 按钮，变大，里面的lable自然相对就小了。然后设置按钮的背景图片。然后lable就显示到图片中了。因为按钮一开始的大小就是文字的大小，所以按钮不可能再小了（按钮中的lable也不能再小了，）所以只能保持lable不变，放大按钮。通过按钮的self.textBtn.contentEdgeInsets属性来设置按钮与titleLabe的内边距
			ii. 解决背景图片变形的问题,调用Image的resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)方法，采用平铺的方式拉伸,而不要直接拉伸
		c. 封装拉伸图片的方法。
	16. 把图片拉伸功能封装成为一个UIImage的分类
	17. 计算文字大小的功能封装到一个NSString的分类。

=============在控制器中监听键盘frame改变事件=====================在viewDidLoad中监听
监听TableView的滚动，使用代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tableView.rowHeight = 200;
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    
    //======== 监听键盘的弹出事件 ========
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
   
}

// 当键盘的位置大小发生改变时触发
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 1. 获取键盘当前的高度
    NSLog(@"%@", note.userInfo);
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rect.origin.y;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    /// 2.将当前ViewController的View整体向上平移一个"键盘的高度"
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - screenH);
    }];
    
}




//======设置文本框左边空出一段距离
 UIView *leftVw = [[UIView alloc] init];
    leftVw.frame = CGRectMake(0, 0, 15, 1);
    
    self.txtMsg.leftView = leftVw;
    self.txtMsg.leftViewMode = UITextFieldViewModeAlways;

===========键盘的发送键================
把return键变成发送键,修改文本框的属性：Return Key 变为:Send
	1. 设置文本框的代理为当前控制器
	2. 控制器遵守UITextFieldDelegate代理协议
	3. 实现- (BOOL)textFieldShouldReturn:(UITextField *)textField代理方法，
	4. 设置新加的数据的"时间"的正确显示方式。
	

//=========监听键盘上的操作，就是监听文本框的一些代理方法
	设置文本框的代理为文本框。
	
	
	=====注意=======
	一开始先不要实现下面的方法
	//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
	//{
	//    return [self.messageFrames[indexPath.row] cellHeight];
	//}
	否则行高有问题，导致看到的数据有问题。
	
	
	================实现自动回复功能=================================
	封装发送消息功能到一个方法中
	
	实现自动回复动能。





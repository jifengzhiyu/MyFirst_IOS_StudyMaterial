UITableView备课笔记

0. 昨天的一个问题, 设置启动图片, 如果没有iphone6 的图片, 那么屏幕宽度问题。


1. UITableView很重要

2. UITableView就是表格控件

3. UITableView一般用来展示表格数据、可以滚动（继承自UIScrollView）、性能极佳
* 如果没有UITableView, 实现类似的功能只能自己通过循环创建控件, 性能差



4. UITableView 分两种样式:
1> Plain, 不分组的样式
2> Grouped, 分组的样式


======= 演示案例: 显示单组数据, 通过 UITableView显示一些数据，就分一组。


====== 演示案例: 分组显示数据, 通过 if-else 来显示不同洲的不同国家。并设置组头标题，组尾标题。
** 演示设置了分组标题以后, 把 UITableView的 style 改成 plain, 然后查看效果。


====== 通过加载 plist 文件的方式演示下面的案例cars_simple.plist文件。
5. 案例: 汽车品牌展示（演示分组显示数据）
1> 拖一个UITableView占满整个屏幕

2> UITableView展示数据需要:
* 数据源对象

一、UITableView展示数据的时候需要知道当前有几组? 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
** 注意: 不实现这个方法默认就是一组。


二、每一组有几行?
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section


三、每行显示什么内容?
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
这些内容就都在数据源对象中.
** 建议: 写代理方法的时候, 如果知道返回值, 那么就先写返回值, 然后会更容易找到对应的方法

** 分析上面的3个数据源方法的执行顺序次数

3> 通过if - else 的方式显示部分汽车品牌数据

4> 通过加载plist文件 + 模型方式实现



6. 查看plain样式与goruped样式的区别

========== 打开模拟器的设置界面, 演示到处都是 tableView的使用。


7. 展示单组数据, LOL英雄展示。
* 演示Cell的不同样式效果

* 加载plist数据

* 修改每行的行高, 介绍在 viewDidLoad 中统一设置行高tableView.rowHeight(如果行高都一样，一定要通过这个来设置（高效），不要要代理方法（低效）)
1> tableView.rowHeight（高效）
2> 通过代理方法实现: - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath（低效）


8. Cell的常见属性:

* imageView
* textLabel
* detailTextLabel

* accessoryType
* accessoryView

* backgroundColor , 设置单元格的背景颜色


* backgroundView, 可以利用这个属性来设置单元格的背景图片, 指定一个UIImageView就可以了。

* selectedBackgroundView , 当某行被选中的时候的背景。





9. tableView的常见属性:
* rowHeight , 可以统一设置所有行的高度

* separatorColor, 分隔线的颜色
* separatorStyle, 分割线的样式

* tableHeaderView, 一般可以放广告
* tableFooterView, 一般可以放加载更多




10. UITableView中的Cell的重用
* 解决性能问题
* 查看每个"数据源方法"的执行顺序


* 重点查看下面的方法的调用顺序
//这个方法每当有一个cell进入屏幕的时候就调用一次
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

* 默认情况下, 滚动离开屏幕的Cell会被销毁。（不断的创建销毁对象本身也比较耗费性能）

* 通过缓存池解决cell重用的问题, 离开屏幕的cell不被销毁, 而是被重用。

* 性能优化步骤:
1> 通过一个标识去缓存池中查找是否有对应的cellF
2> 如果有则取出来使用, 如果没有, 则创建一个。
3> 设置cell数据
4> 代码实现重用cell功能。
5> 优化cell_id变量。（注意标识命名要规范）

* 输出每个Cell的地址



11. 利用重用cell实现多组汽车品牌展示
一、
* 使用cars_total.plist
* 模型嵌套模型
** 注意, 这里使用的是模型套模型, 所以不能直接使用kvc了。需要通过把字典转模型的代码封装到Group模型中。



二、
* 实现右侧的索引栏
* 通过实现数据源协议的- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView

* 点击右侧索引栏中的文字, 会根据索引的顺序跳转到左侧对应的位置

* 获取group数组中的每个对象的title值, 并返回到一个NSArray中
[self.groups valueForKeyPath:@"title"]



12. 数据刷新

/*
    1. UITableView通过代理来监听某行被选中的事件。
 */

* 点击某行, 弹出对话框, 然后修改数据, 再把数据刷新到UITableView上。
1> 监听每个cell的点击事件
* 通过代理来监听,
** 选中某行: - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
** 取消选中某行: - (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath


2> 弹出UIAlertView
* 修来弹出对话框的样式
alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

* 根据索引获取指定的某个文本框
[alertView textFieldAtIndex:0]
[alertView textFieldAtIndex:0].text = hero.name;

* 通过UIAlertView的代理来监听对话框中的按钮的点击事件
* 实现UIAlertView的 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex代理方法

/** 参考代码:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 CZHero *hero = self.heros[indexPath.row];
 
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
 
 alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
 
 [alertView textFieldAtIndex:0].text = hero.name;
 
 // 记录当前点击的行的行号
 alertView.tag = indexPath.row;
 [alertView show];
 }
 
 #pragma mark - alertView的代理方法
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
 {
 // 判断点击的是哪个按钮
 if (buttonIndex == 1) {
 //获取文本框中的数据
 NSString *name = [alertView textFieldAtIndex:0].text;
 
 // 修改模型数据
 // 根据行号, 获取当前点击的行的模型数据
 CZHero *hero = self.heros[alertView.tag];
 hero.name = name;
 
 // 重新刷新TableView数据
 // 重新刷新整个TableView, UITableView会重新向datasource请求数据
 // 重新调用数据源方法
 // [self.tableView reloadData]; // 不好重新刷新整个TableView
 
 
 // 局部刷新
 // 创建一个indexPath对象
 NSIndexPath *path = [NSIndexPath indexPathForRow:alertView.tag inSection:0];
 
 
 
 [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
 
 }
 }
 */
































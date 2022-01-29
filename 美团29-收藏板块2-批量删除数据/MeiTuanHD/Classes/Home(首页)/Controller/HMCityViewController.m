//
//  HMCityViewController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMCityViewController.h"
#import "HMCityGroupModel.h"
#import "HMCitySearchResultViewController.h"


@interface HMCityViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *coverButton;

/** 搜索结果控制器*/
@property (nonatomic, weak) HMCitySearchResultViewController *citySearchVC;

/** 城市分组数据数据*/
@property (nonatomic, strong) NSMutableArray *cityGroupArray;

@end

@implementation HMCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"切换城市";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barBuutonItemWithTarget:self action:@selector(backButtonClick) icon:@"btn_navigation_close" highlighticon:@"btn_navigation_close_hl"];
    
    // 加载数据
    self.cityGroupArray = [NSMutableArray array];
    
    NSArray *cityGroup = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil]];
    
    for (NSDictionary *dict in cityGroup) {
        [self.cityGroupArray addObject:[HMCityGroupModel yy_modelWithJSON:dict]];
    }
    
    
    // 设置颜色
    //tintColor : 很多控件都可以使用这个属性来改变样式的颜色
    //self.tableView.tintColor = [UIColor redColor];
    
    self.tableView.sectionIndexColor = HMColorGreen;
    self.searchBar.tintColor = HMColorGreen;
}

#pragma mark - SearchBar 代理方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //1. 导航栏
    self.navigationController.navigationBarHidden = YES;
    
    //2. 背景图
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    
    //3. 取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    // 遍历子控件 --> 拿到那个按钮强制修改
    //searchBar.subviews[0] --> UIView.subviews
    //UINavigationButton --> 私有的 --> 父类肯定UIButton
    for (UIView *subView in searchBar.subviews[0].subviews) {
        
        // 遍历子视图, 如果发现子视图是一个按钮的之类, 那么就修改这个按钮
        if ( [subView isKindOfClass:[UIButton class]]) {
            //NSLog(@"sub: %@", subView);
            
            UIButton *subButton = (UIButton *)subView;
            [subButton setTitle:@"取消" forState: UIControlStateNormal];
        }
        
    }
    
    
    //4. 遮盖
    self.coverButton.alpha = 0.5;
    
//    UIButton *coverButton = [UIButton new];
//    coverButton.alpha = 0.5;
//    coverButton.backgroundColor = [UIColor blackColor];
//    coverButton.frame = CGRectMake(0, 44+15, 300, 300);
//    coverButton.tag = 10;
//    [self.view addSubview:coverButton];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    //1. 导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //2. 背景图
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    
    //3. 取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
    //4. 遮盖
    self.coverButton.alpha = 0;
    
    //5. 搜索框文字清空
    searchBar.text = @"";
    
    //6. 隐藏搜索结果控制器
    self.citySearchVC.view.hidden = YES;
}

#pragma mark 监听文字改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //如果搜索框有文字, 就显示结果控制器的 view
    if (searchText.length > 0) {
        
        //1. 显示 view
        self.citySearchVC.view.hidden = NO;
        
        //2. 传值
        self.citySearchVC.searchText = searchText;
        
    } else {
        self.citySearchVC.view.hidden = YES;
    }
}

#pragma mark 取消按钮点击
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //放弃第一响应者
    [searchBar resignFirstResponder];
}



#pragma mark 遮盖按钮点击
- (IBAction)coverButtonClick:(id)sender {
    //放弃第一响应者
    [self.searchBar resignFirstResponder];
}

#pragma mark - TableView 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityGroupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //1. 获取对应行的模型数据
    HMCityGroupModel *cityGroupModel = self.cityGroupArray[section];
    
    //2. 返回模型的子城市数据的个数
    return cityGroupModel.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    //1. 获取对应分区的模型数据
    HMCityGroupModel *cityGroupModel = self.cityGroupArray[indexPath.section];
    
    cell.textLabel.text = cityGroupModel.cities[indexPath.row];
    
    return cell;
}

#pragma mark TableView 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //1. 获取对应行的模型数据
    HMCityGroupModel *cityGroupModel = self.cityGroupArray[section];
    
    return cityGroupModel.title;
}

#pragma mark 设置分区的索引标题
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //方法一: 获取所以的 title, 生成一个数组返回 --> 遍历数据
//    NSMutableArray *tempArray = [NSMutableArray array];
//    for (HMCityGroupModel *model in self.cityGroupArray) {
//        [tempArray addObject:model.title];
//    }
    
    //方法二: 使用 kvc
    return [self.cityGroupArray valueForKey:@"title"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 获取分区的数据模型
    HMCityGroupModel *cityGruopModel = self.cityGroupArray[indexPath.section];
    
    //2. 发送通知
    [HMNotificationCenter postNotificationName:HMCityDidChangeNotifacation object:nil userInfo:@{HMSelectCityName: cityGruopModel.cities[indexPath.row]}];

    //3. 消失控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 返回按钮点击
- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载
- (HMCitySearchResultViewController *)citySearchVC
{
    if (_citySearchVC == nil) {
        //1. 创建 VC
        HMCitySearchResultViewController *citySearchVC = [HMCitySearchResultViewController new];
        
        //2. 添加成子控制器
        // 实现1个控制器里显示另一个控制器的内容 VC 强引用view
        [self addChildViewController:citySearchVC];
        
        //3. 添加 view
        [self.view addSubview:citySearchVC.view];
        
        //4. 布局
        //4.1布局单条边: autoPinEdge:toEdge:ofView:
//        [citySearchVC.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.tableView withOffset:50];
//        [citySearchVC.view autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.tableView];
//        [citySearchVC.view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.tableView];
//        [citySearchVC.view autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.tableView];
        
        //4.2 使用2个方法进行布局
        //excluding: 除去上边, 我不管, 其他三条边都和父视图保持零间距
//        [citySearchVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        
        // 单独布局上边的约束: 当前控件的 view 上方, 和 tableView 的上方保持一致
//        [citySearchVC.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.tableView];
        
        //4.3 使用1个方法进行布局
        //[citySearchVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(44+ 30, 0, 0, 0)];

        
        [citySearchVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.left.equalTo(self.view.mas_top);
            
            //如果约束的边前后相等, 那么后面的可以不写
//            make.left.right.bottom.equalTo(self.view);
//            make.top.equalTo(self.tableView).offset(15);
            
            make.edges.equalTo(self.tableView);
        }];
        
        //5. 给属性赋值
        _citySearchVC = citySearchVC;
    }
    return _citySearchVC;
}

@end

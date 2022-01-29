//
//  HMHomeViewController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMHomeViewController.h"
#import "HMHomeNavView.h"
#import "HMCategoryViewController.h"
#import "HMDistrictViewController.h"
#import "HMCityModel.h"
#import "HMDistrictModel.h"
#import "HMCategoryModel.h"
#import "HMSortViewController.h"
#import "HMSortModel.h"
#import "HMDealCell.h"
#import "HMDealModel.h"
#import "HMDetailViewController.h"
#import "HMSearchViewController.h"
#import "HMNavigationController.h"
#import "HMMapViewController.h"
#import "HMCollectionViewController.h"

@interface HMHomeViewController ()<AwesomeMenuDelegate>

/** 通知发送的选中的城市名*/
@property (nonatomic, copy) NSString *selectCityName;
/** 通知发送的选中的分类名*/
@property (nonatomic, copy) NSString *selectCategoryName;
/** 通知发送的选中的区域名*/
@property (nonatomic, copy) NSString *selectDistrictName;
/** 通知发送的选中的排序*/
@property (nonatomic, strong) NSNumber *selectSortNumber;

/** 区域导航栏 View*/
@property (nonatomic, strong) HMHomeNavView *districtView;
/** 分类导航栏 View*/
@property (nonatomic, strong) HMHomeNavView *categorytView;
/** 排序导航栏 View*/
@property (nonatomic, strong) HMHomeNavView *sortView;



@end

@implementation HMHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置左边导航栏
    [self setupLeftNav];
    
    // 设置右边导航栏
    [self setupRightNav];
    
    // 添加菜单按钮
    [self addAwesomeMenu];
    
    //2. 一开始就刷新 : 进入刷新状态 --> 就会自动调用上方 block 绑定的方法
    [self.collectionView.mj_header beginRefreshing];

}

#pragma mark - 菜单按钮相关方法

#pragma mark 添加按钮
- (void)addAwesomeMenu
{
    //Pod 的旧版
//        AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectZero menus:@[item]];
//        [self.view addSubview:menu];
    
    //1. 中间的startItem
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc]
                                  initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"]
                                  highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"]
                                  ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"]
                                  highlightedContentImage:nil];
    
    //2. 添加其他几个按钮
    AwesomeMenuItem *item0 = [[AwesomeMenuItem alloc]
                              initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"]
                              highlightedImage:nil
                              ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"]
                              highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    
    AwesomeMenuItem *item1 = [[AwesomeMenuItem alloc]
                              initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"]
                              highlightedImage:nil
                              ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"]
                              highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    
    AwesomeMenuItem *item2 = [[AwesomeMenuItem alloc]
                              initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"]
                              highlightedImage:nil
                              ContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_normal"]
                              highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_highlighted"]];
    
    AwesomeMenuItem *item3 = [[AwesomeMenuItem alloc]
                              initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"]
                              highlightedImage:nil
                              ContentImage:[UIImage imageNamed:@"icon_pathMenu_more_normal"]
                              highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_more_highlighted"]];
    
    NSArray *items = @[item0, item1, item2, item3];
    
    //3. 创建菜单按钮
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:startItem menuItems:items];
    [self.view addSubview:menu];
    
    //4. 禁止中间按钮旋转
    menu.rotateAddButton = NO;
    
    //5. 弹出范围
    menu.menuWholeAngle = M_PI_2;
    
    //6. 设置按钮位置
    menu.startPoint = CGPointMake(50, -100);
//    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(self.view).offset(50);
////        make.bottom.equalTo(self.view).offset(-50);
//        make.left.bottom.equalTo(self.view);
//    }];
    [menu autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
    [menu autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
    
    //7. 设置代理
    menu.delegate = self;
    
    //8. 更改透明度
    menu.alpha = 0.5;
}

#pragma mark AwesomeMenu 代理方法
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    //1. 透明度
    menu.alpha = 0.5;
    
    //2. 更改图像
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    
    
    switch (idx) {
        case 0:
            NSLog(@"0");
            break;
            
        case 1:
            [self presentViewController:[[HMNavigationController alloc] initWithRootViewController:[HMCollectionViewController new]] animated:YES completion:nil];;
            break;
            
        case 2:
            NSLog(@"2");
            break;
            
        case 3:
            NSLog(@"3");
            break;
        default:
            break;
    }
}

- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu
{
    [UIView animateWithDuration:0.25 animations:^{
        //1. 透明度
        menu.alpha = 1;
        
        //2. 更改图像
        menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    }];
}

- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu
{
    //1. 透明度
    menu.alpha = 0.5;
    
    //2. 更改图像
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
}

//- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu
//{
//    //1. 透明度
//    menu.alpha = 1;
//    
//    //2. 更改图像
//    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
//}
//
//- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu
//{
//    //1. 透明度
//    menu.alpha = 0.5;
//    
//    //2. 更改图像
//    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
//}


#pragma mark - 通知相关的方法

#pragma mark 城市通知
- (void)cityDidChangeNotification:(NSNotification *)notification
{
    //1. 获取通知的值
    self.selectCityName = notification.userInfo[HMSelectCityName];
    
    // 清空其他三项数据
    self.selectCategoryName = nil;
    self.selectDistrictName = nil;
    self.selectSortNumber = nil;
    
    //2.1 获取导航栏 view, 直接更改标题
    [self.districtView setTitle:[NSString stringWithFormat:@"%@-全部", self.selectCityName]];
    
    //2.2 清空子标题
    [self.districtView setSubtitle:@""];
    
    // 发送请求获取数据 --> 会调用刷新绑定的方法 --> 会有动画下移
    [self.collectionView.mj_header beginRefreshing];
//    [self loadNewDeal];
}


#pragma mark 区域通知
- (void)districtDidChangeNotifacation:(NSNotification *)notification
{
    //1. 左边模型
    HMDistrictModel *selectDistrictModel = notification.userInfo[HMSelectDistrictModel];
    //2. 右边子标题
    NSString *selectDistrictSubtitle = notification.userInfo[HMSelectDistrictSubtitle];
    
    /**
     1. 发送右边 右边有值, 且不等于"全部"
     2. 发送左边 没有子分类数据, 就发送左边 , 且不等于"全部"
     3. 不发送 没有需求进行筛选或者 点击了"全部"
     */
    
    // 获取选中的分类 --> 为了发送请求
    // 大众点评接口, 不支持左边的模型的数据 --> 暂时无法测试
    if (selectDistrictModel.subdistricts.count == 0 || [selectDistrictSubtitle isEqualToString:@"全部"]) {
        self.selectDistrictName = selectDistrictModel.name;
    } else {
        self.selectDistrictName = selectDistrictSubtitle;
    }
    
    if ([self.selectDistrictName isEqualToString:@"全部"]) {
        self.selectDistrictName = nil;
    }
    
    //3.1 获取导航栏 view, 直接更改标题
    [self.districtView setTitle:[NSString stringWithFormat:@"%@-%@", self.selectCityName, selectDistrictModel.name]];
    
    //3.2 清空子标题
    [self.districtView setSubtitle:selectDistrictSubtitle];
    
    //4. 取消 popover 的显示
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 发送请求获取数据
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark 分类通知
- (void)categoryDidChangeNotifacation:(NSNotification *)notification
{
    //1. 左边模型
    HMCategoryModel *selectCategoryModel = notification.userInfo[HMSelectCategoryModel];
    //2. 右边子标题
    NSString *selectCategorySubtitle = notification.userInfo[HMSelectCategorySubtitle];
    
    /**
     1. 发送右边 右边有值, 且不等于"全部"
     2. 发送左边 没有子分类数据, 就发送左边 , 且不等于"全部分类"
     3. 不发送 没有需求进行筛选或者 点击了"全部分类"
     */
    
    // 获取选中的分类 --> 为了发送请求
    if (selectCategorySubtitle == nil || [selectCategorySubtitle isEqualToString:@"全部"]) {
        // 发送左边的名字
        self.selectCategoryName = selectCategoryModel.name;
    } else {
        self.selectCategoryName = selectCategorySubtitle;
    }
    
    if ([self.selectCategoryName isEqualToString:@"全部分类"]) {
        self.selectCategoryName = nil;
    }
    
    
    //3.1 获取导航栏 view, 直接更改标题
    [self.categorytView setTitle:selectCategoryModel.name];
    
    //3.2 清空子标题
    [self.categorytView setSubtitle:selectCategorySubtitle];
    
    //3.3 设置图标
    [self.categorytView setIcon:selectCategoryModel.icon hightIcon:selectCategoryModel.highlighted_icon];
    
    //4. 取消 popover 的显示
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 发送请求获取数据
    [self.collectionView.mj_header beginRefreshing];
}


#pragma mark 排序通知
- (void)sortDidChangeNotifacation:(NSNotification *)notification
{
    //1. 获取模型
    HMSortModel *selectSortModel = notification.userInfo[HMSelectSortModel];
    
    self.selectSortNumber = selectSortModel.value;
    
    //2 设置子标题
    [self.sortView setSubtitle:selectSortModel.label];
    
    //3. 取消 popover 的显示
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 发送请求获取数据
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark 添加观察者
- (void)viewWillAppear:(BOOL)animated
{
    // 视图将要出现的时候, 注册通知
    [super viewWillAppear:animated];
    // 注册城市选择通知
    [HMNotificationCenter addObserver:self selector:@selector(cityDidChangeNotification:) name:HMCityDidChangeNotifacation object:nil];
    
    // 注册区域选择通知
    [HMNotificationCenter addObserver:self selector:@selector(districtDidChangeNotifacation:) name: HMDistrictDidChangeNotifacation object:nil];
    
    // 注册分类选择通知
    [HMNotificationCenter addObserver:self selector:@selector(categoryDidChangeNotifacation:) name:  HMCategoryDidChangeNotifacation object:nil];
    
    // 注册排序选中的通知
    [HMNotificationCenter addObserver:self selector:@selector( sortDidChangeNotifacation:) name:HMSortDidChangeNotifacation object:nil];
}

#pragma mark 移除观察者
- (void)viewWillDisappear:(BOOL)animated
{
    // 当视图消失(看不见)的时候移除通知
    [super viewWillDisappear:animated];
    [HMNotificationCenter removeObserver:self];
}
//- (void)dealloc
//{
//    [HMNotificationCenter removeObserver:self];
//}



#pragma mark - 导航栏相关的方法
#pragma mark 设置左边导航栏
- (void)setupLeftNav {
    
    //1. Logo
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_meituan_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //enabled: 可用
    logoItem.enabled = NO;
    
    //2. 分类
    HMHomeNavView *categoryView = [HMHomeNavView homeNavView];
    // 添加点击方法
    [categoryView addTarget:self action:@selector(categorClick)];
    
    [categoryView setTitle:@"全部分类"];
    [categoryView setSubtitle:@""];
    [categoryView setIcon:@"icon_category_-1" hightIcon:@"icon_category_highlighted_-1"];
    
    self.categorytView = categoryView;
    
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryView];
    
    //3. 区域
    HMHomeNavView *districtView = [HMHomeNavView homeNavView];
    [districtView addTarget:self action:@selector(distrctClick)];
    
    [districtView setTitle:@"北京-全部"];
    [districtView setSubtitle:@""];
    
    // 属性赋值
    self.districtView = districtView;
    
    
    UIBarButtonItem *districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtView];
    
    //4. 排序
    HMHomeNavView *sortView = [HMHomeNavView homeNavView];
    [sortView addTarget:self action:@selector(sortClick)];
    
    [sortView setTitle:@"排序"];
    [sortView setSubtitle:@"默认排序"];
    
    self.sortView = sortView;

    
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortView];
    
    self.navigationItem.leftBarButtonItems = @[logoItem, categoryItem, districtItem, sortItem];
}

#pragma mark 分类按钮点击
- (void)categorClick
{
    //1. 内容控制器
    HMCategoryViewController *categoryVC = [HMCategoryViewController new];
    
    //2. 设置 popover 相关的属性
    categoryVC.modalPresentationStyle = UIModalPresentationPopover;
    
    categoryVC.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[1];
    
    //3. 使用普通的模态视图弹出即可
    [self presentViewController:categoryVC animated:YES completion:nil];
}


#pragma mark 区域按钮点击
- (void)distrctClick
{
    //1. 内容控制器
    HMDistrictViewController *districtVC = [HMDistrictViewController new];
    
    //需要 cities.plist中获取,根据选中的城市名进行查找, 找到了, 就返回子区域数据, 进行设置
    
    //1.1 如果选中的城市名有值
    if (self.selectCityName) {
        
        //1.2 加载 plist 并转模型
        NSMutableArray *cityArray = [NSMutableArray array];
        
        NSArray *cityPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil]];
        
        for (NSDictionary *dict in cityPlist) {
           [cityArray addObject:[HMCityModel yy_modelWithJSON:dict]];
        }
        
        //1.3 遍历模型数据
        for (HMCityModel *cityModel in cityArray) {
            
            //1.4 判断模型的 name 属性是否跟选中的城市名相等
            if ([cityModel.name isEqualToString:self.selectCityName]) {
                
                //1.5 如果相等, 那么将模型的子区域数据, 赋值给区域控制器的属性
                districtVC.districtArray = cityModel.districts;
            }
        }
        
    }

    
    
    //2. 设置 popover 相关的属性
    districtVC.modalPresentationStyle = UIModalPresentationPopover;
    
    districtVC.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[2];
    
    //3. 使用普通的模态视图弹出即可
    [self presentViewController:districtVC animated:YES completion:nil];
}

#pragma mark 排序按钮点击
- (void)sortClick
{
    //1. 内容控制器
    HMSortViewController *sortVC = [HMSortViewController new];
    
    //2. 设置 popover 相关的属性
    sortVC.modalPresentationStyle = UIModalPresentationPopover;
    
    sortVC.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[3];
    
    //3. 使用普通的模态视图弹出即可
    [self presentViewController:sortVC animated:YES completion:nil];
}

#pragma mark 设置右边导航栏
- (void)setupRightNav {

    //1. 搜索
    UIBarButtonItem *searchItem = [UIBarButtonItem barBuutonItemWithTarget:self action:@selector(searchClick) icon:@"icon_search" highlighticon:@"icon_search_highlighted"];
    
    //UIBarButtonItem --> customView --> UIButton
    searchItem.customView.width = 60;
    
    //2. 地图
    UIBarButtonItem *mapItem = [UIBarButtonItem barBuutonItemWithTarget:self action:@selector(mapClick) icon:@"icon_map" highlighticon:@"icon_map_highlighted"];
    
    mapItem.customView.width = 60;
    
    self.navigationItem.rightBarButtonItems = @[mapItem, searchItem];
}

#pragma mark 搜索按钮点击方法
- (void)searchClick
{
    HMSearchViewController *searchVC = [HMSearchViewController new];
    
    if (self.selectCityName) {
        searchVC.selectCity = self.selectCityName;
    } else {
        searchVC.selectCity = @"北京";
    }
    
    
    HMNavigationController *nav = [[HMNavigationController alloc]  initWithRootViewController:searchVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark 地图按钮点击方法
- (void)mapClick
{
    HMMapViewController *mapVC = [HMMapViewController new];
    HMNavigationController *nav = [[HMNavigationController alloc] initWithRootViewController:mapVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark 设置参数
- (void)setParams:(NSMutableDictionary *)params
{
//    [super setParams:params];
    
    //2.1 城市  --> 正常的程序, 应该首次启动定位来获取城市 --> 咱们这里没有做
    //    static int i = 0;
    //    i++;
    //    if (i == 3) {
    //        params[@"city"] = nil;
    //    } else {
    params[@"city"] = self.selectCityName != nil ? self.selectCityName : @"北京";
    //    }
    
    
    //2.2 分类 --> 如果参数为 nil, 不影响请求的结果
    if (self.selectCategoryName) {
        params[@"category"] = self.selectCategoryName;
    }
    
    //2.3 区域
    if (self.selectDistrictName) {
        params[@"region"] = self.selectDistrictName;
    }
    
    //2.4 排序
    if (self.selectSortNumber) {
        params[@"sort"] = self.selectSortNumber;
    }

}

@end

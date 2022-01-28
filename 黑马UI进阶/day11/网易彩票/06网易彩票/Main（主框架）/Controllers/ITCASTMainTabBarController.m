//
//  ITCASTMainTabBarController.m
//  06网易彩票
//
//  Created by teacher on 15/7/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTMainTabBarController.h"
#import "ITCASTBottomBarView.h"

@interface ITCASTMainTabBarController () <ITCASTBottomBarViewDelegate>

@end

@implementation ITCASTMainTabBarController


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载5个storyboard文件中的"初始化"控制器（导航控制器）
    
    // 加载子控制器
    [self loadSubControllers];
    
    
    // 加载底部的自定义BottomBarView
    [self loadBottomBarView];

}

// 加载子控制器到tab bar controller中
- (void)loadSubControllers
{
    // 1. 加载购彩大厅
    UINavigationController *navHall = [self navigationControllerWithStoryboardName:@"Hall"];
    // 2. 竞技场
    UINavigationController *navArena = [self navigationControllerWithStoryboardName:@"Arena"];
    // 3. 发现
    UINavigationController *navDiscovery = [self navigationControllerWithStoryboardName:@"Discovery"];
    
    // 4. 开奖信息
    UINavigationController *navHistory = [self navigationControllerWithStoryboardName:@"History"];
    // 5. 我的彩票
    UINavigationController *navMyLottery = [self navigationControllerWithStoryboardName:@"MyLottery"];
    
    self.viewControllers = @[navHall, navArena, navDiscovery, navHistory, navMyLottery];
}

// 加载底部的自定义TabBar
- (void)loadBottomBarView
{
//    // 1. 创建底部的bottom view
//    ITCASTBottomBarView *bottomView = [[ITCASTBottomBarView alloc] init];
//    bottomView.frame = self.tabBar.frame;
//    [self.tabBar removeFromSuperview];
//    [self.view addSubview:bottomView];
    
    
    // 1. 创建底部的bottom view
    ITCASTBottomBarView *bottomView = [[ITCASTBottomBarView alloc] init];
    bottomView.frame = self.tabBar.bounds;
    [self.tabBar addSubview:bottomView];
    
    
    
    // 2. 创建bottom view中的每个按钮
    for (int i = 0; i < self.viewControllers.count; ++i) {
        NSString *normal = [NSString stringWithFormat:@"TabBar%d", (i + 1)];
        NSString *selected = [NSString stringWithFormat:@"TabBar%dSel", (i + 1)];
        [bottomView addBottomBarButtonWithNormalBg:normal selectedBg:selected];
    }
    
    // 3. 设置代理
    bottomView.delegate = self;
}


- (void)bottomBarView:(ITCASTBottomBarView *)bottomBarView didClickBottomBarButtonWithIndex:(int)idx
{
    self.selectedIndex = idx;
}

// 封装一个根据storyboard名称, 加载对应的初始化控制器的方法
- (UINavigationController *)navigationControllerWithStoryboardName:(NSString *)storyboard
{
    // 1. 创建stroyboard对象
    UIStoryboard *s1 = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    // 2. 实例化这个storyboard中的初始化控制器
    UINavigationController *navController = [s1 instantiateInitialViewController];
    return navController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

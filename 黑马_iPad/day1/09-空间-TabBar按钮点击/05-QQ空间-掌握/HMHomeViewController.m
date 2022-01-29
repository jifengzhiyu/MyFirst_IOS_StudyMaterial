//
//  HMHomeViewController.m
//  05-QQ空间-掌握
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HMHomeViewController.h"
#import "HMDockView.h"

@interface HMHomeViewController ()

// 左边的dock栏
@property (nonatomic, weak) HMDockView *dockView;

/** 正在显示的子控制器*/
@property (nonatomic, strong) UIViewController *selectChildVC;

@end

@implementation HMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建控制器
    [self setupChildViewController];
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidChangeNotification:) name:@"HMTabBarButtonDidChangeNotification" object:nil];
    
    // 创建dockView
    HMDockView *dockView = [HMDockView new];
    [self.view addSubview:dockView];
    self.dockView = dockView;
    
    // 手动调用切换控制器的方法
    [self changeChildVC:0];
    

    //保证首次加载屏幕正确
    //iOS8之后的方法
    [self viewWillTransitionToSize:[UIScreen mainScreen].bounds.size withTransitionCoordinator:self.transitionCoordinator];
    
    //iOS8之前的方法
    //[self willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
    
}

// 创建6个控制器
- (void)setupChildViewController
{
    for (int i = 0; i < 6; i++) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1];
        [self addChildViewController:vc];
    }
}


#pragma mark - 通知
- (void)tabBarButtonDidChangeNotification:(NSNotification *)notification
{
    //1. 获取索引
    //userInfo: 字典
    NSInteger index = [notification.userInfo[@"HMTabBarSelectIndex"] integerValue];
    
    //2. 切换控制器
    [self changeChildVC:index];
}

#pragma mark 切换控制器
- (void)changeChildVC:(NSInteger)index
{
    //1. 移除之前的选中的控制器的 view --> 不需要重复添加
    [self.selectChildVC.view removeFromSuperview];
    
    //2. 获取控制器的 view
    UIViewController *newVC = self.childViewControllers[index];
    
    //3. 添加当前控制器的 View
    [self.view addSubview:newVC.view];
    
    //4. 让当前显示的控制器赋值给 选中的控制器的属性 --> 只有知道了选中了谁, 才能在将来准确的删除对应的 view
    self.selectChildVC = newVC;
    
    //5. 布局控制器的 view
    [newVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.view);
        make.left.equalTo(self.dockView.mas_right);
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 屏幕旋转方法
// 下面2个屏幕旋转方法, 如果新的方法实现了, 旧的方法会被覆盖(不会执行)

// iOS8之后的屏幕旋转方法
// 当view的大小发生改变才调用 --> 大小改变就是屏幕旋转
//Size: 将要转动到的方向的大小
//coordinator: 协调器 --> 肯定有转动的时间
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // 横屏
    if (size.width > size.height) {
        // 更改dockView的宽度和高度
        self.dockView.width = 210;
        self.dockView.height = size.height;
    } else {
        // 更改dockView的宽度和高度
        self.dockView.width = 70;
        self.dockView.height = size.height;
    }
}


// iOS8之前的屏幕旋转方法
//toInterfaceOrientation: 将要转动到的方向
//duration: 转动的时间
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //Landscape: 横屏
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        // 更改dockView的宽度和高度
        self.dockView.width = 200;
        self.dockView.height = 768;
        
    } else if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        //Portrait: 竖屏
        
        // 更改dockView的宽度和高度
        self.dockView.width = 50;
        self.dockView.height = 1024;

    }
}

@end

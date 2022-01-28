//
//  ITCASTNavBaseController.m
//  06网易彩票
//
//  Created by teacher on 15/7/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTNavBaseController.h"

@interface ITCASTNavBaseController ()

@end

@implementation ITCASTNavBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


//+ (void)initialize，是在当前类第一次使用之前会执行一次。
// 但是我们这里有5个类继承子类这个"导航控制器"的父类，也就是说每个子类都有一个+ (void)initialize方法（即：每个子类第一次使用之前都会执行一次这个方法，所以这个方法会执行5次。）
//+ (void)initialize
//{
//    // appearance方法返回当前控件的外观代理对象
//    // 我们只要修改了某个控件的外观代理对象的"外观", 那么在当前app中的所有的这类型控件的外观就都跟着改了。
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    // 设置导航栏的背景图片
//    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
//    // 统一设置导航栏中标题文字的颜色
//    NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
//    [navBar setTitleTextAttributes:attrs];
//    // 修改导航栏中其他按钮的文字颜色
//    [navBar setTintColor:[UIColor whiteColor]];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 在每一个被push的控制器, 即将push之前, 设置hidesBottomBarWhenPushed = YES， 表示这个控制器在被push的时候会隐藏底部的tab bar。
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end

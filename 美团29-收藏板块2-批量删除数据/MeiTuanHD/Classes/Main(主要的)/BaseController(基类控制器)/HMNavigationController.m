//
//  HMNavigationController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMNavigationController.h"

@interface HMNavigationController ()

@end

@implementation HMNavigationController



#pragma mark 只要文件参与了编译就会调用
+ (void)load
{
    //NSLog(@"aaa");
}

/**
 导航栏背景的设置, 不需要改变
 一开始的时候就设置好, 只需要设置一次
 */
#pragma mark 当使用的时候才会调用
+ (void)initialize
{
    //1. 获取导航栏
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //2. 设置背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
    
    //3. 获取 UIBarButtonItem
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    
    //4. 设置文字颜色
    [barButtonItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : HMColorGreen} forState:UIControlStateNormal];
    
    [barButtonItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateDisabled];
}

@end

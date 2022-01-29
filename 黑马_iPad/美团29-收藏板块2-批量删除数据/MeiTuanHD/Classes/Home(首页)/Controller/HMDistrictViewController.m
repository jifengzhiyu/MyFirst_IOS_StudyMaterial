//
//  HMDistrictViewController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMDistrictViewController.h"
#import "HMDropdownView.h"
#import "HMCityViewController.h"
#import "HMNavigationController.h"

@interface HMDistrictViewController ()

@end

@implementation HMDistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 创建下拉菜单
    HMDropdownView *dropdownView = [HMDropdownView dropDownView];
    
    //2. 添加
    [self.view addSubview:dropdownView];
    
    
    //3. 设置下拉菜单的 Y 值
    UIView *navView = self.view.subviews[0];
    dropdownView.y = navView.height;
    
    //4. 设置大小 --> 如果自定义了, 导航栏还有44/64高度
    self.preferredContentSize = CGSizeMake(dropdownView.size.width, dropdownView.size.height + 44);
    
    //5. 下拉菜单, 需要知道对应城市的区域信息
    dropdownView.districtArray = self.districtArray;
    
}

#pragma mark 切换城市按钮方法
- (IBAction)changeCityClick {
    
    /**
     如果父子控制器的层级关系存在, 父控制器消失, 子控制器肯定也会消失
     */
    
    //1. 消失之前的控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    HMCityViewController *cityVC = [HMCityViewController new];
    
    HMNavigationController *nav = [[HMNavigationController alloc] initWithRootViewController:cityVC];
    
    //呈现样式
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    //转场样式(切换动画)
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //2. 使用根控制器去弹出模态视图
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    
    //现在应该使用下面的
    //https://blog.csdn.net/yst19910702/article/details/108880067
//    UIWindow *window =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    window.rootViewController presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>
    
    /**
     如果将来要实现 QQ 右上角点击, 覆盖全屏的效果, 此时就需要使用主窗口去添加控件
     */
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor redColor];
//    view.frame = [UIScreen mainScreen].bounds;
//    [[UIApplication sharedApplication].keyWindow addSubview:view];

}


@end

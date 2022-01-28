//
//  ITCASTLoginController.m
//  06网易彩票
//
//  Created by teacher on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTLoginController.h"
#import "ITCASTSettingsController.h"
#import "ITCASTHelpListController.h"

@interface ITCASTLoginController ()
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation ITCASTLoginController


// 点击进入"设置界面"
- (IBAction)btnSettingClick:(id)sender {
    
    // 1.1 创建"设置"控制器
    ITCASTSettingsController *settingVc = [[ITCASTSettingsController alloc] init];
    // 1.2 设置控制器的导航栏效果
    settingVc.navigationItem.title = @"设置";
    // 设置要加载的plist文件名
    settingVc.plistName = @"ITCASTSettings.plist";
    
    // 1.3 在右侧添加一个常见问题按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"常见问题" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpList)];
    settingVc.navigationItem.rightBarButtonItem = item;
    
    // 2. 把设置控制器push到导航控制器中
    [self.navigationController pushViewController:settingVc animated:YES];
}

// 点击常见问题列表
- (void)btnHelpList
{
    // 跳转到问题列表控制器
    ITCASTHelpListController *helpList = [[ITCASTHelpListController alloc] init];
    
    [self.navigationController pushViewController:helpList animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置登录按钮的背景图片
    UIImage *imgNormal = [UIImage imageNamed:@"RedButton"];
    UIImage *imgHighlighted = [UIImage imageNamed:@"RedButtonPressed"];
    
    // 对图片做拉伸
    imgNormal = [imgNormal stretchableImageWithLeftCapWidth:imgNormal.size.width * 0.5 topCapHeight:imgNormal.size.height * 0.5];
    imgHighlighted = [imgHighlighted stretchableImageWithLeftCapWidth:imgHighlighted.size.width * 0.5 topCapHeight:imgHighlighted.size.height * 0.5];
    
    
    [self.btnLogin setBackgroundImage:imgNormal forState:UIControlStateNormal];
    [self.btnLogin setBackgroundImage:imgHighlighted forState:UIControlStateHighlighted];
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

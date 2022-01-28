//
//  JFBlueViewController.m
//  导航控制器的基本使用
//
//  Created by 翟佳阳 on 2021/9/29.
//

#import "JFBlueViewController.h"

@interface JFBlueViewController ()
- (IBAction)backtoBreenVc:(id)sender;
- (IBAction)backtoRootVc:(id)sender;
- (IBAction)toOrderdVc:(id)sender;

@end

@implementation JFBlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)toOrderdVc:(id)sender {
    //导航控制器栈里面的所有控制器
    //返回到制定的控制器需要找出还在导航控制器栈里的控制器
    NSArray *vcs = self.navigationController.viewControllers;
    UIViewController *vc = vcs[1];
    [self.navigationController popToViewController:vc animated:YES];
}

- (IBAction)backtoRootVc:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)backtoBreenVc:(id)sender {
    //返回上一个viewController
    [self.navigationController popViewControllerAnimated:YES];
}
@end

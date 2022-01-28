//
//  JFRedViewController.m
//  导航控制器的基本使用
//
//  Created by 翟佳阳 on 2021/9/29.
//

#import "JFRedViewController.h"
#import "JFGreenViewController.h"
@interface JFRedViewController ()
- (IBAction)gotoCreenVc:(id)sender;

@end

@implementation JFRedViewController

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

- (IBAction)gotoCreenVc:(id)sender {
    //1、创建绿色控制器
    JFGreenViewController *greenVc = [[JFGreenViewController alloc]init];
    //2、跳转    self.navigationController 拿到当前控制器的导航控制器
    [self.navigationController pushViewController:greenVc animated:YES];

    
}


@end

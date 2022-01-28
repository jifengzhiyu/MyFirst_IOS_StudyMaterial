//
//  JFGreenViewController.m
//  导航控制器的基本使用
//
//  Created by 翟佳阳 on 2021/9/29.
//

#import "JFGreenViewController.h"
#import "JFBlueViewController.h"
@interface JFGreenViewController ()
- (IBAction)gotoBlueVc:(id)sender;

@end

@implementation JFGreenViewController

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

- (IBAction)gotoBlueVc:(id)sender {
    JFBlueViewController *blueVc = [[JFBlueViewController alloc]init];
    [self.navigationController pushViewController:blueVc animated:YES];
}
@end

//
//  JFBlueViewController.m
//  通过storyboard使用导航控制器
//
//  Created by 翟佳阳 on 2021/9/29.
//

#import "JFBlueViewController.h"

@interface JFBlueViewController ()
- (IBAction)backtoQuestCv:(id)sender;

@end

@implementation JFBlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backtoQuestCv:(id)sender {
    
    NSArray *vcs = self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:vcs[1] animated:YES];
}
@end

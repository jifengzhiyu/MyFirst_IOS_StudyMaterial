//
//  JFGreenViewController.m
//  通过storyboard使用导航控制器
//
//  Created by 翟佳阳 on 2021/9/29.
//

#import "JFGreenViewController.h"

@interface JFGreenViewController ()
- (IBAction)backtoRed:(id)sender;

@end

@implementation JFGreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //如果当前控制器不是导航控制器的控制器，如果左侧放置了按钮
    //那么系统就不会自动生成返回按钮
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(bookClick)];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)bookClick{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backtoRed:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end

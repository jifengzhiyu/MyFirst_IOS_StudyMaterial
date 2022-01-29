//
//  HMthreeViewController.m
//  02navigation&tab使用注意
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMthreeViewController.h"

@interface HMthreeViewController ()

@end

@implementation HMthreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)toOneViewController:(id)sender {
    //下面注意语句的顺序
    //如果pop了,tabBar就会消失，并保存到缓存中
    //所以要趁着它还没消失就    self.tabBarController.selectedIndex = 0;
 
    self.tabBarController.selectedIndex = 0;

    [self.navigationController popViewControllerAnimated:YES];
    
}



@end

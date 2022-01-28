//
//  ITCASTNavArenaController.m
//  06网易彩票
//
//  Created by teacher on 15/7/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTNavArenaController.h"

@interface ITCASTNavArenaController ()

@end

@implementation ITCASTNavArenaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 修改竞技场的导航栏
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NLArenaNavBar64"] forBarMetrics:UIBarMetricsDefault];
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

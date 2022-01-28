//
//  ITCASTAboutController.m
//  06网易彩票
//
//  Created by teacher on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTAboutController.h"
#import "ITCASTAboutHeaderView.h"
@interface ITCASTAboutController ()

@end

@implementation ITCASTAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 动态加载ITCASTAboutHeaderView.xib
    ITCASTAboutHeaderView *headerVw = [ITCASTAboutHeaderView aboutHeaderView];
    self.tableView.tableHeaderView = headerVw;
    
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

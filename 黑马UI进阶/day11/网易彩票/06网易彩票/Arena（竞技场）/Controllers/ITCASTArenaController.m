//
//  ITCASTArenaController.m
//  06网易彩票
//
//  Created by teacher on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTArenaController.h"

@interface ITCASTArenaController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgTitle;

@end

@implementation ITCASTArenaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置控制器view的背景图片
    self.view.layer.contents = (__bridge id)([UIImage imageNamed:@"NLArenaBackground"].CGImage);
    
    // 设置SegmentedControl的背景图片
    // 1. 默认情况下
    [self.sgTitle setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // 2. 选中情况下
    [self.sgTitle setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    // 设置SegmentedControl的文字样式
    // 1. 默认情况下
    NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.sgTitle setTitleTextAttributes:attrs forState:UIControlStateNormal];
    // 2. 选中情况下
    [self.sgTitle setTitleTextAttributes:attrs forState:UIControlStateSelected];
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

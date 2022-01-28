//
//  ITCASTLuckyController.m
//  06网易彩票
//
//  Created by teacher on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTLuckyController.h"

@interface ITCASTLuckyController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewLights;

@end

@implementation ITCASTLuckyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 不行！！！！！！！
    //self.view.layer.contents = (__bridge id)([UIImage imageNamed:@"luck_entry_background"].CGImage);
    
    // 设置"彩灯"动画
    self.imgViewLights.animationImages = @[
                                           [UIImage imageNamed:@"lucky_entry_light0"],
                                           [UIImage imageNamed:@"lucky_entry_light1"]
                                           ];
    
    self.imgViewLights.animationDuration = 0.7;
    self.imgViewLights.animationRepeatCount = 0;
    // 启动动画
    [self.imgViewLights startAnimating];
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

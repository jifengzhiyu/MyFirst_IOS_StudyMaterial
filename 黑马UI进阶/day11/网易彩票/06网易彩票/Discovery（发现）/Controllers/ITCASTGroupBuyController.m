//
//  ITCASTGroupBuyController.m
//  06网易彩票
//
//  Created by teacher on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTGroupBuyController.h"
#import "UIView+ITCASTExt.h"

@interface ITCASTGroupBuyController ()
@property (nonatomic, strong) UIView *blueView;
@end

@implementation ITCASTGroupBuyController

- (UIView *)blueView
{
    if (_blueView == nil) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor blueColor];
        CGFloat x = 0;
        CGFloat y = 64;
        CGFloat w = self.view.bounds.size.width;
        CGFloat h = 0;
        _blueView.frame = CGRectMake(x, y, w, h);
        [self.view addSubview:_blueView];
    }
    return _blueView;
}

// “全部彩种”按钮的单击事件
- (IBAction)buttonTitleClick:(UIButton *)sender {
    
    [self blueView];
    
    [UIView animateWithDuration:0.3 animations:^{
        // 按钮中的"黄色三角图片"实现旋转
        sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI);
        // 设置蓝色view显示 或 隐藏
        if (self.blueView.h == 0) {
            self.blueView.h = 200;
        } else {
            self.blueView.h = 0;
        }
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

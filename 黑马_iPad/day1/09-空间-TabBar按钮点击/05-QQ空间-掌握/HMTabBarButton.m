//
//  HMTabBarButton.m
//  05-QQ空间-掌握
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HMTabBarButton.h"

@implementation HMTabBarButton

/**
 1. 将 TabBar 按钮的公用设置, 放在此方法中
 2. 调整 image 和 title 的位置
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //UIControlStateSelected:按钮依旧能够接收用户的点击事件
        //UIControlStateDisabled:按钮不能接收用户的点击事件 --> 可以省去判断
        
        // 设置背景
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateDisabled];
        
        // 图像被拉伸了
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 设置失效状态不要调整图像
        self.adjustsImageWhenDisabled = NO;
        
        // 设置高亮状态不要调整图像
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
#pragma mark 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // self --> TabBar的一个按钮
    if (HMLandscape) {
        self.imageView.width = self.width * 0.4;
        self.imageView.height = self.height;
        self.imageView.x = 0;
        self.imageView.y = 0;
        
        self.titleLabel.hidden = NO;
        self.titleLabel.width = self.width - self.imageView.width;
        self.titleLabel.height = self.height;
        self.titleLabel.x = self.imageView.width;
        self.titleLabel.y = 0;
    } else {
        self.imageView.width = self.width;
        self.imageView.height = self.height;
        self.imageView.x = 0;
        self.imageView.y = 0;
        
        self.titleLabel.hidden = YES;
    }
    
}

@end

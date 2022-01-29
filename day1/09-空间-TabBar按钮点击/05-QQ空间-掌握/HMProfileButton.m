//
//  HMProfileButton.m
//  05-QQ空间-掌握
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HMProfileButton.h"

@implementation HMProfileButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置初始值
        [self setTitle:@"东鹏特饮" forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"profile"] forState:UIControlStateNormal];
        
        // 设置圆角效果
        self.imageView.layer.cornerRadius = 10;
        
        // 文字居中显示
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

#pragma mark 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // self --> 头像
    
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    self.imageView.x = 0;
    self.imageView.y = 0;
    
    if (HMLandscape) {
        self.titleLabel.hidden = NO;
        
        self.titleLabel.width = self.width;
        self.titleLabel.height = self.height - self.width;
        self.titleLabel.x = 0;
        self.titleLabel.y = self.imageView.height;
    } else {
        self.titleLabel.hidden = YES;
    }
}

@end

//
//  HMToolBarView.m
//  05-QQ空间-掌握
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HMToolBarView.h"

@implementation HMToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 创建三个按钮
        [self setupButtonWithIcon:@"tabbar_blog"];
        [self setupButtonWithIcon:@"tabbar_mood"];
        [self setupButtonWithIcon:@"tabbar_photo"];
    }
    return self;
}
#pragma mark 自定义按钮
- (void)setupButtonWithIcon:(NSString *)icon
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateHighlighted];
    [self addSubview:button];
}

#pragma mark 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1. 获取子视图个数
    NSInteger count = self.subviews.count;
    
    //2. 遍历子视图
    for (int i = 0; i < count; ++i) {
        
        //3. 获取按钮
        UIButton *button = self.subviews[i];
        
        //4. 设置位置
        if (HMLandscape) {
            button.width = self.width / count;
            button.height = button.width;
            button.x = i * button.width;
            button.y = 0;
        } else {
            button.width = self.width;
            button.height = button.width;
            button.x = 0;
            button.y = i * button.height;
        }
        
        
        
    }
}

@end

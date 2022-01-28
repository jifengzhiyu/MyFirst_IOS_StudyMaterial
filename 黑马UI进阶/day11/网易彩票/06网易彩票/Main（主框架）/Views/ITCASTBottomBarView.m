//
//  ITCASTBottomBarView.m
//  06网易彩票
//
//  Created by teacher on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTBottomBarView.h"
#import "ITCASTBottomBarButton.h"
@interface ITCASTBottomBarView ()
@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation ITCASTBottomBarView

- (void)addBottomBarButtonWithNormalBg:(NSString *)normal selectedBg:(NSString *)selected
{
    // 1. 创建一个UIButton
    ITCASTBottomBarButton *button = [[ITCASTBottomBarButton alloc] init];
    
    // 2. 设置UIButton的背景图片
    UIImage *imgNormal = [UIImage imageNamed:normal];
    UIImage *imgSelected = [UIImage imageNamed:selected];
    [button setBackgroundImage:imgNormal forState:UIControlStateNormal];
    [button setBackgroundImage:imgSelected forState:UIControlStateSelected];
    
    // 3. 把UIButton添加到自己上（self）
    [self addSubview:button];
    
    
    
    // 4. 为每个按钮注册一个touch down事件
    [button addTarget:self action:@selector(bottomBarButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
}


// 底部的bottom bar button的单机事件
- (void)bottomBarButtonTouchDown:(UIButton *)sender
{
    // 1. 设置被点击的按钮的状态
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    
    
    // 2. 切换主控制器（TabBarController）中当前显示的子控制器
    if ([self.delegate respondsToSelector:@selector(bottomBarView:didClickBottomBarButtonWithIndex:)]) {
        [self.delegate bottomBarView:self didClickBottomBarButtonWithIndex:(int)sender.tag];
    }
    
}
// 当控件第一次显示的时候一定会调用一次
// 当控件再次显示的时候（刷新重绘等操作）， 只要控件的frame发生了改变那么也会调用这个方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat y = 0;
    CGFloat h = self.bounds.size.height;
    CGFloat w = self.bounds.size.width / self.subviews.count;
    
    // 计算x并且赋值
    for (int i = 0; i < self.subviews.count; ++i) {
        CGFloat x = i * w;
        UIButton *button = (UIButton *)self.subviews[i];
        button.tag = i;
        button.frame = CGRectMake(x, y, w, h);
        
        // 设置第一个按钮默认被选中
        if (i == 0) {
            self.selectedButton.selected = NO;
            button.selected = YES;
            self.selectedButton = button;
        }
    }
    
}

@end

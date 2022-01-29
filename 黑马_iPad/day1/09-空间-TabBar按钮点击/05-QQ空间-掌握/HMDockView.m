//
//  HMDockView.m
//  05-QQ空间-掌握
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HMDockView.h"
#import "HMToolBarView.h"
#import "HMTabBarView.h"
#import "HMProfileButton.h"

@interface HMDockView ()
// 头像
@property (nonatomic, weak) HMProfileButton *profileButton;
// 标签栏
@property (nonatomic, weak) HMTabBarView *tabBarView;
// 工具栏
@property (nonatomic, weak) HMToolBarView *toolBarView;
@end

@implementation HMDockView

// 小技巧 : init相关的初始化代码时, 可以不敲 '-', 直接敲方法名
//加入子控件
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(55) / 255.0) green:((float)arc4random_uniform(55) / 255.0) blue:((float)arc4random_uniform(55) / 255.0) alpha:1.0];
        
        
        //1. 头像
        HMProfileButton *profileButton = [HMProfileButton new];
        [self addSubview:profileButton];
        self.profileButton = profileButton;
        
        //2. 标签栏
        HMTabBarView *tabBarView = [HMTabBarView new];
        [self addSubview:tabBarView];
        self.tabBarView = tabBarView;
        
        //3. 工具栏
        HMToolBarView *toolBarView = [HMToolBarView new];
        [self addSubview:toolBarView];
        self.toolBarView = toolBarView;
    }
    return self;
}

// 子视图方向需要实现此方法进行判断
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //self --> dockView
    
    //1.工具栏
    self.toolBarView.width = self.width;
    self.toolBarView.x = 0;
    
    // 横屏
    if (HMLandscape) {
        self.toolBarView.height = self.width / 3;
    } else{
        self.toolBarView.height = self.width * 3;
    }
    
    self.toolBarView.y = self.height - self.toolBarView.height;
    
    //2. 标签栏
    self.tabBarView.width = self.width;
    self.tabBarView.x = 0;
    // 横屏
    if (HMLandscape) {
        self.tabBarView.height = self.width / 3 * 6;
    } else{
        self.tabBarView.height = self.width * 6;
    }
    self.tabBarView.y = self.toolBarView.y - self.tabBarView.height;
    
    //3. 头像
    if (HMLandscape) {
        self.profileButton.width = self.width * 0.4;
        self.profileButton.height = self.profileButton.width + 30;
        self.profileButton.y = 70;
    } else {
        self.profileButton.width = self.width * 0.8;
        self.profileButton.height = self.profileButton.width;
        
        self.profileButton.y = 150;
    }
    self.profileButton.x = (self.width - self.profileButton.width) / 2;
}


@end
 

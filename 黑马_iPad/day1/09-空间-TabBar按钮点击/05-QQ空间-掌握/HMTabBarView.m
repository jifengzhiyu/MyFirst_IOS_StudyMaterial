 //
//  HMTabBarView.m
//  05-QQ空间-掌握
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HMTabBarView.h"
#import "HMTabBarButton.h"

@interface HMTabBarView ()

/** 当前选中的按钮*/
@property (nonatomic, strong) HMTabBarButton *selectButton;

@end

@implementation HMTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 创建六个按钮
        HMTabBarButton *firstButton = [self setupButtonWithIcon:@"tab_bar_feed_icon" title:@"全部动态"];
        
        // 设置第一个按钮失效
        firstButton.enabled = NO;
        
        // 跟属性绑定
        self.selectButton = firstButton;
        
        // 必须在 DockView 创建完毕之后, 才能选择控制器
        
        // 调用按钮的方法 --> 传值
        //[self tabBarButtonClick:firstButton];
        
        [self setupButtonWithIcon:@"tab_bar_passive_feed_icon" title:@"与我相关"];
        [self setupButtonWithIcon:@"tab_bar_pic_wall_icon" title:@"照片墙"];
        [self setupButtonWithIcon:@"tab_bar_e_album_icon" title:@"电子相框"];
        [self setupButtonWithIcon:@"tab_bar_friend_icon" title:@"好友"];
        [self setupButtonWithIcon:@"tab_bar_e_more_icon" title:@"设置"];
    }
    return self;
}

#pragma mark 自定义按钮
//让按钮创建的时候, 返回自己本身
- (HMTabBarButton *)setupButtonWithIcon:(NSString *)icon title:(NSString *)title
{
    HMTabBarButton *button = [HMTabBarButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    //添加tag --> 只会设置一次
    button.tag = self.subviews.count;
    
    //添加方法
    [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return button;
}

#pragma mark TabBar 按钮点击
- (void)tabBarButtonClick:(HMTabBarButton *)button
{
    //1. 让之前选中的控件恢复普通状态
    self.selectButton.enabled = YES;
    
    //2. 设置当前控件的为特殊状态
    button.enabled = NO;
    
    //3. 让当前控件成为选中的控件
    self.selectButton = button;
    
    //4. 发送通知, 传递索引值
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HMTabBarButtonDidChangeNotification" object:nil userInfo:@{@"HMTabBarSelectIndex" : @(button.tag)}];
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
        HMTabBarButton *button = self.subviews[i];
        
        //4. 设置位置
        button.width = self.width;
        button.height = self.height / count;
        button.x = 0;
        button.y = i * button.height;
        
        //5. 添加 tag 值 --> 不建议这么写. 如果在这里写, 会设置很多次
//        button.tag = i;
    }
}



@end

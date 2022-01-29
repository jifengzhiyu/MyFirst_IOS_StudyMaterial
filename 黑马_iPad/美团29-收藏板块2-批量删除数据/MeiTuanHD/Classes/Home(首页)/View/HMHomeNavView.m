//
//  HMHomeNavView.m
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMHomeNavView.h"

@interface HMHomeNavView ()

@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation HMHomeNavView

/** 提供一个类方法, 加载 xib*/
+ (instancetype)homeNavView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HMHomeNavView" owner:nil options:nil] firstObject];
}

/** 提供方法, 用于绑定按钮的点击事件*/
- (void)addTarget:(id)target action:(SEL)action
{
    [self.coverButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

/** 设置标题*/
- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

/** 设置子标题*/
- (void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLabel.text = subtitle;
}

/** 设置图标以及高亮图标*/
- (void)setIcon:(NSString *)icon hightIcon:(NSString *)hightIcon
{
    [self.coverButton setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.coverButton setImage:[UIImage imageNamed:hightIcon] forState:UIControlStateHighlighted];
}

#pragma mark 使用 xib 的时候
- (void)awakeFromNib
{
    /**
     1. 当一个较大的视图, 放到较小的视图里, 视图肯定会发生压缩行为
     2. autoLayout 会勾选autoresizing相关的属性. 导致压缩时, 视图也会跟着压缩. 有可能就压缩看不见了
     */
    self.autoresizingMask = UIViewAutoresizingNone;
}


@end

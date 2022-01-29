//
//  HMHomeNavView.h
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMHomeNavView : UIView

/**
 .h中暴露属性更好, 还是. m 封装属性更好
 原因: 
 1. 控件名称发生改变, .h 暴露需要修改2个地方
 2. .h 暴露, 有可能在别的地方发生误修改, .m 可以保护权限
 */
//@property (weak, nonatomic) IBOutlet UIButton *button1;

/** 提供方法, 用于绑定按钮的点击事件*/
- (void)addTarget:(id)target action:(SEL)action;


/** 设置标题*/
- (void)setTitle:(NSString *)title;

/** 设置子标题*/
- (void)setSubtitle:(NSString *)subtitle;

/** 设置图标以及高亮图标*/
- (void)setIcon:(NSString *)icon hightIcon:(NSString *)hightIcon;


/** 提供一个类方法, 加载 xib*/
+ (instancetype)homeNavView;

@end

//
//  UIBarButtonItem+HMCategory.m
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIBarButtonItem+HMCategory.h"

@implementation UIBarButtonItem (HMCategory)

/** 提供类方法, 返回带有高亮图像的 BarButtonItem*/
+ (instancetype)barBuutonItemWithTarget:(id)target action:(SEL)action icon:(NSString *)icon highlighticon:(NSString *)highlighticon
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlighticon] forState:UIControlStateHighlighted];
     
     // 可以设置成图像的大小
     button.size = button.currentImage.size;
     
    [button addTarget:target action:action forControlEvents: UIControlEventTouchUpInside];

    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end

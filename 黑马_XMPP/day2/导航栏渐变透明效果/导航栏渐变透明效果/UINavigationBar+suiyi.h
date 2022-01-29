//
//  UINavigationBar+suiyi.h
//  导航栏渐变透明效果
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (suiyi)

@property(nonatomic,strong)UIView *SYView;


//提供一个渐变透明的方法
- (void)navigationToAphle:(UIColor *)color;

@end

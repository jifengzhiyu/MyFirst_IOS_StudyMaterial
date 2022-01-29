//
//  UINavigationBar+suiyi.m
//  导航栏渐变透明效果
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "UINavigationBar+suiyi.h"
#import <objc/runtime.h>

@implementation UINavigationBar (suiyi)
static char syview;

-(UIView *)SYView
{
  return  objc_getAssociatedObject(self,&syview);
}

-(void)setSYView:(UIView *)SYView
{
    objc_setAssociatedObject(self, &syview, SYView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//实现渐变透明效果
-(void)navigationToAphle:(UIColor *)color
{
    if (!self.SYView) {
        //不清楚为什么
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        //syview还没有创建
        self.SYView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        
        //插入最底下
        [self insertSubview:self.SYView atIndex:0];
        //插入到文字上面
//        [self insertSubview:self.SYView atIndex:1];

        
    }
    //设置颜色
//    [self setBackgroundColor:color];
    self.SYView.backgroundColor = color;
    

}

@end

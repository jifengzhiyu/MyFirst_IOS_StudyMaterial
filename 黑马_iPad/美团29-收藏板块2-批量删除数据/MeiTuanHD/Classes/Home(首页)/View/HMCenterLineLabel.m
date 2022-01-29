//
//  HMCenterLineLabel.m
//  MeiTuanHD
//
//  Created by apple on 16/3/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMCenterLineLabel.h"

@implementation HMCenterLineLabel


/**
 Label上的文字, 其实是画上去的
 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //方法一: 画线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, rect.size.height * 0.5);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height * 0.5);
    CGContextStrokePath(context);
    
    
    //方法二: 画矩形 --> 高度为1
    //UIRectFill(CGRectMake(0, rect.size.height * 0.5, rect.size.width, 1));
    
}

@end

//
//  TestView.m
//  day6
//
//  Created by 翟佳阳 on 2021/10/4.
//

#import "TestView.h"

@implementation TestView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //矩阵操作
    //旋转
    //CGContextRotateCTM(ctx, M_PI_4);
    //缩放
   // CGContextScaleCTM(ctx, 0.5, 0.5);
    //平移
    CGContextTranslateCTM(ctx, 150, 150);
    
    
    //拼接路径 添加到上下文
    CGContextAddArc(ctx, 150, 150, 100, 0, 2 * M_PI, 1);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 300, 300);
    
    CGContextSetLineWidth(ctx, 10);
    
    CGContextStrokePath(ctx);
    
}


@end

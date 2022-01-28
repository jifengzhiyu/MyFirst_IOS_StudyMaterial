//
//  TestView.m
//  上下文栈
//
//  Created by 翟佳阳 on 2021/10/5.
//

#import "TestView.h"

@implementation TestView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1备份
    CGContextSaveGState(ctx);
    
    CGContextAddArc(ctx, 150, 150, 100, 0, 2 * M_PI, 1);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 300, 300);
    
    CGContextSetLineWidth(ctx, 10);
    
    //2备份
    CGContextSaveGState(ctx);
    
    [[UIColor redColor] set];
    
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, 20, 20);
    CGContextAddLineToPoint(ctx, 250, 20);
    
    //恢复1---》 备份2
    CGContextRestoreGState(ctx);
    //回复2 ---》备份1
    CGContextRestoreGState(ctx);
    
    CGContextStrokePath(ctx);
    
}


@end

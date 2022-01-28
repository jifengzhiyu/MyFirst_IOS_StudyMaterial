//
//  TextView.m
//  内存管理
//
//  Created by 翟佳阳 on 2021/10/5.
//

#import "TextView.h"

@implementation TextView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathAddLineToPoint(path, NULL, 100, 200);
    
    CGContextAddPath(ctx, path);
    
    CGContextStrokePath(ctx);
    
    //CGPathRelease(path);
    CFRelease(path);
}


@end

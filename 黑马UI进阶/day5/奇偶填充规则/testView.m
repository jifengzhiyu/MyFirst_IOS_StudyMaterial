//
//  testView.m
//  奇偶填充规则
//
//  Created by 翟佳阳 on 2021/10/4.
//

#import "testView.h"

@implementation testView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self test2];
    
}

- (void) test2{
    //OC
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 200, 100)];
    [path addArcWithCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:1];
    
    path.usesEvenOddFillRule = YES;
    [path fill];
    
}


- (void) test1{
    //C
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 200, 100)];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 150) radius:80 startAngle:0 endAngle:M_PI * 2 clockwise:1];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake(150, 30, 20, 200)];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextAddPath(ctx, path1.CGPath);
    CGContextAddPath(ctx, path2.CGPath);
    
    //覆盖奇数次填充 偶数次不填
    CGContextDrawPath(ctx, kCGPathEOFill);
}


@end

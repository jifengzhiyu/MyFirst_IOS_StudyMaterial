//
//  testView.m
//  非零绕数填充规则 0
//
//  Created by 翟佳阳 on 2021/10/4.
//

#import "testView.h"

@implementation testView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 
 CGContextRef ctx = UIGraphicsGetCurrentContext();
 
 UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:1];
 UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:0];

 CGContextAddPath(ctx, path.CGPath);
 CGContextAddPath(ctx, path1.CGPath);
 
 CGContextDrawPath(ctx, kCGPathFill);
}


@end

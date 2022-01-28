//
//  TestView.m
//  简单绘图Demo
//
//  Created by 翟佳阳 on 2021/10/4.
//

#import "TestView.h"

@implementation TestView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //[self test1];
    //[self test2];
    //[self test3];
    [self test4];
  
}

- (void) test4{
    //startAngle:0 默认从三点钟开始画
    //通过画弧 OC
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle: 2 * M_PI clockwise:1];
//    [path stroke];
    
    
    //C
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, 150, 150, 100, 0, M_PI_2, 1);
    //C里面，顺时针 逆时针是相反的
    CGContextStrokePath(ctx);
    
}

- (void) test3{
    //椭圆 OC
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 30)];
//    [path stroke];
    
    //C
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 200, 100));
    CGContextStrokePath(ctx);
}


- (void)test2{
    //圆角矩形
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 100, 100) cornerRadius:10];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 100, 100) cornerRadius:33];

    [path stroke];
    
}

- (void) test1{
    //矩形
//    //创建路径
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 100, 100)];
//    //渲染
//    [path stroke];
    [[UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 100, 100)] stroke];
}
@end

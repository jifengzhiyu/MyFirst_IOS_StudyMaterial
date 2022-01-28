//
//  TestView.m
//  渲染的方式
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
    [self test2];
    
}


- (void) test2 {
    //OC
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(150, 50)];
    //关闭路径
    [path closePath];
    
    //设置填充的颜色
    [[UIColor redColor] setFill];
    //设置描边的颜色
    [[UIColor blueColor] setStroke];
    
    //一起设置描边和填充颜色（一样
    [[UIColor greenColor] set];
    
    //渲染
    //既描边又填充：把两个渲染都写上
    [path stroke];
    [path fill];
}

- (void) test1{
    //C
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 150, 50);
    //CGContextAddLineToPoint(ctx, 50, 50);
    //关闭路径，把当前笔在的点 和 笔一开始在的点连线
    CGContextClosePath(ctx);
    
//    //CGContextStrokePath(ctx);//描边
//    CGContextFillPath(ctx);//填充
    
    
    //填充设置颜色
    [[UIColor redColor] setFill];
    //设置描边颜色
    [[UIColor blueColor] setStroke];
    
    //渲染
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    
    //CGContextDrawPath(ctx, kCGPathStroke);
    
    
    
}

@end

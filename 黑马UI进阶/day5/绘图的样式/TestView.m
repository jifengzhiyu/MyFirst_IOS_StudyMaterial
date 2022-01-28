//
//  TestView.m
//  绘图的样式
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

- (void)test2{
    //OC
    
    //路径对象
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    //拼接路径
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(150, 50)];
    
    //设置线宽
    [path setLineWidth:30];
    
    //连接处样式
    [path setLineJoinStyle:kCGLineJoinRound];
    
    //头尾样式
    [path setLineCapStyle:kCGLineCapRound];
    
    //颜色
    [[UIColor blueColor] setStroke];
    
    //渲染
    [path stroke];
    
}



- (void) test1{
    //C
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //拼接路径 同时把路径添加到上下文
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 150, 50);
    
    //线宽
    CGContextSetLineWidth(ctx, 30);
    
    //连接处的样式
    //kCGLineJoinMiter (the default), kCGLineJoinRound, or kCGLineJoinBevel.
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    
    //头尾
    //kCALineCapButt,kCALineCapRound,kCALineCapSquare
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //颜色
    CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);
    
    //渲染
    CGContextStrokePath(ctx);
    
}

@end

//
//  TestView.m
//  绘图的方式
//
//  Created by 翟佳阳 on 2021/10/3.
//

#import "TestView.h"

@implementation TestView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //[self test1];
    //[self test2];
    //[self test3];
    //[self test4];
    [self test5];
    
}

///能用纯OC就用,里面直接封装好了
- (void) test5 {
    //1、创建路径对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //2、通过路径对象 拼接路径
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 100)];
    
    //3、渲染
    [path stroke];
    
    
}


-(void) test1{
    // Drawing code
    //用c写
    //1、获取当前绘图上下文（layer
    //在这个方法里面获取上下文的类型就是 layer
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2、拼接路径 把路径添加到上下文中
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 100, 100);
    
    //3、渲染
    CGContextStrokePath(ctx);
}

- (void) test2{
    //用c写
    //1、获取当前绘图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2、拼接路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathAddLineToPoint(path, NULL, 100, 100);
    
    //3、把路径添加到上下文中
    CGContextAddPath(ctx, path);
    
    //4、渲染
    CGContextStrokePath(ctx);
    
    
}

- (void) test3{
    //c + OC
    //1、获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2、拼接路径（OC
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 100)];
    
    //3、把路径添加到上下文里
    //OC path 转化 C
    CGContextAddPath(ctx, path.CGPath);
    
    //4、渲染
    CGContextStrokePath(ctx);
    
}

- (void) test4{
    //c + oc
    //1、获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2、拼接路径（ c
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathAddLineToPoint(path, NULL, 100, 100);
    
    //3、拼接路径（OC
    UIBezierPath *path1 = [UIBezierPath bezierPathWithCGPath:path];
    [path1 addLineToPoint:CGPointMake(150, 50)];
    
    //4、把路径添加到上下文当中
    CGContextAddPath(ctx, path1.CGPath);
    
    //5、渲染
    CGContextStrokePath(ctx);
    
    
}

@end

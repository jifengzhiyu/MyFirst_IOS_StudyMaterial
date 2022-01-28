//
//  JFView.m
//  绘图的步骤
//
//  Created by 翟佳阳 on 2021/10/3.
//

#import "JFView.h"

@implementation JFView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //1、获取 系统创建好了的 当前绘图上下文
    //系统创建的上下文 和故事版里面该JFView的大小一样
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2、拼接路径 同时 把路径添加到上下文中
    //坐标 依据JFView
    CGContextMoveToPoint(ctx, 50, 50);//起点 抬笔移动
    CGContextAddLineToPoint(ctx, 100, 100);//终点（还没抬笔
    CGContextAddLineToPoint(ctx, 150, 50);
    
    CGContextMoveToPoint(ctx, 50, 200);
    CGContextAddLineToPoint(ctx, 200, 200);
    
    //3、渲染
    //把草稿纸的内容 搬到真实的地方
    CGContextStrokePath(ctx);
    //执行完毕后，上下文还在，之前画的路径不在
}


@end

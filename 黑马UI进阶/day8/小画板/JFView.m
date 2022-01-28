//
//  JFView.m
//  小画板
//
//  Created by 翟佳阳 on 2021/10/8.
//

#import "JFView.h"
#import "JFBezierPath.h"
@interface JFView ()
//@property (nonatomic, strong) JFBezierPath *path;
@property (nonatomic, strong) NSMutableArray *paths;



@end
@implementation JFView


- (void)eraser {
    //相当于把画笔颜色切换成背景色
    self.lineColor = self.backgroundColor;
}

- (void)back {
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

- (void)clear {
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
    
}

//懒加载
//- (JFBezierPath *)path{
//    if(!_path){
//        _path = [[JFBezierPath alloc] init];
//    }
//    return _path;
//}

//懒加载
- (NSMutableArray *)paths{
    if(!_paths){
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    
    JFBezierPath *path = [[JFBezierPath alloc] init];
    
    //设置线宽
    [path setLineWidth:self.lineWidth];
    [path setLineColor1:self.lineColor];
    
    
    //添加起点
    [path moveToPoint:p];
    //把每一次创建的路径添加到数组中
    [self.paths addObject:path];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    
    [self.paths.lastObject addLineToPoint:p];
    
    //重绘
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    for (JFBezierPath *path in self.paths) {
        
        //设置样式
        [path setLineJoinStyle:kCGLineJoinRound];
        [path setLineCapStyle:kCGLineCapRound];
         
        [path.lineColor1 set];
        
        [path stroke];

    }
    
    
}


@end

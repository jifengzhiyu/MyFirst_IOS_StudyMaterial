//
//  testView.m
//  饼图
//
//  Created by 翟佳阳 on 2021/10/4.
//

#import "testView.h"

@implementation testView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSArray *array = @[@0.3, @0.1, @0.2, @0.1, @0.2, @0.1];
    CGFloat start = 0;
    CGFloat end = 0;
    for (int i = 0; i < array.count; i++) {
        end = 2 * M_PI * [array[i] floatValue] + start;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:start endAngle:end clockwise:1];
        
        //画扇形往圆心连线
        [path addLineToPoint:CGPointMake(150, 150)];
        
        //随机颜色
        [[UIColor colorWithRed:((float) arc4random_uniform(256) / 255.0) green:((float) arc4random_uniform(256) / 255.0) blue:((float) arc4random_uniform(256) / 255.0) alpha:1.0] set];
        
        [path fill];
        start = end;
    }
    
}

///重绘
///点击testView调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //全部重绘
    //[self setNeedsDisplay];
    
    //重绘指定的部分
    [self setNeedsDisplayInRect:CGRectMake(0, 0, 150, 150)];
}
@end

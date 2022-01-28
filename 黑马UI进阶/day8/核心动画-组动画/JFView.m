//
//  JFView.m
//  核心动画-组动画
//
//  Created by 翟佳阳 on 2021/10/8.
//

#import "JFView.h"

@implementation JFView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:2 * M_PI clockwise:1];
    
    [path stroke];
}


@end

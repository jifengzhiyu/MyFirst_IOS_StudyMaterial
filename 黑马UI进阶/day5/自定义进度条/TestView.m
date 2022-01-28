//
//  TestView.m
//  自定义进度条
//
//  Created by 翟佳阳 on 2021/10/4.
//

#import "TestView.h"

@interface TestView ()
@property(weak, nonatomic) IBOutlet UILabel * progressLbl;

@end



@implementation TestView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 - M_PI_2 endAngle:2 * M_PI * self.progressValue - M_PI_2 clockwise:1];
    
    [path addLineToPoint:CGPointMake(150, 150)];
    
    [[UIColor redColor] set];
    
    [path fill];
    
}

//调用就重绘
- (void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
    
    //两个%% 等价于一个%普通字符
    self.progressLbl.text = [NSString stringWithFormat:@"%.2f%%", _progressValue * 100];
    
    //重绘
    [self setNeedsDisplay];
    
}

@end

//
//  TestView.m
//  绘制文字
//
//  Created by 翟佳阳 on 2021/10/5.
//

#import "TestView.h"

@implementation TestView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //1、文字
    NSString *str = @"阿巴巴";
    //创建shadow
    NSShadow *s = [[NSShadow alloc] init];
    s.shadowOffset = CGSizeMake(150, 50);
    //阴影的偏移量（位置
    s.shadowBlurRadius = 5;
    //模糊程度，越小越清晰
    s.shadowColor = [UIColor blueColor];
    
    //2、绘制
    //2、1从一个点开始绘制
    [str drawAtPoint:CGPointZero withAttributes:
     @{
            NSFontAttributeName : [UIFont systemFontOfSize:30],
            NSForegroundColorAttributeName : [UIColor redColor],
            NSUnderlineStyleAttributeName : @"0",
            NSShadowAttributeName : s
    }];
    
    
    //2、2绘制到指定区域
    //可以自动换行
    //[str drawInRect:CGRectMake(0, 0, 200, 200) withAttributes:nil];
}


@end

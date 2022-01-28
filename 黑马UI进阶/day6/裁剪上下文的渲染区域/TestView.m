//
//  TestView.m
//  裁剪上下文的渲染区域
//
//  Created by 翟佳阳 on 2021/10/5.
//

#import "TestView.h"

@implementation TestView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIImage *image = [UIImage imageNamed:@"22"];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画出需要显示的区域
    CGContextAddArc(ctx, 150, 150, 150, 0, 2 * M_PI, 1);
     
    //裁剪 上下文的显示区域
    CGContextClip(ctx);
    
    //渲染的时候，只渲染里面的圆（需要显示的区域
    [image drawInRect:rect];
}


@end

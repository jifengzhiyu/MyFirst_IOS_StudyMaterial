//
//  testView.m
//  DrawRect
//
//  Created by 翟佳阳 on 2021/10/4.
//

#import "testView.h"

@implementation testView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"%@",UIGraphicsGetCurrentContext());
    
    NSLog(@"%@",NSStringFromCGRect(rect));
    
    [self setNeedsDisplay];
    [self setNeedsDisplayInRect:rect];
}


@end

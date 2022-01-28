//
//  testView.m
//  柱状图
//
//  Created by 翟佳阳 on 2021/10/4.
//

#import "testView.h"

@implementation testView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSArray *array = @[@0.5, @0.3, @0.1, @0.7, @0.9, @0.2];
    for (int i = 0; i < array.count; i++) {
        //计算Rect
        CGFloat w = 20;
        CGFloat h = [array[i] floatValue] *rect.size.height;
        CGFloat x = i * 2 * w;
        CGFloat y = rect.size.height - h;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
        
        //随机色
        [[UIColor colorWithRed:((float) arc4random_uniform(256) / 255.0) green:((float) arc4random_uniform(256) / 255.0) blue:((float) arc4random_uniform(256) / 255.0) alpha:1.0] set];
        
        //渲染
        [path fill];
        
    }
    
    
}
 

@end

//
//  TestView.m
//  绘制图片
//
//  Created by 翟佳阳 on 2021/10/5.
//

#import "TestView.h"

@implementation TestView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //[self test1];
    [self test2];
}

- (void) test2{
    //大图
    UIImage *image = [UIImage imageNamed:@"24"];
    //从点开始绘制
    //[image drawAtPoint:CGPointZero];
    //[image drawAtPoint:CGPointMake(50, 100)];
    
    //绘制到某个区域(拉伸
    [image drawInRect:CGRectMake(0, 0, 300, 300)];
    
    //绘制到某个区域(平铺
    //[image drawAsPatternInRect:CGRectMake(0, 0, 300, 300)];
    
}


- (void)test1{
    //小图
    UIImage *image = [UIImage imageNamed:@"O_1"];
    //从点开始绘制
    //[image drawAtPoint:CGPointZero];
    //[image drawAtPoint:CGPointMake(50, 100)];
    
    //绘制到某个区域(拉伸
    //[image drawInRect:CGRectMake(0, 0, 300, 300)];
    
    //绘制到某个区域(平铺
    [image drawAsPatternInRect:CGRectMake(0, 0, 300, 300)];
}
@end

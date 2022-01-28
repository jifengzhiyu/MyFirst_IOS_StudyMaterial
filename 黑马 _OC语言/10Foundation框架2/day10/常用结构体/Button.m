//
//  Button.m
//  常用结构体
//
//  Created by 翟佳阳 on 2021/8/24.
//

#import "Button.h"

@implementation Button
- (void)show
{
    NSLog(@"show，坐标%lf,%lf,大小是,%lf,%lf",
          _point.x,
          _point.y,
          _size.width,
          _size.height
          );
}
- (void)hide
{
    NSLog(@"看不见我");
}
@end

//
//  UIView+ITCASTExt.m
//  06网易彩票
//
//  Created by teacher on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIView+ITCASTExt.h"

@implementation UIView (ITCASTExt)

- (CGFloat)x
{
    CGRect rect = self.frame;
    return rect.origin.x;
}
- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}




- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}




- (CGFloat)w
{
    return self.frame.size.width;
}
- (void)setW:(CGFloat)w
{
    CGRect rect = self.frame;
    rect.size.width = w;
    self.frame = rect;
}



- (CGFloat)h
{
    return self.frame.size.height;
}
-(void)setH:(CGFloat)h
{
    CGRect rect = self.frame;
    rect.size.height = h;
    self.frame = rect;
}




@end











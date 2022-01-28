//
//  ITCASTGroupBuyTitleButton.m
//  06网易彩票
//
//  Created by teacher on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTGroupBuyTitleButton.h"
#import "UIView+ITCASTExt.h"
@implementation ITCASTGroupBuyTitleButton

//- (CGRect)imageRectForContentRect:(CGRect)contentRect;
//- (CGRect)titleRectForContentRect:(CGRect)contentRect;

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1. 设置按钮中的Label的x为0
    //    CGRect frameLabel = self.titleLabel.frame;
    //    frameLabel.origin.x = 0;
    //    self.titleLabel.frame = frameLabel;
    self.titleLabel.x = 0;
    
    // 2. 设置按钮中的imageView的x等于Label的宽度
    //    CGRect frameImageView = self.imageView.frame;
    //    frameImageView.origin.x = frameLabel.size.width;
    //    self.imageView.frame = frameImageView;
    self.imageView.x = self.titleLabel.w;
}

@end

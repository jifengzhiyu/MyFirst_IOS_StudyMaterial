//
//  ITCASTAboutHeaderView.m
//  06网易彩票
//
//  Created by teacher on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTAboutHeaderView.h"

@implementation ITCASTAboutHeaderView

+ (instancetype)aboutHeaderView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ITCASTAboutHeaderView" owner:nil options:nil] lastObject];
}

@end

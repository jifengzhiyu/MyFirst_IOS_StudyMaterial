//
//  HMTool.m
//  HeiMaLib
//
//  Created by Romeo on 15/9/24.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMTool.h"

@implementation HMTool

+ (NSInteger)sum1:(NSInteger)sum1 addSum2:(NSInteger)sum2
{
    return sum1 + sum2;
}

+ (UIImage *)loadImage:(NSString *)iamgeName
{
    return [UIImage imageNamed:@"HMTool.bundle/cang"];
}

@end

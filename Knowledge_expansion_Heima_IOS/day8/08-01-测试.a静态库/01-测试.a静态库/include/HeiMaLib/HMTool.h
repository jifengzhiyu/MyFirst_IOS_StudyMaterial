//
//  HMTool.h
//  HeiMaLib
//
//  Created by Romeo on 15/9/24.
//  Copyright © 2015年 itheima. All rights reserved.
// 工具类 --> 计算两个数之和 加载图像

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HMTool : NSObject

/** 计算两个数之和*/
+ (NSInteger) sum1:(NSInteger)sum1 addSum2:(NSInteger)sum2;

/** 加载图像*/
+ (UIImage *)loadImage:(NSString *)iamgeName;

@end

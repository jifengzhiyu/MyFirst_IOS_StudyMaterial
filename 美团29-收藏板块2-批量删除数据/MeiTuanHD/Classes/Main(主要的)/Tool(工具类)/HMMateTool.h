//
//  HMMateTool.h
//  MeiTuanHD
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMBusinessModel;

@interface HMMateTool : NSObject
/**
 1. 加载 plist 数据 --> 抽取成工具方法, 来替换所有加载此 plist 的地方
 2. 根据模型的 categories 信息, 遍历 plist 数据来返回对应的地图信息
 */

/** 返回分类信息*/
+ (NSArray *)categories;

/** 根据模型来返回对应的地图信息*/
+ (NSString *)mapNameWithBusinessModel:(HMBusinessModel *)businessModel;

@end

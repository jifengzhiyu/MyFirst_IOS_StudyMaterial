//
//  HMDealTool.h
//  MeiTuanHD
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMDealModel;

@interface HMDealTool : NSObject

/** 添加一条数据*/
+ (void)insertCollectDeal:(HMDealModel *)dealModel;

/** 删除一条数据*/
+ (void)removeCollectDeal:(HMDealModel *)dealModel;

/** 判断数据库是否添加了模型数据*/
+ (BOOL)isCollectDeal:(HMDealModel *)dealModeal;

/** 根据传入的页码, 返回对应的数据*/
+ (NSArray *)collectDealModelWithPage:(NSInteger)page;

/** 返回数据库的总个数*/
+ (NSInteger)totalCount;

@end

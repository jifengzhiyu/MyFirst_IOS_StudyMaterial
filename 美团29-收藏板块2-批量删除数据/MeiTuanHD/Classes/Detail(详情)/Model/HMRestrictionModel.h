//
//  HMRestrictionModel.h
//  MeiTuanHD
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMRestrictionModel : NSObject

/** 是否支持随时退款，0：不是，1：是*/
@property (nonatomic, assign) NSInteger is_refundable;

@end

//
//  HMDistrictModel.h
//  MeiTuanHD
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMDistrictModel : NSObject

/** 名字*/
@property (nonatomic, copy) NSString *name;

/** 子区域数据*/
@property (nonatomic, strong) NSArray *subdistricts;

@end

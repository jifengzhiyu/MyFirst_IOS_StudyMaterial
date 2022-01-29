//
//  HMCityModel.m
//  MeiTuanHD
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMCityModel.h"
#import "HMDistrictModel.h"

@implementation HMCityModel

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
// @"HMDistrictModel" --> Class Name
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"districts" : [HMDistrictModel class]};
}

@end

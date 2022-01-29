//
//  HMAnnotationModel.m
//  MeiTuanHD
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMAnnotationModel.h"

@implementation HMAnnotationModel

/** 重写此方法, 自己指定要比较的部分*/
- (BOOL)isEqual:(HMAnnotationModel *)object
{
    return [self.title isEqualToString:object.title];
}

@end

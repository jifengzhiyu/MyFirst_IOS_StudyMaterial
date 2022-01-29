//
//  HMCityGroupModel.h
//  MeiTuanHD
//
//  Created by Romeo on 15/10/16.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMCityGroupModel : NSObject

/** 标题*/
@property (nonatomic, copy) NSString *title;

/** 城市数据*/
@property (nonatomic, strong) NSArray *cities;

@end

//
//  HMBusinessModel.h
//  MeiTuanHD
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMBusinessModel : NSObject

/** 经度 */
@property (nonatomic, assign) CGFloat longitude;

/** 纬度 */
@property (nonatomic, assign) CGFloat latitude;

/** 商家名称 */
@property (nonatomic, copy) NSString *name;

/** 商家地址 */
@property (nonatomic, copy) NSString *address;

/** 所属分类信息列表，如[宁波菜，婚宴酒店]*/
@property (nonatomic, strong) NSArray *categories;

@end

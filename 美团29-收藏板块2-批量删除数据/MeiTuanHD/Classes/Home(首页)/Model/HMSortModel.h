//
//  HMSortModel.h
//  MeiTuanHD
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSortModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *label;

/** 值--> 给服务器发送的 */
@property (nonatomic, strong) NSNumber *value;

@end

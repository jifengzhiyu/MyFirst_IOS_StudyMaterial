//
//  HMDealModel.h
//  MeiTuanHD
//
//  Created by apple on 16/3/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMRestrictionModel.h"

@interface HMDealModel : NSObject

/** 团购单ID */
@property (copy, nonatomic) NSString *deal_id;

/** 团购标题 */
@property (copy, nonatomic) NSString *title;

//不能使用description
/** 团购描述 */
@property (copy, nonatomic) NSString *desc;

//要想保持服务器的价格, NSString  NSNumber
/** 团购包含商品原价值 */
@property (nonatomic, copy) NSString *list_price;

/** 团购价格 */
@property (nonatomic, copy) NSString *current_price;

/** 团购当前已购买数 */
@property (assign, nonatomic) int purchase_count;

/** 团购图片链接，最大图片尺寸450×280 */
@property (copy, nonatomic) NSString *image_url;

/** 小尺寸团购图片链接，最大图片尺寸160×100 */
@property (copy, nonatomic) NSString *s_image_url;

/** 团购发布上线日期*/
@property (copy, nonatomic) NSString *publish_date;

/** 团购HTML5页面链接，适用于移动应用和联网车载应用*/
@property (copy, nonatomic) NSString *deal_h5_url;

/** 团购单的截止购买日期*/
@property (copy, nonatomic) NSString *purchase_deadline;

/** 团购限制数据 --> 首页无法获取此数据 nil. 在详情页面才会有值*/
@property (nonatomic, strong) HMRestrictionModel *restrictions;

/** 是否点击了编辑*/
@property (nonatomic, assign, getter = isEditting) BOOL editting;

/** 是否打钩了*/
@property (nonatomic, assign, getter = isChoose) BOOL  choose;


@end

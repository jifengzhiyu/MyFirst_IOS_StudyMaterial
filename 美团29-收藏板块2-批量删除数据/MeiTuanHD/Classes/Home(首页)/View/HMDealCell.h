//
//  HMDealCell.h
//  MeiTuanHD
//
//  Created by apple on 16/3/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMDealModel;

@interface HMDealCell : UICollectionViewCell

/** 模型属性*/
@property (nonatomic, strong) HMDealModel *dealModel;

/** 增加 block 属性*/
@property (nonatomic, copy) void(^dealCellDidClickBlock)();

@end

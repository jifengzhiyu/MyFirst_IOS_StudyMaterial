//
//  HMDetailViewController.h
//  MeiTuanHD
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMDealModel;

@interface HMDetailViewController : UIViewController

/** 模型属性*/
@property (nonatomic, strong) HMDealModel *dealModel;

/** 增加 block 属性, 用于收藏按钮点击时的传值*/
@property (nonatomic, copy) void(^detailVCCollectClick)();

@end

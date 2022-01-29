//
//  HMConst.h
//  MeiTuanHD
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// 如果是 CGFloat等 类型
//const CGFloat width = 7;


// extern : 引用本类或者其他类中使用
// 城市通知
extern NSString *const HMCityDidChangeNotifacation;
extern NSString *const HMSelectCityName;

// 分类通知
extern NSString *const HMCategoryDidChangeNotifacation;
extern NSString *const HMSelectCategoryModel;
extern NSString *const HMSelectCategorySubtitle;

// 区域通知
extern NSString *const HMDistrictDidChangeNotifacation;
extern NSString *const HMSelectDistrictModel;
extern NSString *const HMSelectDistrictSubtitle;

// 排序通知
extern NSString *const HMSortDidChangeNotifacation;
extern NSString *const HMSelectSortModel;

// 收藏改变的通知
extern NSString *const HMCollectDidChangeNotification;
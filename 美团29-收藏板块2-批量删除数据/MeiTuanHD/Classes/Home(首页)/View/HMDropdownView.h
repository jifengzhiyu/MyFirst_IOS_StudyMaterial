//
//  HMDropdownView.h
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMDropdownView : UIView

/** 提供属性, 在 categoryVC 中传值*/
@property (nonatomic, strong) NSArray *categoryArray;

/** 提供属性, 在 dictrictVC 中传值*/
@property (nonatomic, strong) NSArray *districtArray;

/** 提供类方法, 加载 xib*/
+ (instancetype)dropDownView;

@end

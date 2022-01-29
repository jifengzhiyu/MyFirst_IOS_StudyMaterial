//
//  HMAnnotationModel.h
//  MeiTuanHD
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
//1. 导入框架
#import <MapKit/MapKit.h>

//2. 遵守协议
@interface HMAnnotationModel : NSObject<MKAnnotation>

//3. 实现属性
@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

/** icon 属性*/
@property (nonatomic, copy, nullable) NSString *icon;

@end

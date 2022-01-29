//
//  MyAnnotationModel.h
//  添加大头针
//
//  Created by 翟佳阳 on 2021/12/27.
//

/**
 1. 导入框架 MapKit
 2. 遵守协议 MKAnnotation
 3. 设置属性 直接去协议中拷贝-->删掉readonly
 */

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotationModel : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

@end

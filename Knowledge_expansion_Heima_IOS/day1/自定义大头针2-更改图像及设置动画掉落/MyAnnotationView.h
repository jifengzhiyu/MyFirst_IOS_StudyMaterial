//
//  MyAnnotationView.h
//  自定义大头针2-更改图像及设置动画掉落
//
//  Created by 翟佳阳 on 2021/12/28.
//

#import <MapKit/MapKit.h>

@interface MyAnnotationView : MKAnnotationView

/** 提供快速创建View的方法*/
+ (instancetype)myAnnotationViewWithMapView:(MKMapView *)mapView;

@end

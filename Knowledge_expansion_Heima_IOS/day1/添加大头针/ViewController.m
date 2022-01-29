//
//  ViewController.m
//  添加大头针
//
//  Created by 翟佳阳 on 2021/12/27.
//
/*
 #pragma mark 1. 添加大头针 (掌握)
 1. 添加大头针 --> 需要自定义大头针模型类
     1. 导入框架 MapKit
     2. 遵守协议 MKAnnotation
     3. 设置属性 直接去协议中拷贝-->删掉readonly
 2. 创建大头针
 3. 添加到地图上
 */
#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotationModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //MKUserLocation --> 大头针模型
    
    //1. 添加大头针 --> 需要自定义大头针模型类
    
    //2. 创建大头针
//    MyAnnotationModel *annotationModel = [MyAnnotationModel new];
//
//    annotationModel.coordinate = CLLocationCoordinate2DMake(39, 116);
//    annotationModel.title = @"北京市";
//    annotationModel.subtitle = @"北京市一个迷人的城市";
//
//    //3. 添加到地图上
//    [self.mapView addAnnotation:annotationModel];
//
//    //添加第二个大头针
//    MyAnnotationModel *annotationModel2 = [MyAnnotationModel new];
//
//    annotationModel2.coordinate = CLLocationCoordinate2DMake(23, 108);
//    annotationModel2.title = @"东莞市";
//    annotationModel2.subtitle = @"东莞市一个令人向往城市";
//
//    //3. 添加到地图上
//    [self.mapView addAnnotation:annotationModel2];
}

#pragma mark 点击添加大头针
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1. 获取点击地图的点
    CGPoint point = [[touches anyObject] locationInView:self.myMapView];
    
    
    //2. 将点击的点转换成经纬度
    CLLocationCoordinate2D coordinate = [self.myMapView convertPoint:point toCoordinateFromView:self.myMapView];
    
    //3. 添加大头针
    MyAnnotationModel *annotationModel = [MyAnnotationModel new];
    
    annotationModel.coordinate = coordinate;
    annotationModel.title = @"北京市";
    annotationModel.subtitle = @"北京市一个迷人的城市";
    
    [self.myMapView addAnnotation:annotationModel];
}



@end

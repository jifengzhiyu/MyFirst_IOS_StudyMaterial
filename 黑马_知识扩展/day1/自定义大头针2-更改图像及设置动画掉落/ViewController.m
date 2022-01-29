//
//  ViewController.m
//  自定义大头针2-更改图像及设置动画掉落
//
//  Created by 翟佳阳 on 2021/12/27.
//
/*
 #pragma mark 3. 自定义大头针2-更改大头针的图像 (掌握)
 设置图像
 1. 修改模型类, 增加属性
 2. 在创建模型类的时候, 去设置相关属性icon
 3. 在自定义大头针View的方法中设置图像  --> MVC

 动画掉落
 0. 处理显示用户位置的大头针View, 不要增加动画
 1. 记录原本的位置
 2. 将View的Y值改为0, 重设Frame
 3. 将位置还原, 执行动画效果

 #pragma mark 4. 自定义大头针的代码封装 (理解)
 额外属性介绍
 1. 设置可以点击呼唤出来之前设置的标题子标题
 2. 设置左边 / 右边 / 详情 附属视图
                          
 封装
 1. 封装大头针View, --> 跟封装cell的过程几乎一样, 唯一一个地方不一样的是, 可以不用设置模型属型
                          
 2.系统会自动调用该方法 annotation 的 set方法
    1. 必须调用父类方法
    2. 设置图像
 */
#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotationModel.h"
#import "MyAnnotationView.h"

@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *MYmapView;

/** 位置管理器*/
@property (nonatomic, strong) CLLocationManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 创建位置管理器
    self.mgr = [CLLocationManager new];
    
    //2. 请求授权
//    if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.mgr requestWhenInUseAuthorization];
//    }

    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
         [self.mgr requestWhenInUseAuthorization];
    }
    
    //3. 跟踪用户位置
    self.MYmapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //4. 设置地图的代理
    self.MYmapView.delegate = self;
    
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


#pragma mark 地图的代理方法
/**
 只要添加了大头针模型, 就会来到这个方法, 设置并返回对应的View
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    //如果返回nil, 就代表用户没有自定义的需求, 所有的View样式由系统处理
    //MKUserLocation: 系统专门显示用户位置的大头针模型
    //MyAnnotationModel: 自定义的类
    
    //1. 如果发现是显示用户位置的大头针模型,  就返回nil
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    
    //2.封装大头针View, --> 跟封装cell的过程几乎一样, 唯一一个地方不一样的是, 可以不用设置模型属性.
    MyAnnotationView *annoView = [MyAnnotationView myAnnotationViewWithMapView:mapView];
    
    
    return annoView;
    
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//
//    //如果返回nil, 就代表用户没有自定义的需求, 所有的View样式由系统处理
//    //MKUserLocation: 系统专门显示用户位置的大头针模型
//    //MyAnnotationModel: 自定义的类
//
//    //1. 如果发现是显示用户位置的大头针模型,  就返回nil
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//
//
//    //2. 自定义大头针View --> 跟Cell的创建几乎一样
//    static NSString *ID = @"annoView";
//
//    //MKAnnotationView : 默认image属性没有赋值
//    //MKPinAnnotationView : 子类是默认有View的
//    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
//
//    if (annoView == nil) {
//        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
//
//        //1. 设置可以点击呼唤出来之前设置的标题子标题
//        annoView.canShowCallout = YES;
//
//        //2. 设置左边附属视图
//        annoView.leftCalloutAccessoryView = [UISwitch new];
//
//        //3. 设置右边附属视图
//        annoView.rightCalloutAccessoryView = [UISwitch new];
//
//        //4. iOS9新增 自定义详情 --> 子标题
//        annoView.detailCalloutAccessoryView = [UISwitch new];
//
//    }
//
//    // 设置图像  --> MVC
//    MyAnnotationModel *myAnnotation = annotation;
//    annoView.image =  [UIImage imageNamed:myAnnotation.icon];
//
//    return annoView;
//
//}


#pragma mark 此方法在添加大头针的时候就会调用, 并且, 在图像出现之前
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views
{
    //NSLog(@"count: %zd",views.count);
    for (MKAnnotationView * annoView in views) {
        
        //0. 处理显示用户位置的大头针View, 不要增加动画
        if ([annoView.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        //1. 记录原本的位置
        CGRect endFrame = annoView.frame;
        
        //2. 将View的Y值改为0, 重设Frame
        annoView.frame = CGRectMake(endFrame.origin.x, 0, endFrame.size.width, endFrame.size.height);
        
        //3. 将位置还原, 执行动画效果
        [UIView animateWithDuration:0.25 animations:^{
            annoView.frame = endFrame;
        }];
        
        
    }
}


#pragma mark 点击添加大头针
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MyAnnotationModel *annotationModel = [MyAnnotationModel new];
    
    //将来是从服务器获取属性值
    annotationModel.coordinate = CLLocationCoordinate2DMake(28, 116);
    annotationModel.title = @"北京市";
    annotationModel.subtitle = @"北京市一个迷人的城市";
    annotationModel.icon = @"苍老师";
    
    [self.MYmapView addAnnotation:annotationModel];
    
    
    MyAnnotationModel *annotationModel2 = [MyAnnotationModel new];
    
    annotationModel2.coordinate = CLLocationCoordinate2DMake(23, 108);
    annotationModel2.title = @"东莞市";
    annotationModel2.subtitle = @"东莞市一个令人向往城市";
    annotationModel2.icon = @"自拍照";
    
    [self.MYmapView addAnnotation:annotationModel2];
}

@end

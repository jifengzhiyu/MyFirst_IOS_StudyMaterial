//
//  ViewController.m
//  自定义大头针-更改颜色及设置动画掉落
//
//  Created by 翟佳阳 on 2021/12/27.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotationModel.h"

@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *JFmapView;

/** 位置管理器*/
@property (nonatomic, strong) CLLocationManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 创建位置管理器
    self.mgr = [CLLocationManager new];
    
    //2. 请求授权
    if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.mgr requestWhenInUseAuthorization];
    }
    
    //3. 跟踪用户位置
    self.JFmapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //4. 设置地图的代理
    self.JFmapView.delegate = self;
    
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
    
    
    //2. 自定义大头针View --> 跟Cell的创建几乎一样
    static NSString *ID = @"annoView";
    
    //MKAnnotationView : 默认image属性没有赋值
    //MKPinAnnotationView : 子类是默认有View的
    MKPinAnnotationView *annoView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    
    if (annoView == nil) {
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        
        /**
         MKPinAnnotationColorRed
         MKPinAnnotationColorGreen,
         MKPinAnnotationColorPurple
         */
        
        // 设置颜色 iOS9首次过期
        //annoView.pinColor =  MKPinAnnotationColorGreen;
        
        //3. 设置颜色, iOS9新增
        annoView.pinTintColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0  blue:arc4random_uniform(256) / 255.0  alpha:1];
        
        //4. 设置动画掉落
        annoView.animatesDrop = YES;
        
    }
    
    return annoView;
    
}



#pragma mark 点击添加大头针
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1. 获取点击地图的点
    CGPoint point = [[touches anyObject] locationInView:self.JFmapView];
    
    
    //2. 将点击的点转换成经纬度
    CLLocationCoordinate2D coordinate = [self.JFmapView convertPoint:point toCoordinateFromView:self.JFmapView];
    
    //3. 添加大头针
    MyAnnotationModel *annotationModel = [MyAnnotationModel new];
    
    annotationModel.coordinate = coordinate;
    annotationModel.title = @"北京市";
    annotationModel.subtitle = @"北京市一个迷人的城市";
    
    [self.JFmapView addAnnotation:annotationModel];
}

@end

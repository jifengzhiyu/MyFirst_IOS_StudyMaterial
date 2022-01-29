//
//  ViewController.m
//  地图划线
//
//  Created by 翟佳阳 on 2021/12/28.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *MYdestinationTF;
@property (weak, nonatomic) IBOutlet MKMapView *MYmapView;

/** 位置管理器--> 要定位必须用这个属性*/
@property (nonatomic, strong) CLLocationManager *mgr;

@end

/**
 如果是地图画线, 无法在模拟器中运行 --> iOS8以后无法在模拟器中运行
 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建位置管理器并授权
    self.mgr = [CLLocationManager new];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        [self.mgr requestWhenInUseAuthorization];
    }
    
    // 设置代理
    self.MYmapView.delegate = self;
    
}

#pragma mark 导航按钮点击
- (IBAction)MYnavigateClick:(id)sender {
    
    // 回收键盘
    [self.view endEditing:YES];
   
    //1. 创建CLGeocoder对象
    CLGeocoder *geocoder = [CLGeocoder new];
    
    //2. 调用地理编码方法
    [geocoder geocodeAddressString:self.MYdestinationTF.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //3 防错处理
        if (placemarks.count == 0 || error) {
            return;
        }
        
        //遍历数组获取数据 --> 正地理编码, 可能重名, 所以数组数量大于1, 一定要给列表提示用户选择
        
        //4. 获取地表对象 暂取最后一个
        CLPlacemark *pm = placemarks.lastObject;
        
        //5. 创建MKPlacemark对象
        MKPlacemark *mkpm = [[MKPlacemark alloc] initWithPlacemark:pm];
        
        //6.1 创建一个终点MKMapItem
        MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:mkpm];
        
        //6.2 创建一个起点MKMapItem
        MKMapItem *souceItem = [MKMapItem mapItemForCurrentLocation];
        
        //7. 创建一个方向请求对象 --> 相当于拼接网址 --> 需要传入参数: 起点和终点
        MKDirectionsRequest *request = [MKDirectionsRequest new];
        //7.1 设置终点
        request.destination = destinationItem;
        //7.2 设置起点
        request.source = souceItem;
        
        
        //8. 创建方向对象 --> 创建一个请求对象
        MKDirections *direction = [[MKDirections alloc] initWithRequest:request];
        
        //9. 计算路径 --> 处理网络请求的结果
        [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            
            //10.1 防错处理
            if (response.routes.count == 0 || error) {
                NSLog(@"没有找到对应的路线");
                return ;
            }
            
            //10.2 遍历数组, 获取数据
            //MKRoute : 路线对象
            for (MKRoute *route in response.routes) {
                
                //polyline : 多段线
                
                //11. 获取折线信息
                MKPolyline *polyline = route.polyline;
                
                //12. 添加到地图上
                //Overlay : 遮盖物
                [self.MYmapView addOverlay:polyline];
            }
        }];
    }];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//
//}

#pragma mark 如果添加了遮盖物, 就需要调用此方法, 来设置渲染
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    //1. 创建一个折线渲染物对象
    MKPolylineRenderer *polyline = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    polyline.fillColor = [UIColor redColor];
    //2. 设置线条颜色 --> 必须设置, 否则看不见
//    polyline.strokeColor = [UIColor blueColor];
    
    //3. 设置线条宽度
    polyline.lineWidth = 10;
    
         
    return polyline;
}


- (void)test
{
    // 应该使用正地理编码
    
    // 创建MKPlacemark --> CLPlacemark --> 地理编码来获取CLPlacemark
    //MKPlacemark *mkpm = [MKPlacemark alloc] initWithPlacemark:<#(nonnull CLPlacemark *)#>
    
    //创建一个MKMapItem --> 终点的位置
    //MKMapItem *destinationItem = [MKMapItem alloc] initWithPlacemark:<#(nonnull MKPlacemark *)#>
    
    //MKMapItem : 地图上的一个点
    //openMapsWithItems : 调用此方法就可以打开系统自带地图导航
    //[MKMapItem openMapsWithItems:<#(nonnull NSArray<MKMapItem *> *)#> launchOptions:<#(nullable NSDictionary<NSString *,id> *)#>]
}


@end

//
//  ViewController.m
//  实现持续定位
//
//  Created by 翟佳阳 on 2021/12/25.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *mgr;

@end

/**
 模拟器bug: 可以尝试切换同系统模拟器.
           或者直接使用真机
 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 创建CLLocationManager对象
    self.mgr = [CLLocationManager new];
    
    //2. 请求用户授权 --> 从iOS8开始, 必须在程序中请求用户授权, 除了写代码, 还要配置plist列表的键值
    if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        
        //当用户使用的使用授权
        [self.mgr requestWhenInUseAuthorization];
    }
    
    //3. 设置代理 --> 获取用户位置
    self.mgr.delegate = self;
    
    //4. 调用开始定位方法
    [self.mgr startUpdatingLocation];
    
    
    /**
     持续定位: 持续定位会消耗电量, 应该对电量做点优化
     
     */
    
    //5. 距离筛选器 --> 位置发生了一定的改变之后, 才去调用代理方法 降低方法的调用来达到省电的目的
    //distanceFilter 单位是米, 如果设置了10, 就代表发生10米以上的位置变化时才会调用代理方法
    self.mgr.distanceFilter = 10;
    
    //6. 定位精准度
    //手机当中哪些方式可以定位: 移动网络数据(基站定位) , GPS , WiFi
    //GPS : 跟全球24颗卫星之间通讯, 降低通讯及计算的过程就可以省电
    //desired: 期望
    //Accuracy: 精准度/精确
    self.mgr.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    /**
     kCLLocationAccuracyBestForNavigation
     kCLLocationAccuracyBest;
     kCLLocationAccuracyNearestTenMeters;
     kCLLocationAccuracyHundredMeters;
     kCLLocationAccuracyKilometer;
     kCLLocationAccuracyThreeKilometers;
     */
}

#pragma mark 代理方法
/** 当完成位置更新的时候调用 --> 此方法会频繁调用*/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.lastObject;
    
    NSLog(@"locations: %tu",location.horizontalAccuracy);
    
    //5. 停止定位 --> 7.1 开始 didUpdateLocations方法有可能不会持续调用
//    [self.mgr stopUpdatingLocation];
    
    //locations: <+40.05894607,+116.32944547> +/- 50.00m (speed 0.00 mps / course -1.00) @ 15/12/11 中国标准时间 09:45:28
}

@end

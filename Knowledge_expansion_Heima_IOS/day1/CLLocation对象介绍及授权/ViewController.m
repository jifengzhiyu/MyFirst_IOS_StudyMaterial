//
//  ViewController.m
//  CLLocation对象介绍及授权
//
//  Created by 翟佳阳 on 2021/12/26.
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
    
    //如果要适配iOS7, 一定要加if判断, 因为低版本的SDK没有授权方法
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) { }
    
    
    /**
     1. 如果要授权, 从iOS8开始, 必须在程序中请求用户授权, 除了写代码, 还要配置plist列表的键值
     2. 授权方式 -->requestWhenInUseAuthorization 当用户使用的使用授权
                -->requestAlwaysAuthorization 永久授权方法
     3. 一定要记得授权方法和plist列表匹配 (when / always)
        NSLocationWhenInUseUsageDescription
        NSLocationAlwaysUsageDescription
     
     4. 如果2个方法都写, 会出现2此授权的情况 (第一次会走第一个方法, 第二次会走第二个方法 --> 一般使用1个方法即可
     
     5. 大部分的程序之使用 "使用期间" 这个授权即可. 如果说列表出出现了3个, 说明两个授权方法写了
     6. plist的Value 可以不写, 写上是为了提示用户, 当前程序会在哪些地方使用定位. 建议写上, 提高用户打开的几率
     )
     */
    
    if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]){
    
        //当用户使用的使用授权 --> 能看见APP界面的时候就是使用期间
        //plist
        [self.mgr requestWhenInUseAuthorization];
        
        //永久授权方法 --> 锁屏 / 退出后台
        //plist
//        [self.mgr requestAlwaysAuthorization];
    }
   
    /**
     iOS9新特性 --> 临时获取后台定位权限
     */
    
     #pragma mark 5. iOS9新特性-临时获取后台定位权限 (了解)
    /*
     使用场景:当程序使用 "requestWhenInUseAuthorization" , 如果想要临时开启后台定位, 那么才需要使用新增的属性
     1. allowsBackgroundLocationUpdates: 设置为YES即可, 还要配置plist列表 Required background modes : App registers for location updates
     */
    //allowsBackgroundLocationUpdates 如果实现了此方法, 还需要配置plist列表
    
    //一定注意适配版本, 要加iOS9判断
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
//        self.mgr.allowsBackgroundLocationUpdates = YES;
//    }
    
    
    //3. 设置代理 --> 获取用户位置
    self.mgr.delegate = self;
    
    //4. 调用开始定位方法
    [self.mgr startUpdatingLocation];
    
    // 比较两个位置之前的距离
    // 北京和西安的距离
    // 创建一个位置对象, 最少只需要两个值, 经纬度
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:40 longitude:116];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:34.27 longitude:108.93];
    
    // 比较的是直线距离
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    NSLog(@"distance: %f",distance / 1000);
}

#pragma mark 代理方法
/** 当完成位置更新的时候调用 --> 次方法会频繁调用*/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //CLLocation : 位置对象, 最核心的就是经纬度
    //CLLocationCoordinate2D coordinate : 2D位置坐标 --> 经纬度
    
    //CLLocationDegrees latitude;  --> 纬度
    //CLLocationDegrees longitude; --> 经度
    

    
    CLLocation *location = locations.lastObject;
    
    //NSLog(@"locations: %@",location);
    
    //5. 停止定位
    //[self.mgr stopUpdatingLocation];
    
    //locations: <+40.05894607,+116.32944547> +/- 50.00m (speed 0.00 mps / course -1.00) @ 15/12/11 中国标准时间 09:45:28
    
    
    NSLog(@"latitude: %f, longitude: %f",location.coordinate.latitude, location.coordinate.longitude);
}

@end

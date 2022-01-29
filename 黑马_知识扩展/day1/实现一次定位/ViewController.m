//
//  ViewController.m
//  实现一次定位
//
//  Created by 翟佳阳 on 2021/12/25.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
/*
 1. 创建CLLocationManager对象
 2. 请求用户授权 --> 从iOS8开始, 必须在程序中请求用户授权, 除了写代码, 还要配置plist列表的键值
 3. 设置代理 --> 获取用户位置
 4. 调用开始定位方法
 5. 代理方法中停止定位

 */
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
}

#pragma mark - 代理方法
/** 当完成位置更新的时候调用 --> 此方法会频繁调用*/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.lastObject;
    
    NSLog(@"locations: %@",location);
    
    //5. 停止定位
    [self.mgr stopUpdatingLocation];
    
    //locations: <+40.05894607,+116.32944547> +/- 50.00m (speed 0.00 mps / course -1.00) @ 15/12/11 中国标准时间 09:45:28
}

@end

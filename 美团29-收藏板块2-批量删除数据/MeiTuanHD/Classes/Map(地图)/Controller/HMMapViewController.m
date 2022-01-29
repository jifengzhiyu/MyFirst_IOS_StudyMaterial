//
//  HMMapViewController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMMapViewController.h"
#import <MapKit/MapKit.h>
#import "HMBusinessModel.h"
#import "HMAnnotationModel.h"
#import "HMMateTool.h"
#import "HMHomeNavView.h"
#import "HMCategoryViewController.h"
#import "HMCategoryModel.h"

@interface HMMapViewController ()<MKMapViewDelegate, DPRequestDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

/** 位置管理器进行授权操作 --> iOS8以后必须这么做*/
@property (nonatomic, strong) CLLocationManager *locationManager;

/** 地图的模型数据*/
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 通知发送的选中的分类名*/
@property (nonatomic, copy) NSString *selectCategoryName;

/** 分类导航栏 View*/
@property (nonatomic, strong) HMHomeNavView *categorytView;

@end

@implementation HMMapViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 创建位置管理器并授权
    self.locationManager = [CLLocationManager new];
    
    // 授权需要做2件事情: 1. 调用授权方法 2. 配置 plist 键值对
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        // 前台授权的方法 --> 当用户正在使用程序的时候
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // 跟踪用户的位置
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;

    // 设置地图代理
    self.mapView.delegate = self;
    
    
    // 注册分类选择通知
    [HMNotificationCenter addObserver:self selector:@selector(categoryDidChangeNotifacation:) name:  HMCategoryDidChangeNotifacation object:nil];
    
    
    // 导航栏
    self.title = @"地图";
    
    // 返回 item
    UIBarButtonItem *backItem = [UIBarButtonItem barBuutonItemWithTarget:self action:@selector(backButtonClick) icon:@"icon_back" highlighticon:@"icon_back_highlighted"];
    
    // 分类 item
    HMHomeNavView *categoryView = [HMHomeNavView homeNavView];
    // 添加点击方法
    [categoryView addTarget:self action:@selector(categorClick)];
    
    [categoryView setTitle:@"全部分类"];
    [categoryView setSubtitle:@""];
    [categoryView setIcon:@"icon_category_-1" hightIcon:@"icon_category_highlighted_-1"];
    
    self.categorytView = categoryView;
    
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryView];
    
    self.navigationItem.leftBarButtonItems = @[backItem, categoryItem];
}


#pragma mark 分类按钮点击
- (void)categorClick
{
    //1. 内容控制器
    HMCategoryViewController *categoryVC = [HMCategoryViewController new];
    
    //2. 设置 popover 相关的属性
    categoryVC.modalPresentationStyle = UIModalPresentationPopover;
    
    categoryVC.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[1];
    
    //3. 使用普通的模态视图弹出即可
    [self presentViewController:categoryVC animated:YES completion:nil];
}



#pragma mark - 通知相关方法
#pragma mark 分类通知
- (void)categoryDidChangeNotifacation:(NSNotification *)notification
{
    //1. 左边模型
    HMCategoryModel *selectCategoryModel = notification.userInfo[HMSelectCategoryModel];
    //2. 右边子标题
    NSString *selectCategorySubtitle = notification.userInfo[HMSelectCategorySubtitle];
    
    /**
     1. 发送右边 右边有值, 且不等于"全部"
     2. 发送左边 没有子分类数据, 就发送左边 , 且不等于"全部分类"
     3. 不发送 没有需求进行筛选或者 点击了"全部分类"
     */
    
    // 获取选中的分类 --> 为了发送请求
    if (selectCategorySubtitle == nil || [selectCategorySubtitle isEqualToString:@"全部"]) {
        // 发送左边的名字
        self.selectCategoryName = selectCategoryModel.name;
    } else {
        self.selectCategoryName = selectCategorySubtitle;
    }
    
    if ([self.selectCategoryName isEqualToString:@"全部分类"]) {
        self.selectCategoryName = nil;
    }
    
    
    //3.1 获取导航栏 view, 直接更改标题
    [self.categorytView setTitle:selectCategoryModel.name];
    
    //3.2 清空子标题
    [self.categorytView setSubtitle:selectCategorySubtitle];
    
    //3.3 设置图标
    [self.categorytView setIcon:selectCategoryModel.icon hightIcon:selectCategoryModel.highlighted_icon];
    
    //4. 取消 popover 的显示
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    //5. 移除地图的大头针数据
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //6. 移除临时数组的数据
    [self.dataArray removeAllObjects];
    
    //7. 调用接口, 发送分类的参数
    [self mapView:self.mapView regionDidChangeAnimated:YES];
}



#pragma mark 移除观察者
- (void)dealloc
{
    [HMNotificationCenter removeObserver:self];
}



#pragma mark - MapView 代理方法

#pragma mark 当添加大头针模型的时候,返回大头针 View 的方法
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //1. 如果 return nil. 那么就代表, 不需要自定义大头针 View. 系统会按照自己的默认值来处理大头针
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    /**
     1. 大头针的模型是有2种: 1种是系统显示用户位置的大头针模型, 第2中是自定义的大头针模型
     2. 需要判断系统的显示用户位置的大头针, 不需要自定义
     
     MKUserLocation: 
     HMAnnotationModel:
     */
    
//    NSLog(@"%@", annotation);
//    
    static NSString *identifier = @"annotation";
    
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier]; 
    
    if (annoView==nil) {
        annoView= [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        // 一旦实现了自定义大头针的方法, 那么可以点击大头针的属性就失效
        annoView.canShowCallout = YES;
    }
    
    HMAnnotationModel *annoModel = (HMAnnotationModel *)annotation;
    annoView.image = [UIImage imageNamed:annoModel.icon];
    
    return annoView;
    
}



#pragma mark 区域完成改变的方法
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //1. 创建 DPAPI 对象
    DPAPI *dpapi = [DPAPI new];
    
    //2. 拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //2.1 经纬度
    //region: 包含2个参数. 1中心点经纬度 2显示的跨度
    params[@"latitude"] = @(mapView.region.center.latitude);
    params[@"longitude"] = @(mapView.region.center.longitude);
    
    //2.2 分类
    if (self.selectCategoryName) {
        params[@"category"] = self.selectCategoryName;
    }
    
    //3. 发送请求
    [dpapi requestWithURL:@"v1/business/find_businesses" params:params delegate:self];
}

#pragma mark 请求成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //方式一: 添加之前删除之前的大头针的数据
    
    /**
     如果希望大头针数据, 每次只保持一定的数量, 那么可以每次请求后删除之前的数据, 后面的模型判断(第3步)可以不用写 --> 建议使用这种
     如果希望大头针数据, 可以保持很多个, 那么删除旧的代表, 不应该在这里写, 可以放在通知发送请求的地方写
     */
    //0. 每次分类请求删除之前的数据
//    [self.mapView removeAnnotations:self.mapView.annotations];
//    [self.dataArray removeAllObjects];
    
    //1. 获取模型数据
    for (NSDictionary *dict in result[@"businesses"]) {
        [self.dataArray addObject:[HMBusinessModel yy_modelWithJSON:dict]];
    }
    
    //2. 添加大头针
    for (HMBusinessModel *businessModel in self.dataArray) {
        
        HMAnnotationModel *annotaionModel = [HMAnnotationModel new];
        annotaionModel.coordinate = CLLocationCoordinate2DMake(businessModel.latitude, businessModel.longitude);
        annotaionModel.title = businessModel.name;
        annotaionModel.subtitle = businessModel.address;
        
        //图像
//         应该根据 plist 列表来返回对应的图像信息 --> map_icon;map_icon;
        
        annotaionModel.icon = [HMMateTool mapNameWithBusinessModel:businessModel];
        
        //3. 如果已经添加过了, 那么就不添加了
        /**
         containsObject: 内部会调用 isEqual 方法
         isEqual 方法: 比较的是哈希值. 哈希值唯一, 其中包括了时间
         解决方案:重写 isEqual 方法, 自己指定要比较的部分
         比较的是大头针模型数据, 就应该重写此模型的 isEqual 方法
         */
        
        if ([self.mapView.annotations containsObject:annotaionModel]) {
            continue;
        } else {
            [self.mapView addAnnotation:annotaionModel];
        }
        
    }
    NSLog(@"annotations: %ld", self.mapView.annotations.count);
}

#pragma mark 请求失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error: %@", error);
}

#pragma mark 返回按钮
- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

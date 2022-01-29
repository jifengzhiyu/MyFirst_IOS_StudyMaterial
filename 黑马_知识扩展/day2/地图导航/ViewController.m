//
//  ViewController.m
//  地图导航
//
//  Created by 翟佳阳 on 2021/12/28.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *JFdestinationTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark 导航按钮点击
- (IBAction)JFnavigateClick:(id)sender {
   
    //1. 创建CLGeocoder对象
    CLGeocoder *geocoder = [CLGeocoder new];
    
    //2. 调用地理编码方法
    [geocoder geocodeAddressString:self.JFdestinationTF.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //3 防错处理
        if (placemarks.count == 0 || error) {
            NSLog(@"您输入的地址我们没找到!!!");
            
            return;
        }
        
        //遍历数组获取数据 --> 正地理编码, 可能重名, 所以数组数量大于1, 一定要给列表提示用户选择
        NSMutableArray *arr = [NSMutableArray array];
        
        for (CLPlacemark *pm in placemarks) {
            //4. 获取地表对象 暂取最后一个
            
            //5. 创建MKPlacemark对象
            MKPlacemark *mkpm = [[MKPlacemark alloc] initWithPlacemark:pm];
            
            //6. 创建一个MKMapItem
            MKMapItem *destItem = [[MKMapItem alloc] initWithPlacemark:mkpm];
            
            [arr addObject:destItem];
        }
        
        //7. 调用open类方法, 打开导航
        //WithItems: 传入要定位的点
        //launchOptions: 导航参数
        NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey : @(MKMapTypeHybrid), MKLaunchOptionsShowsTrafficKey : @YES};
        
//        [MKMapItem openMapsWithItems:arr launchOptions:options];
        [MKMapItem openMapsWithItems:arr launchOptions:nil];

        
        
    }];
    
    
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

//
//  JFGeocoderViewController.m
//  地理编码和反地理编码
//
//  Created by 翟佳阳 on 2021/12/27.
//

#import "JFGeocoderViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface JFGeocoderViewController ()
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
/** 纬度*/
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
/** 经度*/
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

@end

@implementation JFGeocoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)geocoderClick:(id)sender {
    // CLLocationManager 用户授权/定位
    // CLGeocoder 解码器
    
    //1. 创建一个CLGeocoder对象
    CLGeocoder *geocoder = [CLGeocoder new];
    
    //2. 实现地理编码方法
    [geocoder geocodeAddressString:self.addressTF.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //placemarks : 地标数组 --> 主要的是CLLocation / 城市属性
        
        //3.1 遍历数组
        if (placemarks.count == 0 || error) {
            NSLog(@"解析有问题");
            return ;
        }
        
        // 注意: 地理编码 可能出现重名的问题, 所以将来如果对标对象大于1, 应该给用户一个列表选择
        for (CLPlacemark * placemark in placemarks) {
            NSLog(@"la: %f", placemark.location.coordinate.latitude);
            NSLog(@"long: %f", placemark.location.coordinate.longitude);
            
            NSLog(@"name: %@", placemark.name);
            NSLog(@"city: %@", placemark.locality);

            
            self.latitudeLabel.text = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
            
            self.longitudeLabel.text = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
            self.detailAddressLabel.text = placemark.name;
        }
        
    }];
}

@end

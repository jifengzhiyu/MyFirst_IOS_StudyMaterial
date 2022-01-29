//
//  ViewController.m
//  磁力计
//
//  Created by 翟佳阳 on 2022/1/8.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
///单位特斯拉,不是车
//磁力计:检测磁场变化,主要用于导航
@interface ViewController ()
@property (nonatomic, strong) CMMotionManager *motionMgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //pull,在需要的时候来获取值
    self.motionMgr = [CMMotionManager new];
    //有关硬件的功能都要判断
    if(![self.motionMgr isMagnetometerAvailable]){
        return;
    }
    
    //采样
    [self.motionMgr startMagnetometerUpdates];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //pull,在需要的时候来获取值
    //运动管理器会记录所有的值,在自己的属性中
    CMMagneticField magneticField = self.motionMgr.magnetometerData.magneticField;
    NSLog(@"x:%f, y:%f,z:%f",magneticField.x,magneticField.y,magneticField.z);
}
@end

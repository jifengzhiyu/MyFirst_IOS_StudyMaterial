//
//  ViewController.m
//  陀螺仪
//
//  Created by 翟佳阳 on 2022/1/8.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (nonatomic, strong) CMMotionManager *motionMgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self push];
    //pull,在需要的时候来获取值
    self.motionMgr = [CMMotionManager new];
    //有关硬件的功能都要判断
    if(![self.motionMgr isGyroAvailable]){
        return;
    }
    
    //采样
    [self.motionMgr startGyroUpdates];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //pull,在需要的时候来获取值
    //运动管理器会记录所有的值,在自己的属性中
    CMRotationRate rotationRate = self.motionMgr.gyroData.rotationRate;
    NSLog(@"x:%f, y:%f,z:%f",rotationRate.x,rotationRate.y,rotationRate.z);
}

- (void)push{
    self.motionMgr = [CMMotionManager new];
    //有关硬件的功能都要判断
    if(![self.motionMgr isGyroAvailable]){
        return;
    }
    
    //3,设置采样间隔单位是秒--->只有push需要
    self.motionMgr.gyroUpdateInterval = 1;
    
    //采样
    //加速计的Push方式-->只要系统获取到了值,就会返回给你
    [self.motionMgr startGyroUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        CMRotationRate rotationRate  = gyroData.rotationRate;
        NSLog(@"x:%f, y:%f,z:%f",rotationRate.x,rotationRate.y,rotationRate.z);

    }];
}
@end

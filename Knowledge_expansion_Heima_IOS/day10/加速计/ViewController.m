//
//  ViewController.m
//  加速计
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
    
    //pull,在需要的时候来获取值
    self.motionMgr = [CMMotionManager new];
    //有关硬件的功能都要判断
    if(![self.motionMgr isAccelerometerAvailable]){
        return;
    }
    
    //采样
    [self.motionMgr startAccelerometerUpdates];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //pull,在需要的时候来获取值
    //运动管理器会记录所有的值,在自己的属性中
    CMAcceleration acceleration = self.motionMgr.accelerometerData.acceleration;
    NSLog(@"x:%f, y:%f,z:%f",acceleration.x,acceleration.y,acceleration.z);
}

- (void)accelerometerPush{
    self.motionMgr = [CMMotionManager new];
    //有关硬件的功能都要判断
    if(![self.motionMgr isAccelerometerAvailable]){
        return;
    }
    
    //3,设置采样间隔单位是秒--->只有push需要
    self.motionMgr.accelerometerUpdateInterval = 1;
    
    //采样
    //加速计的Push方式-->只要系统获取到了值,就会返回给你
    [self.motionMgr startAccelerometerUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            NSLog(@"%@",accelerometerData);
    }];
}


@end 

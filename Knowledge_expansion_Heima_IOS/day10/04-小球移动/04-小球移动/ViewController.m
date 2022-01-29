//
//  ViewController.m
//  04-小球移动
//
//  Created by dream on 15/12/22.
//  Copyright © 2015年 dream. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ballView;

/** 运动管理器*/
@property (nonatomic, strong) CMMotionManager *motionManager;

/** 此属性用来记录加速计的值*/
@property (nonatomic, assign) CGPoint ballPoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     思路分析
     1. 涉及到了x, y轴
     2. 加速计的x, y值 来进行叠加 --> CoreMotion push方式的加速计
     3. 叠加之后赋值给frame即可
     4. 需要属性来记录加速计的两个值
     */
    
    //1. 创建管理器对象
    self.motionManager = [CMMotionManager new];
    
    //2. 判断加速计是否可用
    if (![self.motionManager isAccelerometerAvailable]) {
        NSLog(@"不能");
        return;
    }
    
    //3. 设置采样间隔
    self.motionManager.accelerometerUpdateInterval = 1.0 / 20.0;
    
    //4. 开始采样 --> push方式, 使用的是下面这种方式
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error: %@",error);
            return;
        }
        
        // 5. 调用方法, 来完成小球相关的逻辑代码
        [self accelerationUpdate:accelerometerData.acceleration];
    }];
    
}


#pragma mark 此方法处理小球相关的逻辑
- (void)accelerationUpdate:(CMAcceleration)acceleration {
    //更改小球的位置变化 --> 值从加速计的值来获取的
    //Frame    加速计的值  叠加值
    //100  --> 1   --> 101
    //101 --> 3 --> 104
    //104 --> 5  --> 109
    
    // 如果不发生运动, 加速计的值, 默认在1~-1之间
    
    //1. 叠加加速计的值 --> 才能有用加速的效果
//    _ballPoint.x =
    
    CGRect frame = self.view.frame;
    frame.size.height = 30;
    self.view.frame = frame;
    
//    self.ballPoint.x =3;
    //结构体不能直接改变值，需要加_
    _ballPoint.x += acceleration.x;
    _ballPoint.y -= acceleration.y;
    
    // 上一次的速度 + 加速度 = 当前的速度
    // 上一次的位置 + 位移 = 当前的位置
    // ballPoint.x 和 ballPoint.y 存放的是速度
    // ballFrame.x 和 ballFrame.y 存放的是位置
    // 位移 = 速度 * 时间
    
    NSLog(@"_ballPoint: %@",NSStringFromCGPoint(self.ballPoint));
    
    //2. 修改Frame
    CGRect ballFrame = self.ballView.frame;
    ballFrame.origin.x += _ballPoint.x;
    ballFrame.origin.y += _ballPoint.y;
    
    //判断边界的问题
    if (ballFrame.origin.x <= 0) {
        
        //99 -100 ==-1?
        //0 + 100 = 100
        ballFrame.origin.x = 0;
        
        //在这里将小球的加速值取反 --> 为的是更改下一次的frame --> 模拟了碰撞现象
        //还要进行*= 0.7 操作, 以为着反弹之后, 小球不会返回原来的位置 --> 模拟重力现象
        _ballPoint.x *= -0.7;
    } else if (ballFrame.origin.x > (self.view.frame.size.width - ballFrame.size.width)) {
        
        //374 + 100 = 474?
        //375 - 100 = 275
        
        ballFrame.origin.x = self.view.frame.size.width - ballFrame.size.width;
        _ballPoint.x *= -0.7;
    }
    
    if (ballFrame.origin.y <= 0) {
    
        ballFrame.origin.y = 0;
        _ballPoint.y *= -0.7;
    } else if (ballFrame.origin.y > (self.view.frame.size.height - ballFrame.size.height)) {
        
        ballFrame.origin.y = self.view.frame.size.height - ballFrame.size.height;
        _ballPoint.y *= -0.7;
    }
    
    
    //3. 重设frame 主界面中更新
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.ballView.frame = ballFrame;
    });
}

@end

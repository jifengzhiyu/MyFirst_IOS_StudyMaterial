//
//  ViewController.m
//  06-计步器
//
//  Created by dream on 15/12/22.
//  Copyright © 2015年 dream. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) CMPedometer *pedometer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 判断硬件是否可用
    if (![CMPedometer isStepCountingAvailable]) {
        return;
    }
    
    //2. 创建计步器的类
    self.pedometer = [CMPedometer new];
    
    //3. 开始计步统计
    //[NSDate date]当前时间
    [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        
        
        // 4. 主线程中去更新UI
        NSNumber *number = pedometerData.numberOfSteps;
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:number waitUntilDone:NO];
        
    }];
}

- (void)updateUI:(NSNumber *)number
{
    self.label.text = [NSString stringWithFormat:@"您当前一共走了%@步",number];
}



@end

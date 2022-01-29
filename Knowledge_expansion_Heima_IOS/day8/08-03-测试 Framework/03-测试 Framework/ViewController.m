//
//  ViewController.m
//  03-测试 Framework
//
//  Created by Romeo on 15/9/24.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import <HMFramework/HMFramework.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HMTool sayHello];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

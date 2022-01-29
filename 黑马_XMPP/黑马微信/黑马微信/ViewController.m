//
//  ViewController.m
//  黑马微信
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //登陆
    [[HMManagerStream shareMananger] loginToserver:[XMPPJID jidWithUser:@"lisi" domain:@"heima.itcast.cn" resource:nil] andPassWord:@"123"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  04-边开发边调试 Framework
//
//  Created by Romeo on 15/9/24.
//  Copyright © 2015年 itheima. All rights reserved.
//

/**
 Framework静态库, 边开发边调试 --> 静态库没有生成, 不区分动态还是静态
 1. 头文件, 不需要使用<>, 使用常规的""
 2. 因为没有生成静态库/动态库, 所以不需要手动设置编译二进制的选项
 
 
 */

#import "ViewController.h"
#import "HMTool.h"

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

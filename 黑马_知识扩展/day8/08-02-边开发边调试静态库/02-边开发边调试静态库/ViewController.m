//
//  ViewController.m
//  02-边开发边调试静态库
//
//  Created by Romeo on 15/9/24.
//  Copyright © 2015年 itheima. All rights reserved.
//

/**
 边开发边调试
 1. 安装常规创建项目即可
 2. 开发静态库--> 添加 Target
 3. 使用时, 头文件及方法正常调用. 编译运行时, 一定要记得导入. a 文件
 
 小区别
 1. 如果使用此种方式进行开发, 实际上静态库文件根本没有被编译, 直接可以使用
 2. 如果要导出, 还需要按照以前的方式进行编译. a 注意切换 Target
 */

#import "ViewController.h"
#import "HeiMaLib.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%ld",[HeiMaLib sum1:250 addSum2:38]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

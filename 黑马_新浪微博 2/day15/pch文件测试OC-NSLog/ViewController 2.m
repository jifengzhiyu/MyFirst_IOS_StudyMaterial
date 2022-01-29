//
//  ViewController.m
//  pch文件测试OC-NSLog
//
//  Created by 翟佳阳 on 2021/12/24.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
// 自定义log输出，debug时，正常NSLog输出，release状态，为空，不打印
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", @"hello");

}


@end

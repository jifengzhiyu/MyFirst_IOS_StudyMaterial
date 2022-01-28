//
//  ViewController.m
//  day2多控制器管理
//
//  Created by 翟佳阳 on 2021/9/28.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIApplication *app = [UIApplication sharedApplication];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    NSLog(@"go style");
    return UIStatusBarStyleLightContent;
}



@end

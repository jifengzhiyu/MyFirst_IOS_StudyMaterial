//
//  ViewController.m
//  获取沙盒目录
//
//  Created by 翟佳阳 on 2021/10/24.
//

#import "ViewController.h"
#import "NSString+sandBox.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *path = @"http://www.baidu.com/images/01.jpg";
    
    NSLog(@"%@",[path appendCache]);
}


@end

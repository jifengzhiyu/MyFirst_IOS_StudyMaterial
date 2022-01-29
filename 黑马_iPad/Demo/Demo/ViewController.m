//
//  ViewController.m
//  Demo
//
//  Created by 翟佳阳 on 2022/1/12.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    NSDictionary *dic = @{@"aaa" : @(10), @"bbb" : @11};
    
    NSLog(@"%@",[dic[@"aaa"] class]);
}

//NSConstantIntegerNumber
@end

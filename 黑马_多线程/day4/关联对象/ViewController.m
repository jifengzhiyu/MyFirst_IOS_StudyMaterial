//
//  ViewController.m
//  关联对象
//
//  Created by 翟佳阳 on 2021/10/26.
//

#import "ViewController.h"
#import "UIImageView+MyView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imgView = [UIImageView new];
    imgView.urlString = @"aaaaaaaa";
    NSLog(@"%@",imgView.urlString);
}


@end

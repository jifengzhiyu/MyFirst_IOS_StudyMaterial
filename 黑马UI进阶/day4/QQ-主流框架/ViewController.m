//
//  ViewController.m
//  QQ-主流框架
//
//  Created by 翟佳阳 on 2021/10/3.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"32"];
    [imageView sizeToFit];
    [self.view addSubview:imageView];
    
}


@end

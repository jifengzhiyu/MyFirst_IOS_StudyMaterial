//
//  ViewController.m
//  day5
//
//  Created by 翟佳阳 on 2021/10/3.
//

#import "ViewController.h"
#import "TestViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //跳转到testViewController
    //通过modal的形式跳转
    TestViewController *vc = [[TestViewController alloc] init];
    
    //设置跳转方式
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:vc animated:YES completion:^{
            NSLog(@"跳转完成");
    }];
}

@end

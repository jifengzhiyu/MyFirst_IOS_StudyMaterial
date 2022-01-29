//
//  SecondViewController.m
//  SecondViewController
//
//  Created by Huawei on 2021/9/8.
//

#import "SecondViewController.h"
#import "ViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

// 点击按钮 改变 vc1 中的某个数据
- (IBAction)changeDataInVCBtnClicked:(id)sender {
    NSLog(@"改变 vc1 中的某个数据");
//    if (nil != _firstVC) {
//        [_firstVC changePaymentLabel];
//    }
    
    if (nil != _delegate) {
        [_delegate orderChangeToPaidState];
    }
}

// 退出当前窗口 返回到第一个窗口 看看数据改变没有
- (IBAction)dismissBtnClicked:(id)sender {
    NSLog(@"当前窗口取消");
    [self dismissViewControllerAnimated: YES completion:^{
       // 退出当前窗口操作后 执行的代码段写在这里
        NSLog(@"已经退出第二个窗口了");
    }];
    
    // navigation controller - push pop
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end

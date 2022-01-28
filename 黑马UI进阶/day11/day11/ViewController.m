//
//  ViewController.m
//  day11
//
//  Created by 翟佳阳 on 2021/10/11.
//

#import "ViewController.h"
#import "JFRotateView.h"
@interface ViewController () <JFRotateViewDelegate>
@property (nonatomic, weak) JFRotateView *rotateView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置控制器view背景 拉伸
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"LuckyBackground"].CGImage;
    
    //创建转盘
    JFRotateView *rotateView = [JFRotateView roteView];
    self.rotateView = rotateView;
    rotateView.center = self.view.center;
    [self.view addSubview:rotateView];
    
    //旋转
    [rotateView startRotate];
    //设置代理
    rotateView.delegate = self;
    
    
}

- (void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜中奖" message:@"您中了五百万美金" preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               self.rotateView.link.paused = NO;

           }];
    
    
           [alert addAction:conform];
           //显示对话框
           [self presentViewController:alert animated:YES completion:nil];
}

@end

//
//  ViewController.m
//  手动创建UIWindw
//
//  Created by 翟佳阳 on 2021/9/29.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//手动创建UIWindow
-(IBAction)addWindowBtnClick:(UIButton *)sender{
    //创建窗口
    UIWindow *redW = [[UIWindow alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
    
    redW.backgroundColor = [UIColor redColor];
    redW.hidden = NO;
    [self.view addSubview:redW];
    
    //创建按钮(+号按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //监听按钮的点击事件
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [redW addSubview:btn];
}



- (void)btnClick{
    NSLog(@"按钮被点击了");
}

@end

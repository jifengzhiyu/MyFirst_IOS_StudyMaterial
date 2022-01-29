//
//  ViewController.m
//  03动态创建按钮
//
//  Created by 翟佳阳 on 2021/8/30.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建按钮,按钮类创建按钮对象
    UIButton * button = [[UIButton alloc] init];
    
    //使用自定义方式创建按钮
    //UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //设置按钮文字
    //默认情况显示文字
    [button setTitle:@"点我" forState:UIControlStateNormal];
    //高亮情况下显示文字
    [button setTitle:@"爱你??" forState:UIControlStateHighlighted];
    
    //文字颜色显示
    //默认状态红色
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //高亮状态白色
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    //加载图片
    UIImage * imgNormal = [UIImage imageNamed:@"iShot2021-08-27 18.06.07"];
    UIImage * imgHighlighted = [UIImage imageNamed:@"iShot2021-08-27 18.06.46"];
    //默认以及高亮状态下背景图片

    [button setBackgroundImage:imgNormal forState:UIControlStateNormal];
    
    [button setBackgroundImage:imgHighlighted forState:UIControlStateHighlighted];
    
    //设置frame
    button.frame = CGRectMake(50, 50, 100, 100);
    
    //通过代码为按钮注册一个单击事件
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //把动态创建的按钮加到控制器所管理的那个view中
    [self.view addSubview:button];
    
}


//没有实际拖线
- (void)buttonClick
{
    NSLog(@"ahhaha");
}


@end

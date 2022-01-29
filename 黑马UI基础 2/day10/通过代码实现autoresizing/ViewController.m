//
//  ViewController.m
//  通过代码实现autoresizing
//
//  Created by 翟佳阳 on 2021/9/22.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)btnClick;
@property (nonatomic,weak)UIView *blueVw;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1、创建一个蓝色view
    UIView *blueVw = [[UIView alloc] init];
    //设置背景色
    blueVw.backgroundColor = [UIColor blueColor];
    //设置frame
    blueVw.frame = CGRectMake(0, 0, 200, 200);
    //添加到控制器
    [self.view addSubview:blueVw];
    self.blueVw = blueVw;
    
    //2、创建一个红色view
    UIView *redVw = [[UIView alloc] init];
    redVw.backgroundColor = [UIColor redColor];
  
    CGFloat redW = blueVw.frame.size.width;
    CGFloat redH = 50;
    CGFloat redX = 0;
    CGFloat redY = blueVw.frame.size.height - redH;
    redVw.frame = CGRectMake(redX, redY, redW, redH);
    //把红色view添加到蓝色view
    [blueVw addSubview:redVw];
    
    //设置autoresizing
    //设置红色view距离蓝色view底部距离不变
    redVw.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    //两者同时设定,该枚举是位枚举
    
}

//按钮单击事件
//每次增加蓝色view的高度和宽度
- (IBAction)btnClick {
    CGRect blueFrame = self.blueVw.frame;
    blueFrame.size.height += 20;
    blueFrame.size.width += 20;
    self.blueVw.frame = blueFrame;
    
}
@end
